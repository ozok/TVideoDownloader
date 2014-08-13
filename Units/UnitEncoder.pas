{ *
  * Copyright (C) 2011-2014 ozok <ozok26@gmail.com>
  *
  * This file is part of TEncoder.
  *
  * TEncoder is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * TEncoder is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with TEncoder.  If not, see <http://www.gnu.org/licenses/>.
  *
  * }
unit UnitEncoder;

interface

uses Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils, ComCtrls;

// current state of the process
type
  TEncoderStatus = (esEncoding, esStopped, esDone);

type
  TEncoder = class(TObject)
  private
    // process
    FProcess: TJvCreateProcess;
    // list of command lines to be executed
    FCommandLines: TStringList;
    // list of executables
    FPaths: TStringList;
    // index of current command line. Also progress.
    FCommandIndex: integer;
    // last line backend has written to console
    FConsoleOutput: string;
    // encoder's state
    FEncoderStatus: TEncoderStatus;
    // flag to indicate if encoding is stopped by user
    FStoppedByUser: Boolean;
    // list of files to be processed.
    FFileNames: TStringList;
    // a list of types of encoders to be run.
    FProcessTypes: TStringList;
    // a list of durations of files to be processed. generally to show progress.
    FDurations: TStringList;
    // index of currently used duration
    FDurationIndex: integer;
    // list of informations about steps.
    FInfos: TStringList;
    // a list of indexes indicating to the files in a list. to show progress in the list.
    FFileIndexes: TStringList;
    // a list of output files. generally to check if they are created.
    FOutputFiles: TStringList;

    // process events
    procedure ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);

    // field variable read funcs
    function GetProcessID: integer;
    function GetFileName: string;
    function GetCurrentProcessType: string;
    function GetCurrentDuration: string;
    function GetInfo: string;
    function GetCommandCount: integer;
    function GetExeName: string;
    function GetFileIndex: Integer;
  public
    property ConsoleOutput: string read FConsoleOutput;
    property EncoderStatus: TEncoderStatus read FEncoderStatus;
    property CommandLines: TStringList read FCommandLines write FCommandLines;
    property EncoderPaths: TStringList read FPaths write FPaths;
    property FileNames: TStringList read FFileNames;
    property FilesDone: integer read FCommandIndex;
    property ProcessID: integer read GetProcessID;
    property CurrentFile: string read GetFileName;
    property Durations: TStringList read FDurations write FDurations;
    property ProcessTypes: TStringList read FProcessTypes write FProcessTypes;
    property CurrentProcessType: string read GetCurrentProcessType;
    property CurrentDuration: string read GetCurrentDuration;
    property Info: string read GetInfo;
    property Infos: TStringList read FInfos write FInfos;
    property CommandCount: integer read GetCommandCount;
    property ExeName: string read GetExeName;
    property FileIndexes: TStringList read FFileIndexes write FFileIndexes;
    property FileIndex: Integer read GetFileIndex;
    property OutputFiles: TStringList read FOutputFiles write FOutputFiles;

    constructor Create();
    destructor Destroy(); override;

    procedure Start();
    procedure Stop();
    procedure ResetValues();
    function GetConsoleOutput(): TStrings;
  end;

implementation

{ TEncoder }

uses UnitMain;

constructor TEncoder.Create;
begin
  inherited Create;

  FProcess := TJvCreateProcess.Create(nil);
  with FProcess do
  begin
    OnRead := ProcessRead;
    OnTerminate := ProcessTerminate;
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

  FCommandLines := TStringList.Create;
  FPaths := TStringList.Create;
  FFileNames := TStringList.Create;
  FEncoderStatus := esStopped;
  FStoppedByUser := False;
  FProcessTypes := TStringList.Create;
  FDurations := TStringList.Create;
  FInfos := TStringList.Create;
  FFileIndexes := TStringList.Create;
  FDurationIndex := 0;
  FCommandIndex := 0;
  FOutputFiles := TStringList.Create;
