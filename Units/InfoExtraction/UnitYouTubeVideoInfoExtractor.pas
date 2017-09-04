{ *
  * Copyright (C) 2014-2017 ozok <ozok26@gmail.com>
  *
  * This file is part of TVideoDownloader.
  *
  * TVideoDownloader is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * TVideoDownloader is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with TVideoDownloader.  If not, see <http://www.gnu.org/licenses/>.
  *
  * }
unit UnitYouTubeVideoInfoExtractor;

interface

uses
  Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils, Generics.Collections,
  UnitImageResize, UnitCommonTypes, UnitImageTypeExtractor, System.Json, System.IOUtils,
  Jpeg, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  UnitCommonMethods;

type
  TStatus = (stReading, stDone);

type
  TTypeInfo = record
    ID: string;
    Info: string;
  end;

type
  TYouTubeVideoInfoExtractor = class(TObject)
  private
    FFormatProcess: TJvCreateProcess;
    FPlayListProcess: TJvCreateProcess;
    FSubtitleProcess: TJvCreateProcess;
    FFormatStatus: TStatus;
    FPlayListStatus: TStatus;
    FSubtitleStatus: TStatus;
    FURL: string;
    FYTPath: string;
    FFormatList: TList<TFormadItem>;
    FImageName: string;
    FTempFolder: string;
    FFileName: string;
    FOutExt: TStringList;
    FPlayListVideoLinks: TStringList;
    FSubtitles: TStringList;
    FURLType: TLinkType;
    FPass: TUserPass;
    FDownloadImg: Boolean;
    FPlaylistFoundVideos: integer;
    procedure FormatProcessTerminate(Sender: TObject; ExitCode: Cardinal);
    procedure PlaylistProcessTerminate(Sender: TObject; ExitCode: Cardinal);
    procedure SubtitleProcessTerminate(Sender: TObject; ExitCode: Cardinal);
    procedure PlaylistProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure ResizeImg;
  public
    property FormatStatus: TStatus read FFormatStatus;
    property PlaylistStatus: TStatus read FPlayListStatus;
    property FormatList: TList<TFormadItem> read FFormatList;
    property ImageName: string read FImageName;
    property FileName: string read FFileName;
    property OutExt: TStringList read FOutExt;
    property PlayListVideoLinks: TStringList read FPlayListVideoLinks;
    property Subtitles: TStringList read FSubtitles;
    property SubtitleStatus: TStatus read FSubtitleStatus;
    property LinkType: TLinkType read FURLType;
    property PlaylistFoundVideosCount: integer read FPlaylistFoundVideos;
    property Process1: TJvCreateProcess read FFormatProcess;
    property Process4: TJvCreateProcess read FSubtitleProcess;
    constructor Create(const URL: string; const YTPath: string; const TempFolder: string; const UserPass: TUserPass; const DownloadImg: Boolean);
    destructor Destroy(); override;
    procedure Start();
    procedure Start4();
    procedure StopAll();
    procedure GetPlayListInfo();
  end;

implementation

uses
  UnitSettings, UnitLogs;

{ TYouTubeVideoInfoExtractor }

constructor TYouTubeVideoInfoExtractor.Create(const URL: string; const YTPath: string; const TempFolder: string; const UserPass: TUserPass; const DownloadImg: Boolean);
begin
  inherited Create;

  FFormatProcess := TJvCreateProcess.Create(nil);
  with FFormatProcess do
  begin
    OnTerminate := FormatProcessTerminate;
    ConsoleOptions := [coRedirect];
    CreationFlags := [cfUnicode];
    Priority := ppIdle;

    with StartupInfo do
    begin
      DefaultPosition := False;
      DefaultSize := False;
      DefaultWindowState := False;
      ShowWindow := swHide;
    end;

    WaitForTerminate := true;
  end;

  FPlayListProcess := TJvCreateProcess.Create(nil);
  with FPlayListProcess do
  begin
    OnTerminate := PlaylistProcessTerminate;
    OnRead := PlaylistProcessRead;
    ConsoleOptions := [coRedirect];
    CreationFlags := [cfUnicode];
    Priority := ppIdle;

    with StartupInfo do
    begin
      DefaultPosition := False;
      DefaultSize := False;
      DefaultWindowState := False;
      ShowWindow := swHide;
    end;

    WaitForTerminate := true;
  end;

  FSubtitleProcess := TJvCreateProcess.Create(nil);
  with FSubtitleProcess do
  begin
    OnTerminate := SubtitleProcessTerminate;
    ConsoleOptions := [coRedirect];
    CreationFlags := [cfUnicode];
    Priority := ppIdle;

    with StartupInfo do
    begin
      DefaultPosition := False;
      DefaultSize := False;
      DefaultWindowState := False;
      ShowWindow := swHide;
    end;

    WaitForTerminate := False;
  end;

  FFormatStatus := stReading;
  FPlayListStatus := stReading;
  FSubtitleStatus := stReading;
  FURL := URL;
  FYTPath := YTPath;
  FFormatList := TList<TFormadItem>.Create;
  FTempFolder := TempFolder;
  FPlayListVideoLinks := TStringList.Create;
  FOutExt := TStringList.Create;
  FSubtitles := TStringList.Create;
  FSubtitles.StrictDelimiter := true;
  FSubtitles.Add('Do not download subtitles');
  FPass := UserPass;
  FDownloadImg := DownloadImg;
