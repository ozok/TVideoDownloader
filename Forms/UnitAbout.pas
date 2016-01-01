unit UnitAbout;

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
  ShellExecute(0, 'open', 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2DCLCV369NLBW', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.sButton3Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://sourceforge.net/projects/tvideodownloader/', nil, nil, SW_SHOWNORMAL);
end;

end.

