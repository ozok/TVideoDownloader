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
unit DownloadItemFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Gauges, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  JvComponentBase, JvCreateProcess;

type
  TDownloadUIItem = class(TFrame)
    LinkLabel: TLabel;
    FileNameLabel: TLabel;
    FormatList: TComboBox;
    SubtitleList: TComboBox;
    ProgressLabel: TLabel;
    sPanel1: TPanel;
    DeleteButton: TButton;
    sPanel2: TPanel;
    PrevievImg: TImage;
    PreviewBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    ProgressBar: TProgressBar;
    ImageList1: TImageList;
    PreviewProcess: TJvCreateProcess;
    procedure PreviewProcessTerminate(Sender: TObject; ExitCode: Cardinal);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ResetProgressLabel;
    procedure Disable;
    procedure Enable;
  end;

implementation

{$R *.dfm}
{ TDownloadUIItem }

procedure TDownloadUIItem.Disable;
begin
  LinkLabel.Enabled := False;
  FileNameLabel.Enabled := False;
  FormatList.Enabled := False;
  SubtitleList.Enabled := False;
  DeleteButton.Enabled := False;
  PreviewBtn.Enabled := False;
end;

procedure TDownloadUIItem.Enable;
begin
  LinkLabel.Enabled := True;
  FileNameLabel.Enabled := True;
  FormatList.Enabled := True;
  SubtitleList.Enabled := True;
  DeleteButton.Enabled := True;
  PreviewBtn.Enabled := True;
end;

procedure TDownloadUIItem.PreviewProcessTerminate(Sender: TObject; ExitCode: Cardinal);
begin
  PreviewBtn.Enabled := True;
end;

procedure TDownloadUIItem.ResetProgressLabel;
begin
  ProgressLabel.Caption := '';
  ProgressBar.Position := 0;
end;

end.