end;

destructor TYouTubeVideoInfoExtractor.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FFormatList);
  FFormatProcess.Free;
  FPlayListProcess.Free;
  FPlayListVideoLinks.Free;
  FSubtitleProcess.Free;
  FOutExt.Free;
  FSubtitles.Free;
end;

procedure TYouTubeVideoInfoExtractor.GetPlayListInfo;
var
  LPass: string;
begin
  FPlaylistFoundVideos := 0;
  FPlayListProcess.ApplicationName := FYTPath;
  if (Length(FPass.UserName) > 0) and (Length(FPass.Password) > 0) then
  begin
    LPass := ' -u ' + FPass.UserName + ' -p ' + FPass.Password;
  end;
  FPlayListProcess.CommandLine := ' ' + LPass + ' -s --skip-download --get-id "' + FURL + '"';
  FPlayListProcess.Run;
end;

procedure TYouTubeVideoInfoExtractor.PlaylistProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
begin
  FPlaylistFoundVideos := FPlayListProcess.ConsoleOutput.Count;
end;

procedure TYouTubeVideoInfoExtractor.FormatProcessTerminate(Sender: TObject; ExitCode: Cardinal);
var
  LMainJsonObject: TJSONObject;
  LThumbnailsJsonArray: TJSONArray;
  LFormatsJsonArray: TJSONArray;
  LFormatJsonObject: TJSONObject;
  idx: integer;
  idy: integer;
  i: Integer;
  LThumbnailJsonObject: TJSONObject;
  j: Integer;
  LMS: TMemoryStream;
  LURl: string;
  LFormatItem: TFormadItem;
  LIdHttp: TIdHTTP;
  LSSL: TIdSSLIOHandlerSocketOpenSSL;
  LFileNameJsonPair: TJSONPair;
  LSingeThumb: TJSONPair;
begin
  FFormatStatus := stReading;
  try
    try
      LMainJsonObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FFormatProcess.ConsoleOutput.Text), 0) as TJSONObject;
      try
        LFileNameJsonPair := TJSONPair(LMainJsonObject.Get('_filename').JsonValue);
        FFileName := ChangeFileExt(LFileNameJsonPair.JsonString.ToString, '');

        LThumbnailsJsonArray := TJSONArray(LMainJsonObject.Get('thumbnails').JsonValue);
        for i := 0 to Pred(LThumbnailsJsonArray.Count) do
        begin
          LThumbnailJsonObject := TJSONObject(LThumbnailsJsonArray.Items[i]);
          for j := 0 to Pred(LThumbnailJsonObject.Count) do
          begin
            if Length(LThumbnailJsonObject.Pairs[i].JsonValue.ToString) > 3 then
            begin
              LURl := LThumbnailJsonObject.Pairs[i].JsonValue.ToString;
              Break;
            end;
          end;
        end;
        if Length(LURl) < 1 then
        begin
          LSingeThumb := TJSONPair(LMainJsonObject.Get('thumbnail').JsonValue);
          LURl := LSingeThumb.JsonString.ToString;
        end;

        LogForm.Main.Lines.Add('Thumb link: ' + LURl);

        if FDownloadImg then
        begin
          FImageName := FTempFolder + '\' + CreateTempFileName + '.jpg';
          try
            LMS := TMemoryStream.Create;

            LIdHttp := TIdHTTP.Create();
            LSSL := TIdSSLIOHandlerSocketOpenSSL.Create();
            try
              LIdHttp.IOHandler := LSSL;

              try
                LIdHttp.Get(LURl.Replace('"', ''), LMS);
                LMS.Position := 0;
                LMS.SaveToFile(FImageName);
                ResizeImg;
              except
                on E: Exception do
                begin
                  FImageName := '';
                  LogForm.Main.Lines.Add('Error while downloading thumb: ' + E.Message);
                end;
              end;
            finally
              LIdHttp.Free;
              LSSL.Free;
            end;
          finally
            LMS.Free;
          end;
        end
        else
        begin
          FImageName := '';
        end;

        LFormatsJsonArray := TJSONArray(LMainJsonObject.Get('formats').JsonValue);
        for idx := 0 to pred(LFormatsJsonArray.Count) do
        begin
          LFormatJsonObject := TJSONObject(LFormatsJsonArray.Items[idx]);
          LFormatItem := TFormadItem.Create;
          for idy := 0 to pred(LFormatJsonObject.Count) do
          begin
            if LFormatJsonObject.Pairs[idy].JsonString.ToString.Trim = '"format_id"' then
            begin
              LFormatItem.Id := LFormatJsonObject.Pairs[idy].JsonValue.ToString;
            end
            else if LFormatJsonObject.Pairs[idy].JsonString.ToString.Trim = '"format"' then
            begin
              LFormatItem.Desc := LFormatJsonObject.Pairs[idy].JsonValue.ToString.Replace('"', '');
            end
            else if LFormatJsonObject.Pairs[idy].JsonString.ToString.Trim = '"ext"' then
            begin
              LFormatItem.Ext := LFormatJsonObject.Pairs[idy].JsonValue.ToString.Replace('"', '');
            end
            else if LFormatJsonObject.Pairs[idy].JsonString.ToString.Trim = '"vcodec"' then
            begin
              LFormatItem.VideoCodec := LFormatJsonObject.Pairs[idy].JsonValue.ToString.Replace('"', '');
            end
            else if LFormatJsonObject.Pairs[idy].JsonString.ToString.Trim = '"acodec"' then
            begin
              LFormatItem.AudioCodec := LFormatJsonObject.Pairs[idy].JsonValue.ToString.Replace('"', '');
            end;
          end;
          FFormatList.Add(LFormatItem);
        end;
      finally
        LMainJsonObject.Free;
      end;
    except
      on E: Exception do
      begin
        LogForm.Main.Lines.Add('Json parsing error: ' + E.Message);
      end;
    end;
  finally
    FFormatStatus := stDone;
  end;
