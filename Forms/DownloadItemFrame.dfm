object DownloadUIItem: TDownloadUIItem
  Left = 0
  Top = 0
  Width = 1116
  Height = 112
  Anchors = [akLeft, akTop, akRight]
  TabOrder = 0
  object sPanel1: TPanel
    Left = 178
    Top = 0
    Width = 938
    Height = 112
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      938
      112)
    object ProgressLabel: TLabel
      Left = 55
      Top = 67
      Width = 67
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'ProgressLabel'
      ExplicitTop = 95
    end
    object ProgressBar: TGauge
      Left = 6
      Top = 84
      Width = 759
      Height = 19
      Anchors = [akLeft, akRight, akBottom]
      Progress = 0
    end
    object FileNameLabel: TLabel
      Left = 6
      Top = 22
      Width = 68
      Height = 13
      Caption = 'FileNameLabel'
    end
    object LinkLabel: TLabel
      Left = 6
      Top = 3
      Width = 43
      Height = 13
      Cursor = crHandPoint
      Caption = 'LinkLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 11
      Top = 45
      Width = 38
      Height = 13
      Caption = 'Format:'
    end
    object Label2: TLabel
      Left = 680
      Top = 44
      Width = 40
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Subtitle:'
    end
    object FormatList: TComboBox
      Left = 55
      Top = 41
      Width = 610
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object SubtitleList: TComboBox
      Left = 726
      Top = 41
      Width = 200
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object DeleteButton: TButton
      Left = 852
      Top = 81
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Remove'
      TabOrder = 2
    end
    object PreviewBtn: TButton
      Left = 771
      Top = 81
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Preview'
      TabOrder = 3
    end
  end
  object sPanel2: TPanel
    Left = 0
    Top = 0
    Width = 178
    Height = 112
    Align = alLeft
    TabOrder = 1
    object PrevievImg: TsImage
      Left = 1
      Top = 1
      Width = 176
      Height = 110
      Align = alClient
      Center = True
      Picture.Data = {07544269746D617000000000}
      Proportional = True
      Stretch = True
      Transparent = True
      SkinData.SkinSection = 'CHECKBOX'
      UseFullSize = True
      ExplicitLeft = 2
      ExplicitTop = 0
    end
  end
end
