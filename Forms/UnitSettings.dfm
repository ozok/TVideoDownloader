object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 208
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
    208)
  PixelsPerInch = 96
  TextHeight = 13
  object ProcessCountBar: TsTrackBar
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
    SkinData.SkinSection = 'TRACKBAR'
    BarOffsetV = 0
    BarOffsetH = 0
  end
  object DontDoubleDownloadBtn: TsCheckBox
    Left = 11
    Top = 90
    Width = 248
    Height = 20
    Caption = 'Don'#39't download again if  local file contains audio'
    Checked = True
    State = cbChecked
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object DontPreviewImgBtn: TsCheckBox
    Left = 11
    Top = 115
    Width = 106
    Height = 20
    Caption = 'Don'#39't load thumbs'
    TabOrder = 2
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object PreferedFormatEdit: TsEdit
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
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Preferred format:'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object DashVideoBtn: TsCheckBox
    Left = 11
    Top = 35
    Width = 274
    Height = 20
    Caption = 'When a "DASH" video is selected download audio too'
    Checked = True
    State = cbChecked
    TabOrder = 4
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object ProcessCountEdit: TsEdit
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
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Parallel download count:'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object PlaySoundBtn: TsCheckBox
    Left = 224
    Top = 115
    Width = 196
    Height = 20
    Caption = 'Play a sound when download is done'
    TabOrder = 6
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sButton1: TsButton
    Left = 352
    Top = 175
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 7
    OnClick = sButton1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sButton2: TsButton
    Left = 8
    Top = 175
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Reset'
    TabOrder = 8
    OnClick = sButton2Click
    SkinData.SkinSection = 'BUTTON'
  end
  object CheckUpdateBtn: TsCheckBox
    Left = 11
    Top = 141
    Width = 132
    Height = 20
    Caption = 'Check updates on start'
    Checked = True
    State = cbChecked
    TabOrder = 9
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    FormHeader.AdditionalHeight = 0
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 336
    Top = 48
  end
end