end;

procedure TYouTubeVideoInfoExtractor.PlaylistProcessTerminate(Sender: TObject; ExitCode: Cardinal);
var
  i: integer;
begin
  FPlayListStatus := stReading;
  for i := 0 to FPlayListProcess.ConsoleOutput.Count - 1 do
  begin
    if Length(Trim(FPlayListProcess.ConsoleOutput[i])) > 3 then
    begin
      FPlayListVideoLinks.Add(FPlayListProcess.ConsoleOutput[i]);
    end;
  end;
  FPlayListStatus := stDone;
end;

procedure TYouTubeVideoInfoExtractor.SubtitleProcessTerminate(Sender: TObject; ExitCode: Cardinal);
const
  SUB_STR = 'Available subtitles for ';
var
  LSubLine: string;
  i: integer;
  LStartIndex: integer;
begin
  FSubtitleStatus := stReading;
  try
    if Assigned(FSubtitleProcess) then
    begin
      if Assigned(FSubtitleProcess.ConsoleOutput) then
      begin
        // look for the subtitles in console output
        LStartIndex := -1;
        for i := 0 to FSubtitleProcess.ConsoleOutput.Count - 1 do
        begin
          LSubLine := Trim(FSubtitleProcess.ConsoleOutput[i]);
          if LSubLine.StartsWith(SUB_STR) then
          begin
            LStartIndex := i;
            Break;
          end;
        end;
        // means found a sub
        if LStartIndex > -1 then
        begin
          for i := LStartIndex + 2 to FSubtitleProcess.ConsoleOutput.Count - 1 do
          begin
            LSubLine := Trim(FSubtitleProcess.ConsoleOutput[i]);
            if Length(LSubLine) > 0 then
            begin
              FSubtitles.Add(LSubLine.Replace('vtt, ttml', '').Trim);
            end;
          end;
        end;
      end;
    end;
  finally
    if Assigned(FSubtitles) then
    begin
//      FSubtitles.Insert(0, 'Do not download subtitles');
    end;
    FSubtitleStatus := stDone;
  end;
end;

procedure TYouTubeVideoInfoExtractor.ResizeImg;
var
  LIR: TImageResizer;
begin
  LIR := TImageResizer.Create(FImageName, FImageName);
  try
    LIR.Resize;
  finally
    LIR.Free;
  end;
end;

procedure TYouTubeVideoInfoExtractor.Start;
var
  LPass: string;
begin
  FFormatProcess.ApplicationName := FYTPath;
  if (Length(FPass.UserName) > 0) and (Length(FPass.Password) > 0) then
  begin
    LPass := ' -u ' + FPass.UserName + ' -p ' + FPass.Password;
  end;
  FFormatProcess.CommandLine := ' ' + LPass + ' -j -o "' + SettingsForm.FilePatternList.Text + '" "' + FURL + '"';
  FFormatProcess.Run;
//  Start2;
//  Start3;
  Start4;
end;

procedure TYouTubeVideoInfoExtractor.Start4;
var
  LPass: string;
begin
  FSubtitleProcess.ApplicationName := FYTPath;
  if (Length(FPass.UserName) > 0) and (Length(FPass.Password) > 0) then
  begin
    LPass := ' -u ' + FPass.UserName + ' -p ' + FPass.Password;
  end;
  FSubtitleProcess.CommandLine := ' ' + LPass + ' -s --skip-download -i --list-subs --no-playlist --playlist-start 1 --playlist-end 1 "' + FURL + '"';
  FSubtitleProcess.Run;
end;

procedure TYouTubeVideoInfoExtractor.StopAll;
begin
  if FFormatProcess.ProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(FFormatProcess.ProcessInfo.hProcess, 0)
  end;
  if FPlayListProcess.ProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(FPlayListProcess.ProcessInfo.hProcess, 0)
  end;
  if FSubtitleProcess.ProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(FSubtitleProcess.ProcessInfo.hProcess, 0)
  end;
end;

end.


