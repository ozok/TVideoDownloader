unit DownloadItemFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel,
  sGauge, Vcl.StdCtrls, sComboBox, sLabel, acImage, sButton;

type
  TDownloadItem = class(TFrame)
    Thumbnail: TsImage;
    URLLabel: TsLabel;
    TitleLabel: TsLabel;
    FormatList: TsComboBox;
    SubtitleList: TsComboBox;
    ProgressLabel: TsLabel;
    ProgressBar: TsGauge;
    sPanel1: TsPanel;
    RemoveBtn: TsButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
