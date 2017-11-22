program TVideoDownloader;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  UnitMain in 'Forms\UnitMain.pas' {MainForm},
  UnitDownloadProcess in 'Units\DownloaderUnits\UnitDownloadProcess.pas',
  UnitCommonTypes in 'Units\Common\UnitCommonTypes.pas',
  UnitFileNameExtractor in 'Units\DownloaderUnits\UnitFileNameExtractor.pas',
  UnitImageResize in 'Units\DownloaderUnits\UnitImageResize.pas',
  UnitImageTypeExtractor in 'Units\DownloaderUnits\UnitImageTypeExtractor.pas',
  UnitYouTubeVideoInfoExtractor in 'Units\InfoExtraction\UnitYouTubeVideoInfoExtractor.pas',
  UnitSettings in 'Forms\UnitSettings.pas' {SettingsForm},
  MediaInfoDLL in 'Units\MediaInfoDLL.pas',
  UnitLogs in 'Forms\UnitLogs.pas' {LogForm},
  UnitBatchAdd in 'Forms\UnitBatchAdd.pas' {BatchAddForm},
  UnitAbout in 'Forms\UnitAbout.pas' {AboutForm},
  DownloadItemFrame in 'Forms\DownloadItemFrame.pas' {DownloadUIItem: TFrame},
  UnitYoutubedlUpdateChecker in 'Forms\UnitYoutubedlUpdateChecker.pas' {YoutubedlUpdateChecker},
  UnitPreview in 'Forms\UnitPreview.pas' {PreviewForm},
  UnitYouTubeDlVersionReader in 'Units\VersionCheck\UnitYouTubeDlVersionReader.pas',
  UnitYTSearch in 'YoutubeSearch\UnitYTSearch.pas',
  UnitCommonMethods in 'Units\Common\UnitCommonMethods.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Emerald Light Slate');
  Application.Title := 'TVideoDownloader';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TLogForm, LogForm);
  Application.CreateForm(TBatchAddForm, BatchAddForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TYoutubedlUpdateChecker, YoutubedlUpdateChecker);
  Application.CreateForm(TPreviewForm, PreviewForm);
  Application.Run;

end.
