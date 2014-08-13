unit UnitSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.StdCtrls, sEdit,
  sCheckBox, Vcl.ComCtrls, sTrackBar, sButton, IniFiles;

type
  TSettingsForm = class(TForm)
    sSkinProvider1: TsSkinProvider;
    ProcessCountBar: TsTrackBar;
    DontDoubleDownloadBtn: TsCheckBox;
    DontPreviewImgBtn: TsCheckBox;
    PreferedFormatEdit: TsEdit;
    DashVideoBtn: TsCheckBox;
    ProcessCountEdit: TsEdit;
    PlaySoundBtn: TsCheckBox;
    sButton1: TsButton;
    sButton2: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure ProcessCountBarChange(Sender: TObject);
  private
    { Private declarations }
    procedure LoadOptions();
    procedure SaveOptions();
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

uses UnitMain;

procedure TSettingsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveOptions;
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  LoadOptions;
end;

procedure TSettingsForm.LoadOptions;
var
  OptionFile: TIniFile;
  LProcCount: integer;
begin
  LProcCount := CPUCount;
  if LProcCount > ProcessCountBar.Max then
  begin
    LProcCount := ProcessCountBar.Max
  end;

  OptionFile := TIniFile.Create(MainForm.FLogFolder + '\Settings.ini');
  try
    with OptionFile do
    begin
      PlaySoundBtn.Checked := ReadBool('options', 'playsound', True);
      PreferedFormatEdit.Text := ReadString('options', 'downloadformat', 'mp4, 1080p, DASH, video');
      ProcessCountBar.Position := ReadInteger('options', 'downloadcount', LProcCount);
      DontDoubleDownloadBtn.Checked := ReadBool('options', 'doubledownload', True);
      DontPreviewImgBtn.Checked := ReadBool('options', 'noimg', False);
    end;
  finally
    ProcessCountBarChange(Self);
    OptionFile.Free
  end;
end;

procedure TSettingsForm.ProcessCountBarChange(Sender: TObject);
begin
  ProcessCountEdit.Text := FloatToStr(ProcessCountBar.Position);
end;

procedure TSettingsForm.SaveOptions;
var
  OptionFile: TIniFile;
begin
  OptionFile := TIniFile.Create(MainForm.FLogFolder + '\Settings.ini');
  try
    with OptionFile do
    begin
      WriteBool('options', 'playsound', PlaySoundBtn.Checked);
      WriteString('options', 'downloadformat', PreferedFormatEdit.Text);
      WriteInteger('options', 'downloadcount', ProcessCountBar.Position);
      WriteBool('options', 'doubledownload', DontDoubleDownloadBtn.Checked);
      WriteBool('options', 'noimg', DontPreviewImgBtn.Checked);
    end;
  finally
    OptionFile.Free;
  end;
end;

procedure TSettingsForm.sButton1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TSettingsForm.sButton2Click(Sender: TObject);
var
  LProcCount: integer;
begin
  LProcCount := CPUCount;
  if LProcCount > ProcessCountBar.Max then
  begin
    LProcCount := ProcessCountBar.Max
  end;
  PlaySoundBtn.Checked := True;
  PreferedFormatEdit.Text := 'mp4, 1080p, DASH, video';
  ProcessCountBar.Position := LProcCount;
  DontDoubleDownloadBtn.Checked := True;
  DontPreviewImgBtn.Checked := False;
end;

end.