end;

destructor TEncoder.Destroy;
begin

  inherited Destroy;
  FreeAndNil(FCommandLines);
  FreeAndNil(FPaths);
  FreeAndNil(FInfos);
  FreeAndNil(FFileNames);
  FreeAndNil(FProcessTypes);
  FreeAndNil(FDurations);
  FreeAndNil(FFileIndexes);
  FreeAndNil(FOutputFiles);
  FProcess.Free;

end;

function TEncoder.GetCommandCount: integer;
begin
  Result := FCommandLines.Count;
end;

function TEncoder.GetConsoleOutput: TStrings;
begin
  Result := FProcess.ConsoleOutput;
end;

function TEncoder.GetCurrentDuration: string;
begin
  if FCommandIndex < FDurations.Count then
    Result := FDurations[FDurationIndex];
end;

function TEncoder.GetCurrentProcessType: string;
begin
  if FCommandIndex < FProcessTypes.Count then
    Result := FProcessTypes[FCommandIndex];
end;

function TEncoder.GetExeName: string;
begin
  if FCommandIndex < FPaths.Count then
    Result := FPaths[FCommandIndex];
end;

function TEncoder.GetFileIndex: Integer;
begin
  if FCommandIndex < FFileIndexes.Count then
    Result := StrToInt(FFileIndexes[FCommandIndex]);
end;

function TEncoder.GetFileName: string;
begin
  if FCommandIndex < FFileNames.Count then
    Result := FFileNames[FCommandIndex];
end;

function TEncoder.GetInfo: string;
begin
  if FCommandIndex < FInfos.Count then
    Result := FInfos[FCommandIndex];
end;

function TEncoder.GetProcessID: integer;
begin
  Result := FProcess.ProcessInfo.hProcess;
end;

procedure TEncoder.ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
begin
  FConsoleOutput := Trim(S);
end;

procedure TEncoder.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
begin
  FEncoderStatus := esStopped;
  if FStoppedByUser then
  begin
    FEncoderStatus := esStopped;
  end
  else
  begin
    // processed that need duration information
    if (GetCurrentProcessType = '2') or (GetCurrentProcessType = '19') then
    begin
      Inc(FDurationIndex);
    end;

    // run next command
    inc(FCommandIndex);
    if FCommandIndex < FCommandLines.Count then
    begin
      FProcess.CommandLine := FCommandLines[FCommandIndex];
      FProcess.ApplicationName := FPaths[FCommandIndex];
      FEncoderStatus := esEncoding;
      FConsoleOutput := '';
      FProcess.Run;
    end
    else
    begin
      // done
      FFileNames.Clear;
      FEncoderStatus := esDone;
    end;
  end;
end;

procedure TEncoder.ResetValues;
begin
  // reset all lists, indexes etc
  FCommandLines.Clear;
  FPaths.Clear;
  FCommandIndex := 0;
  FDurationIndex := 0;
  FConsoleOutput := '';
  FProcess.ConsoleOutput.Clear;
  FProcessTypes.Clear;
  FDurations.Clear;
  FStoppedByUser := False;
  FInfos.Clear;
end;

procedure TEncoder.Start;
begin
  if FProcess.ProcessInfo.hProcess = 0 then
  begin
    if FCommandLines.Count > 0 then
    begin
      if FileExists(FPaths[0]) then
      begin
        FProcess.ApplicationName := FPaths[0];
        FProcess.CommandLine := FCommandLines[0];
        FEncoderStatus := esEncoding;
        FProcess.Run;
      end
      else
        FConsoleOutput := 'encoder'
    end
    else
      FConsoleOutput := '0 cmd'
  end
  else
    FConsoleOutput := 'not 0'
end;

procedure TEncoder.Stop;
begin
  if FProcess.ProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(FProcess.ProcessInfo.hProcess, 0);
    FFileNames.Clear;
    FEncoderStatus := esStopped;
    FStoppedByUser := true;
  end;
end;

end.
