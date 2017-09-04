object LogForm: TLogForm
  Left = 0
  Top = 0
  Caption = 'Logs'
  ClientHeight = 414
  ClientWidth = 784
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 414
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 0
    object sTabSheet1: TTabSheet
      Caption = 'Main'
      object Main: TMemo
        Left = 0
        Top = 0
        Width = 776
        Height = 386
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object sTabSheet2: TTabSheet
      Caption = 'Command lines'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object CMDLog: TMemo
        Left = 0
        Top = 0
        Width = 776
        Height = 386
        Align = alClient
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object sTabSheet3: TTabSheet
      Caption = 'Console error logs'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ConsoleLog: TMemo
        Left = 0
        Top = 21
        Width = 776
        Height = 365
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object ConsolesList: TComboBox
        Left = 0
        Top = 0
        Width = 776
        Height = 21
        Align = alTop
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = ConsolesListChange
      end
    end
  end
end
