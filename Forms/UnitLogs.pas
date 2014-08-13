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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogForm: TLogForm;

implementation

{$R *.dfm}

end.
