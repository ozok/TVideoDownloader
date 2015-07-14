object YoutubedlUpdateChecker: TYoutubedlUpdateChecker
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Youtube-dl Update Checker'
  ClientHeight = 172
  ClientWidth = 645
  Color = 3485741
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    645
    172)
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar: TsGauge
    Left = 8
    Top = 139
    Width = 394
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Animated = False
    SkinData.SkinSection = 'GAUGE'
    ForeColor = clBlack
    Progress = 0
    Suffix = '%'
    ExplicitTop = 169
  end
  object OutputList: TsMemo
    Left = 8
    Top = 8
    Width = 629
    Height = 125
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = 2038810
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13417908
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
  end
  object sButton1: TsButton
    Left = 562
    Top = 139
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 1
    OnClick = sButton1Click
    ExplicitTop = 169
  end
  object DownloadBtn: TsButton
    Left = 408
    Top = 139
    Width = 148
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Get the latest version'
    TabOrder = 2
    OnClick = DownloadBtnClick
    ExplicitTop = 169
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
    Left = 384
    Top = 32
  end
  object Downloader: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    OnWork = DownloaderWork
    OnWorkBegin = DownloaderWorkBegin
    OnWorkEnd = DownloaderWorkEnd
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 176
    Top = 16
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 56
    Top = 16
  end
  object UpdateThread: TJvThread
    Exclusive = True
    MaxCount = 0
    RunOnCreate = True
    FreeOnTerminate = True
    OnExecute = UpdateThreadExecute
    Left = 280
    Top = 24
  end
end
