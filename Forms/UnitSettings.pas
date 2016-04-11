unit UnitSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  IniFiles, Vcl.Mask, JvExMask, JvSpin;

type
  TSettingsForm = class(TForm)
    ProcessCountBar: TTrackBar;
    DontDoubleDownloadBtn: TCheckBox;
    DontPreviewImgBtn: TCheckBox;
    PreferedFormatEdit: TEdit;
    DashVideoBtn: TCheckBox;
    ProcessCountEdit: TEdit;
    PlaySoundBtn: TCheckBox;
    sButton1: TButton;
    sButton2: TButton;
    CheckUpdateBtn: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    LinkAddTimeOutEdit: TJvSpinEdit;
    Label3: TLabel;
    CheckYoutubeDlUpdateBtn: TCheckBox;
    DroppedLinksArePlaylistsBtn: TCheckBox;
    RateLimitEdit: TJvSpinEdit;
    Label4: TLabel;
    SubLangList: TComboBox;
    Label5: TLabel;
    MuxSubBtn: TCheckBox;
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

uses
  UnitMain;

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

  OptionFile := TIniFile.Create(MainForm.FAppDataFolder + '\Settings.ini');
  try
    with OptionFile do
    begin
      PlaySoundBtn.Checked := ReadBool('options', 'playsound', True);
      PreferedFormatEdit.Text := ReadString('options', 'downloadformat', 'mp4, 1920x1080, DASH, video');
      ProcessCountBar.Position := ReadInteger('options', 'downloadcount', LProcCount);
      DontDoubleDownloadBtn.Checked := ReadBool('options', 'doubledownload', True);
      DontPreviewImgBtn.Checked := ReadBool('options', 'noimg', False);
      CheckUpdateBtn.Checked := ReadBool('Options', 'Update', True);
      LinkAddTimeOutEdit.Value := ReadInteger('Options', 'LoadTimeOut', 60);
      CheckYoutubeDlUpdateBtn.Checked := ReadBool('Options', 'YUpdate', True);
      DroppedLinksArePlaylistsBtn.Checked := ReadBool('Options', 'TreatAsPl', False);
      RateLimitEdit.Text := ReadString('Options', 'Rate', '0');
      SubLangList.ItemIndex := ReadInteger('Options', 'SubLang', 39);
      MuxSubBtn.Checked := ReadBool('Options', 'MuxSub', False);
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
  OptionFile := TIniFile.Create(MainForm.FAppDataFolder + '\Settings.ini');
  try
    with OptionFile do
    begin
      WriteBool('options', 'playsound', PlaySoundBtn.Checked);
      WriteString('options', 'downloadformat', PreferedFormatEdit.Text);
      WriteInteger('options', 'downloadcount', ProcessCountBar.Position);
      WriteBool('options', 'doubledownload', DontDoubleDownloadBtn.Checked);
      WriteBool('options', 'noimg', DontPreviewImgBtn.Checked);
      WriteBool('Options', 'Update', CheckUpdateBtn.Checked);
      WriteInteger('Options', 'LoadTimeOut', Round(LinkAddTimeOutEdit.Value));
      WriteBool('Options', 'YUpdate', CheckYoutubeDlUpdateBtn.Checked);
      WriteBool('Options', 'TreatAsPl', DroppedLinksArePlaylistsBtn.Checked);
      WriteString('Options', 'Rate', RateLimitEdit.Text);
      WriteInteger('Options', 'SubLang', SubLangList.ItemIndex);
      WriteBool('Options', 'MuxSub', MuxSubBtn.Checked);
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
  PreferedFormatEdit.Text := 'mp4, 1920x1080, DASH, video';
  ProcessCountBar.Position := LProcCount;
  DontDoubleDownloadBtn.Checked := True;
  DontPreviewImgBtn.Checked := False;
  CheckUpdateBtn.Checked := True;
end;

end.

