object DownloadUIItem: TDownloadUIItem
  Left = 0
  Top = 0
  Width = 451
  Height = 140
  Anchors = [akLeft, akTop, akRight]
  TabOrder = 0
  object sPanel1: TsPanel
    Left = 137
    Top = 0
    Width = 314
    Height = 140
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitHeight = 137
    DesignSize = (
      314
      140)
    object ProgressLabel: TsLabel
      Left = 55
      Top = 95
      Width = 67
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'ProgressLabel'
    end
    object ProgressBar: TsGauge
      Left = 6
      Top = 112
      Width = 216
      Height = 19
      Anchors = [akLeft, akRight, akBottom]
      Animated = False
      SkinData.SkinSection = 'GAUGE'
      ForeColor = clBlack
      Progress = 0
      Suffix = '%'
      ExplicitTop = 109
      ExplicitWidth = 564
    end
    object FileNameLabel: TsLabel
      Left = 6
      Top = 22
      Width = 68
      Height = 13
      Caption = 'FileNameLabel'
    end
    object LinkLabel: TsLabel
      Left = 6
      Top = 3
      Width = 43
      Height = 13
      Cursor = crHandPoint
      Caption = 'LinkLabel'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
    end
    object FormatList: TsComboBox
      Left = 55
      Top = 41
      Width = 246
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Format:'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      ItemIndex = -1
      TabOrder = 0
    end
    object SubtitleList: TsComboBox
      Left = 55
      Top = 68
      Width = 246
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Subtitles:'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      ItemIndex = -1
      TabOrder = 1
    end
    object DeleteButton: TsButton
      Left = 228
      Top = 109
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Remove'
      TabOrder = 2
      ExplicitTop = 106
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 0
    Width = 137
    Height = 140
    Align = alLeft
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitHeight = 137
    object PrevievImg: TsImage
      Left = 1
      Top = 1
      Width = 135
      Height = 138
      Align = alClient
      Center = True
      Picture.Data = {07544269746D617000000000}
      Proportional = True
      Transparent = True
      SkinData.SkinSection = 'CHECKBOX'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 140
      ExplicitHeight = 140
    end
  end
end
