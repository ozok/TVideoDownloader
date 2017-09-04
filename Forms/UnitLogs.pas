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
  unit UnitLogs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TLogForm = class(TForm)
    sPageControl1: TPageControl;
    sTabSheet1: TTabSheet;
    sTabSheet2: TTabSheet;
    Main: TMemo;
    sTabSheet3: TTabSheet;
    CMDLog: TMemo;
    ConsoleLog: TMemo;
    ConsolesList: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ConsolesListChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogForm: TLogForm;

implementation

{$R *.dfm}

uses
  UnitMain;

procedure TLogForm.ConsolesListChange(Sender: TObject);
begin
  if ConsolesList.ItemIndex > -1 then
  begin
    ConsoleLog.Lines.Clear;
    ConsoleLog.Lines.AddStrings(MainForm.FVideoDownloadProcesses[ConsolesList.ItemIndex].GetConsoleOutput);
  end;
end;

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ConsoleLog.Lines.Clear;
end;

procedure TLogForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := Low(MainForm.FVideoDownloadProcesses) to High(MainForm.FVideoDownloadProcesses) do
  begin
    ConsolesList.Items.Add('Downloader ' + FloatToStr(i + 1));
  end;
  ConsolesList.ItemIndex := 0;
end;

procedure TLogForm.FormShow(Sender: TObject);
begin
  ConsolesListChange(Self);
end;

end.


