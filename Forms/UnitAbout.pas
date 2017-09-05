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
  * }unit UnitAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  ShellAPI;

type
  TAboutForm = class(TForm)
    sLabel1: TLabel;
    sLabel2: TLabel;
    sLabel3: TLabel;
    sButton1: TButton;
    sButton2: TButton;
    sButton3: TButton;
    Image1: TImage;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses
  UnitMain;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TAboutForm.sButton1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TAboutForm.sButton2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://ozok26.com/donate/', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.sButton3Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://ozok26.com/category/tvideodownloader/', nil, nil, SW_SHOWNORMAL);
end;

end.

