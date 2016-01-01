unit UnitYoutubedlUpdateChecker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdThreadComponent,
  JvComponentBase, JvThread, Vcl.ComCtrls, Vcl.Samples.Gauges;

type
  TYoutubedlUpdateChecker = class(TForm)
    OutputList: TMemo;
    sButton1: TButton;
    Downloader: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    DownloadBtn: TButton;
    UpdateThread: TJvThread;
    ProgressBar: TGauge;
    procedure sButton1Click(Sender: TObject);
    procedure DownloadBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateThreadExecute(Sender: TObject; Params: Pointer);
    procedure DownloaderWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure DownloaderWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure DownloaderWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    { Private declarations }
    FWorkSize: int64;
  public
    { Public declarations }
    Path: string;
  end;

var
  YoutubedlUpdateChecker: TYoutubedlUpdateChecker;

const
  DOWNLOAD_PAGE_URL = 'https://rg3.github.io/youtube-dl/download.html';

implementation

{$R *.dfm}

uses
  UnitMain;

procedure TYoutubedlUpdateChecker.DownloaderWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  LPercent: integer;
begin
  if FWorkSize > 0 then
  begin
    LPercent := (100 * AWorkCount) div FWorkSize;
    ProgressBar.Progress := LPercent;
  end;
end;

procedure TYoutubedlUpdateChecker.DownloaderWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  FWorkSize := AWorkCountMax;
end;

procedure TYoutubedlUpdateChecker.DownloaderWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
var
  LPath: string;
begin
  LPath := ChangeFileExt(Path, '.tmp');
  if FileExists(LPath) then
  begin

  end;
end;

procedure TYoutubedlUpdateChecker.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Downloader.Connected then
  begin
    Downloader.Disconnect;
  end;
  MainForm.Enabled := True;
end;

procedure TYoutubedlUpdateChecker.FormShow(Sender: TObject);
begin
  DownloadBtn.Enabled := True;
  OutputList.Lines.Clear;
  ProgressBar.Progress := 0;
  FWorkSize := 0;
end;

procedure TYoutubedlUpdateChecker.sButton1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TYoutubedlUpdateChecker.UpdateThreadExecute(Sender: TObject; Params: Pointer);
const
  MATCH_LINE = '">Windows exe</a>';
var
  LMS: TMemoryStream;
  LSR: TStreamReader;
  LLine: string;
  LPos: integer;
  LFS: TFileStream;
  LPath: string;
begin
  OutputList.Lines.Add('[' + DateTimeToStr(Now) + '] Starting the update process.');
  DownloadBtn.Enabled := False;
  try
    LMS := TMemoryStream.Create;
    try
      OutputList.Lines.Add('[' + DateTimeToStr(Now) + '] Extracting youtube-dl.exe link...');
      Downloader.Get(DOWNLOAD_PAGE_URL, LMS);
      LMS.Seek(0, soBeginning);
      LSR := TStreamReader.Create(LMS);
      try
        while not LSR.EndOfStream do
        begin
          Application.ProcessMessages;
          LLine := LSR.ReadLine;
          if LLine.contains(MATCH_LINE) then
          begin
            Break;
          end;
        end;
        if LLine.Length > 0 then
        begin
          LPos := Pos(MATCH_LINE, LLine);
          LLine := LLine.Substring(0, LPos - 1);
          LLine := StringReplace(LLine, '<a href="', '', []).Trim;
          OutputList.Lines.Add('[' + DateTimeToStr(Now) + '] Link: ' + LLine);

          try
            LPath := ChangeFileExt(Path, '.tmp');
            if FileExists(LPath) then
            begin
              DeleteFile(LPath);
            end;
            LFS := TFileStream.Create(Path, fmCreate);
            try
              OutputList.Lines.Add('[' + DateTimeToStr(Now) + '] Downloading the latest version...');
              Downloader.Get(LLine, LFS);
              if FileExists(Path) then
              begin
                DeleteFile(Path);
              end;
              RenameFile(LPath, Path);
              OutputList.Lines.Add('[' + DateTimeToStr(Now) + '] Downloaded the latest version.');
            except
              on E: Exception do
                OutputList.Lines.Add('[' + DateTimeToStr(Now) + '] Error: ' + E.Message);
            end;
          finally
            LFS.Free;
          end;
        end
        else
        begin
          OutputList.Lines.Add('[' + DateTimeToStr(Now) + '] Unable to get the link. Connect the author please.');
        end;
      finally
        LSR.Close;
        LSR.Free;
      end;
    except
      on E: Exception do
        OutputList.Lines.Add('[' + DateTimeToStr(Now) + '] Error: ' + E.Message)
    end;
  finally
    LMS.Free;
    DownloadBtn.Enabled := True;
  end;

  UpdateThread.CancelExecute;
  if Params <> nil then
  begin
    Application.Terminate;
  end;
end;

procedure TYoutubedlUpdateChecker.DownloadBtnClick(Sender: TObject);
begin
  UpdateThread.Execute(nil);
end;

end.

