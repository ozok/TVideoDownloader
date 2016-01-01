unit DownloadItemFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Gauges, acImage;

type
  TDownloadUIItem = class(TFrame)
    LinkLabel: TLabel;
    FileNameLabel: TLabel;
    FormatList: TComboBox;
    SubtitleList: TComboBox;
    ProgressLabel: TLabel;
    ProgressBar: TGauge;
    sPanel1: TPanel;
    DeleteButton: TButton;
    sPanel2: TPanel;
    PrevievImg: TsImage;
    PreviewBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
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

