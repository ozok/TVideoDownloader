unit UnitLogs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, sPageControl,
  sSkinProvider, Vcl.StdCtrls, sMemo, sComboBox;

type
  TLogForm = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    Main: TsMemo;
    sTabSheet3: TsTabSheet;
    CMDLog: TsMemo;
    ConsoleLog: TsMemo;
    ConsolesList: TsComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ConsolesListChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogForm: TLogForm;

implementation

{$R *.dfm}

uses UnitMain;

procedure TLogForm.ConsolesListChange(Sender: TObject);
begin
  if ConsolesList.ItemIndex > -1 then
  begin
    ConsoleLog.Lines.Clear;
    ConsoleLog.Lines.AddStrings(MainForm.FVideoDownloadProcesses[ConsolesList.ItemIndex].GetConsoleOutput);
  end;
end;

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ConsoleLog.Lines.Clear;
end;

procedure TLogForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for I := Low(MainForm.FVideoDownloadProcesses) to High(MainForm.FVideoDownloadProcesses) do
  begin
    ConsolesList.Items.Add('Downloader ' + FloatToStr(i + 1));
  end;
  ConsolesList.ItemIndex := 0;
end;

procedure TLogForm.FormShow(Sender: TObject);
begin
  ConsolesListChange(Self);
end;

end.
