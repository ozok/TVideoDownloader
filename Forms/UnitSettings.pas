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
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DeleteSubAfterMuxBtn: TCheckBox;
    FilePatternList: TComboBox;
    Label6: TLabel;
    procedure sButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure ProcessCountBarChange(Sender: TObject);
    procedure MuxSubBtnClick(Sender: TObject);
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
      DeleteSubAfterMuxBtn.Checked := ReadBool('Options', 'DeleteSub', false);
      FilePatternList.ItemIndex := ReadInteger('Options', 'FilePattern', 0);
      MuxSubBtnClick(Self);
    end;
  finally
    ProcessCountBarChange(Self);
    OptionFile.Free
  end;
end;

procedure TSettingsForm.MuxSubBtnClick(Sender: TObject);
begin
  DeleteSubAfterMuxBtn.Enabled := MuxSubBtn.Checked;
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
      WriteBool('Options', 'DeleteSub', DeleteSubAfterMuxBtn.Checked);
      WriteInteger('Options', 'FilePattern', FilePatternList.ItemIndex);
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
  SubLangList.ItemIndex := 39;
  MuxSubBtn.Checked := False;
  DeleteSubAfterMuxBtn.Checked := False;
  DroppedLinksArePlaylistsBtn.Checked := False;
  CheckYoutubeDlUpdateBtn.Checked := True;
  LinkAddTimeOutEdit.Text := '60';
  RateLimitEdit.Text := '0';
  FilePatternList.ItemIndex := 0;
end;

end.


