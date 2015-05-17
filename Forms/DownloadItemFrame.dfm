object DownloadItem: TDownloadItem
  Left = 0
  Top = 0
  Width = 802
  Height = 140
  TabOrder = 0
  object Thumbnail: TsImage
    Left = 0
    Top = 0
    Width = 140
    Height = 140
    Align = alLeft
    Picture.Data = {07544269746D617000000000}
    Proportional = True
    Transparent = True
    SkinData.SkinSection = 'CHECKBOX'
    UseFullSize = True
  end
  object sPanel1: TsPanel
    Left = 146
    Top = 0
    Width = 662
    Height = 140
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      662
      140)
    object ProgressLabel: TsLabel
      Left = 55
      Top = 95
      Width = 434
      Height = 13
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'ProgressLabel'
    end
    object ProgressBar: TsGauge
      Left = 6
      Top = 109
      Width = 564
      Height = 25
      Align = alBottom
      Animated = False
      SkinData.SkinSection = 'GAUGE'
      ForeColor = clBlack
      Progress = 0
      Suffix = '%'
    end
    object TitleLabel: TsLabel
      Left = 6
      Top = 22
      Width = 45
      Height = 13
      Caption = 'TitleLabel'
    end
    object URLLabel: TsLabel
      Left = 6
      Top = 3
      Width = 44
      Height = 13
      Caption = 'URLLabel'
    end
    object FormatList: TsComboBox
      Left = 55
      Top = 41
      Width = 594
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
      Width = 594
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
    object RemoveBtn: TsButton
      Left = 576
      Top = 109
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Remove'
      TabOrder = 2
    end
  end
end
