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
unit UnitYoutubedlUpdateCheckerProcess;

interface

uses Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils;

type
  TYoutubedlUpdateCheckerProcess = class(TObject)
  private
    // process
    FProcess: TJvCreateProcess;
    // flag to indicate if encoding is stopped by user
    FStoppedByUser: Boolean;

    // process events
    procedure ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);

    // field variable read funcs
  public
    constructor Create();
    destructor Destroy(); override;

    procedure Start(const Path: string);
    procedure Stop();
    procedure ResetValues();
  end;

implementation

{ TYoutubedlUpdateCheckerProcess }

uses UnitYoutubedlUpdateChecker;

constructor TYoutubedlUpdateCheckerProcess.Create;
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

end;

destructor TYoutubedlUpdateCheckerProcess.Destroy;
begin
  FProcess.Free;
  inherited Destroy;
end;

procedure TYoutubedlUpdateCheckerProcess.ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
begin
  YoutubedlUpdateChecker.OutputList.Lines.Add(S.Trim);
end;

procedure TYoutubedlUpdateCheckerProcess.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
begin

end;

procedure TYoutubedlUpdateCheckerProcess.ResetValues;
begin
  FStoppedByUser := False;
end;

procedure TYoutubedlUpdateCheckerProcess.Start(const Path: string);
begin
  // start with the first item if download is not already started
  if FProcess.ProcessInfo.hProcess = 0 then
  begin
    YoutubedlUpdateChecker.OutputList.Lines.Add('Starting to check update...');
    if FileExists(Path) then
    begin
      FProcess.ApplicationName := Path;
      YoutubedlUpdateChecker.OutputList.Lines.Add(Path);
      FProcess.CommandLine := ' -U ';
      FProcess.Run;
    end
  end
end;

procedure TYoutubedlUpdateCheckerProcess.Stop;
begin
  // terminate running process unless it's already stopped
  if FProcess.ProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(FProcess.ProcessInfo.hProcess, 0);
    FStoppedByUser := true;
  end;
end;

end.
