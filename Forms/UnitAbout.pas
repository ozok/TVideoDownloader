unit UnitAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel, Vcl.ExtCtrls,
  acImage, sButton, acPNG, ShellAPI, sSkinProvider;

type
  TAboutForm = class(TForm)
    sImage1: TsImage;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sButton1: TsButton;
    sButton2: TsButton;
    sButton3: TsButton;
    sSkinProvider1: TsSkinProvider;
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

uses UnitMain;

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
  ShellExecute(0, 'open', 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2DCLCV369NLBW', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.sButton3Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://sourceforge.net/projects/tvideodownloader/', nil, nil, SW_SHOWNORMAL);
end;

end.
