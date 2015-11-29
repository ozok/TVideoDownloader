unit DownloadItemFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel,
  sGauge, Vcl.StdCtrls, sComboBox, sLabel, acImage, sButton, sBevel;

type
  TDownloadUIItem = class(TFrame)
    LinkLabel: TsLabel;
    FileNameLabel: TsLabel;
    FormatList: TsComboBox;
    SubtitleList: TsComboBox;
    ProgressLabel: TsLabel;
    ProgressBar: TsGauge;
    sPanel1: TsPanel;
    DeleteButton: TsButton;
    sPanel2: TsPanel;
    PrevievImg: TsImage;
    PreviewBtn: TsButton;
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

procedure TDownloadUIItem.ResetProgressLabel;
begin
  ProgressLabel.Caption := '';
  ProgressBar.Progress := 0;
end;

end.
