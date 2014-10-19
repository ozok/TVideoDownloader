program TVideoDownloader;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  UnitMain in 'Forms\UnitMain.pas' {MainForm} ,
  UnitDownloadProcess in 'Units\UnitDownloadProcess.pas',
  UnitCommonTypes in 'Units\DownloaderUnits\UnitCommonTypes.pas',
  UnitFileNameExtractor in 'Units\DownloaderUnits\UnitFileNameExtractor.pas',
  UnitImageResize in 'Units\DownloaderUnits\UnitImageResize.pas',
  UnitImageTypeExtractor in 'Units\DownloaderUnits\UnitImageTypeExtractor.pas',
  UnitYouTubeVideoInfoExtractor in 'Units\DownloaderUnits\UnitYouTubeVideoInfoExtractor.pas',
  UnitSettings in 'Forms\UnitSettings.pas' {SettingsForm} ,
  MediaInfoDLL in 'Units\MediaInfoDLL.pas',
  windows7taskbar in 'Units\windows7taskbar.pas',
  UnitLogs in 'Forms\UnitLogs.pas' {LogForm} ,
  UnitBatchAdd in 'Forms\UnitBatchAdd.pas' {BatchAddForm} ,
  UnitAbout in 'Forms\UnitAbout.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'TVideoDownloader';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TLogForm, LogForm);
  Application.CreateForm(TBatchAddForm, BatchAddForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;

end.
