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
unit UnitPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw,
  ActiveX;

type
  TPreviewForm = class(TForm)
    Browser: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    procedure Play(const URL: string);
  public
    { Public declarations }
    URL: string;
  end;

var
  PreviewForm: TPreviewForm;

implementation

{$R *.dfm}

uses
  UnitMain;
{ TPreviewForm }

procedure TPreviewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Browser.Navigate('about:home');
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TPreviewForm.FormShow(Sender: TObject);
begin
  Play(URL);
end;

procedure TPreviewForm.Play(const URL: string);
var
  LHtml: string;
  LMS: TMemoryStream;
  LHtmlList: TStringList;
begin
  LHtml := '<html><head></style><style type="text/css">.recentcomments a{display:inline !important;padding:0 !important;margin:0 !important;}</style></head><body style="background-color: black">' + '<iframe width="560" height="315" src="' + URL.Replace('watch?v=', 'embed/') + '" frameborder="0" allowfullscreen></iframe></body></html>';

  Browser.Navigate('about:blank');
  while Browser.ReadyState < READYSTATE_INTERACTIVE do
  begin
    Application.ProcessMessages;
    Sleep(10);
  end;

  if Assigned(Browser.Document) then
  begin
    LMS := TMemoryStream.Create;
    LHtmlList := TStringList.Create;
    try
      LHtmlList.Text := LHtml;
      LHtmlList.SaveToStream(LMS);
      LMS.Seek(0, soFromBeginning);
      (Browser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(LMS));
    finally
      LMS.Free;
      LHtmlList.Free;
    end;
  end;
end;

end.


