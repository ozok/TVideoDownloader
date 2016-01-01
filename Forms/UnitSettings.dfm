object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 229
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    435
    229)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 81
    Height = 13
    Caption = 'Prefered format:'
  end
  object Label2: TLabel
    Left = 8
    Top = 65
    Width = 117
    Height = 13
    Caption = 'Parallel download count:'
  end
  object Label3: TLabel
    Left = 8
    Top = 170
    Width = 132
    Height = 13
    Caption = 'Link add timeout (seconds):'
  end
  object ProcessCountBar: TTrackBar
    Left = 184
    Top = 61
    Width = 244
    Height = 23
    Max = 16
    Min = 1
    Position = 4
    ShowSelRange = False
    TabOrder = 0
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = ProcessCountBarChange
  end
  object DontDoubleDownloadBtn: TCheckBox
    Left = 11
    Top = 90
    Width = 248
    Height = 20
    Caption = 'Don'#39't download again if  local file contains audio'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object DontPreviewImgBtn: TCheckBox
    Left = 11
    Top = 115
    Width = 106
    Height = 20
    Caption = 'Don'#39't load thumbs'
    TabOrder = 2
  end
  object PreferedFormatEdit: TEdit
    Left = 90
    Top = 8
    Width = 338
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = 'mp4, 1080p, DASH, video'
  end
  object DashVideoBtn: TCheckBox
    Left = 11
    Top = 35
    Width = 274
    Height = 20
    Caption = 'When a "DASH" video is selected download audio too'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object ProcessCountEdit: TEdit
    Left = 129
    Top = 60
    Width = 49
    Height = 21
    Alignment = taCenter
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    Text = '4'
  end
  object PlaySoundBtn: TCheckBox
    Left = 224
    Top = 115
    Width = 196
    Height = 20
    Caption = 'Play a sound when download is done'
    TabOrder = 6
  end
  object sButton1: TButton
    Left = 352
    Top = 196
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 7
    OnClick = sButton1Click
    ExplicitTop = 175
  end
  object sButton2: TButton
    Left = 8
    Top = 196
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Reset'
    TabOrder = 8
    OnClick = sButton2Click
    ExplicitTop = 175
  end
  object CheckUpdateBtn: TCheckBox
    Left = 11
    Top = 141
    Width = 132
    Height = 20
    Caption = 'Check updates on start'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object LinkAddTimeOutEdit: TJvSpinEdit
    Left = 146
    Top = 167
    Width = 75
    Height = 21
    CheckOptions = [coCheckOnExit, coCropBeyondLimit]
    CheckMaxValue = False
    Alignment = taCenter
    ButtonKind = bkClassic
    MinValue = 15.000000000000000000
    Value = 60.000000000000000000
    TabOrder = 10
  end
end
