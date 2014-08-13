unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, sSkinManager,
  Vcl.StdCtrls, sComboBox, Vcl.ComCtrls, acProgressBar, sCheckBox, Vcl.Buttons,
  sBitBtn, sScrollBox, sEdit, sLabel, Vcl.ExtCtrls, sPanel, Vcl.Menus, acImage,
  sButton, Generics.Collections, UnitEncoder, Vcl.Mask, sMaskEdit,
  sCustomComboEdit, sToolEdit, JvComponentBase, JvComputerInfoEx, StrUtils, MediaInfoDll, windows7taskbar, UnitCommonTypes,
  JvTrayIcon, acPNG, UnitYouTubeVideoInfoExtractor, ShellAPI, Winapi.MMSystem, IniFiles,
  JvUrlListGrabber, JvUrlGrabbers, JvThread;

type
  TVideoDownloaderItem = class(TCustomControl)
    Panel: TsPanel;
    Panel2: TsPanel;
    Panel3: TsPanel;
    LinkLabel: TsLabel;
    ProgressLabel: TsLabel;
    PrevievImg: TsImage;
    DeleteButton: TsButton;
    FileNameLabel: TsLabel;
    FormatList: TsComboBox;
    SubtitleList: TsComboBox;
    ProgressBar: TsProgressBar;
    procedure ResetProgressLabel;
    constructor Create(const ParentControl: TsScrollBox; const _Index: integer; const PreviousBottom: Integer);
    Destructor Destroy; override;
  end;

  TVideoDownloaderItemList = TList<TVideoDownloaderItem>;

type
  TMainForm = class(TForm)
    PassPnl: TsPanel;
    sLabel1: TsLabel;
    UserEdit: TsEdit;
    PassEdit: TsEdit;
    VideoDownloaderList: TsScrollBox;
    VideoDownloadToolBarPanel: TsPanel;
    AddLinkBtn: TsBitBtn;
    ClearLinksBtn: TsBitBtn;
    SettingsBtn: TsBitBtn;
    StartDownloadBtn: TsBitBtn;
    StopDownloadBtn: TsBitBtn;
    PassBtn: TsBitBtn;
    ProgressPanel: TsPanel;
    sPanel3: TsPanel;
    VideoDownloaderProgressLabel: TsLabel;
    TotalBar: TsProgressBar;
    PostEncodeList2: TsComboBox;
    OutputPanel: TsPanel;
    AddLinkMenu: TPopupMenu;
    A3: TMenuItem;
    Batchaddlinks1: TMenuItem;
    A2: TMenuItem;
    Batchaddplaylists1: TMenuItem;
    DirectoryEdit: TsDirectoryEdit;
    OpenOutBtn: TsButton;
    Info: TJvComputerInfoEx;
    VideoDownloaderPosTimer: TTimer;
    TrayIcon: TJvTrayIcon;
    MainMenu1: TMainMenu;
    L1: TMenuItem;
    E1: TMenuItem;
    H1: TMenuItem;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    NormalPanel: TsPanel;
    LoadPanel: TsPanel;
    Image1: TImage;
    AbortVideoAddBtn: TsBitBtn;
    VideoAddBar: TsProgressBar;
    CheckUpdateThread: TJvThread;
    UpdateChecker: TJvHttpUrlGrabber;
    Addalink1: TMenuItem;
    Addlinksinbatch1: TMenuItem;
    Addplaylistuser1: TMenuItem;
    Addplaylistsusersinbatch1: TMenuItem;
    R1: TMenuItem;
    A1: TMenuItem;
    C1: TMenuItem;
    N1: TMenuItem;
    C3: TMenuItem;
    N2: TMenuItem;
    M1: TMenuItem;
    S1: TMenuItem;
    LogsBtn: TsBitBtn;
    S2: TMenuItem;
    DonateBtn: TsBitBtn;
    ProcessingPanel: TsPanel;
    procedure AddLinkBtnClick(Sender: TObject);
    procedure ClearLinksBtnClick(Sender: TObject);
    procedure PassBtnClick(Sender: TObject);
    procedure StopDownloadBtnClick(Sender: TObject);
    procedure StartDownloadBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure A3Click(Sender: TObject);
    procedure AbortVideoAddBtnClick(Sender: TObject);
    procedure VideoDownloaderPosTimerTimer(Sender: TObject);
    procedure CheckUpdateThreadExecute(Sender: TObject; Params: Pointer);
    procedure UpdateCheckerDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Batchaddlinks1Click(Sender: TObject);
    procedure A2Click(Sender: TObject);
    procedure Batchaddplaylists1Click(Sender: TObject);
    procedure OpenOutBtnClick(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure C3Click(Sender: TObject);
    procedure LogsBtnClick(Sender: TObject);
    procedure S2Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure M1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
  private
    { Private declarations }
    FDownloadItems: TDownloadItemList;
    // video download list items
    FVideoDownloadListItems: TVideoDownloaderItemList;
    FProgressStrs: array [0 .. 15] of string;
    // total download cmd
    FVideoDownloadTotalCMDCount: Integer;
    // time passed downloading
    // todo: use this
    FVideoDownloaderTime: Integer;
    FStopAddingLink: Boolean;
    FSkippedVideoCount: integer;
    FMyDocFolder: string;

    // backend paths
    YouTubePath: string;
    FFMpegPath: string;
    FTempFolder: string;
    FRenamePath: string;
    Mp4BoxPath: string;
    // backend paths
    // list of output files to be checked
    FFilesToCheck: TStringList;

    // create guid file name
    function CreateTempName: string;
    // check if video has audio
    function HasAudio(const FileName: string): Boolean;
    // add line to log
    procedure AddToLog(const LogID: Integer; const Msg: string);
    procedure SaveDownloadLogs;
    //
    function VideoTypeToAudio(const TypeStr: string): string;
    function VideoTypeToAudioCode(const TypeStr: string): string;
    function VideoTypeToVideo(const TypeStr: string): string;
    // UI
    procedure DownloadState;
    procedure DownloadNormalState;
    procedure MenuState(const _Enabled: Boolean);
    // download progress
    procedure UpdateDownloadProgressUI;
    function GetStatusInfo(const ProcessIndex: Integer): string;
    function GetProgress(const ProcessIndex: Integer): Integer;
    // clear temp folder
    procedure ClearTempFolderEx(const DeleteOnlyText: Boolean);
    // add a link to the list
    procedure AddURL(const Url: string);
    // download item events
    procedure DeleteBtnClick(Sender: TObject);
    procedure FormatListChange(Sender: TObject);
    procedure SubListChange(Sender: TObject);
    procedure LabelClick(Sender: TObject);
    // check output files and report broken/missing ones.
    // returns true if everything is OK
    function CheckOutputFiles(out MissingFiles: TStringList): Boolean;
    function GetFileSizeEx(const FilePath: string): Int64;
    // post encode
    function ShutDown(RebootParam: Longword): Boolean;
    // save/load settings
    procedure SaveOptions();
    procedure LoadOptions();

    procedure ProcessPanelVisibility(const Visible: Boolean);
  public
    { Public declarations }
    FLogFolder: string;
    // download processes
    FVideoDownloadProcesses: array [0 .. 15] of TEncoder;
    // add linksin batch
    procedure BatchAdd(const Links: TStrings; const SingleLink: Boolean);
  end;

var
  MainForm: TMainForm;

const
  Portable = True;
  BuildInt = 63;

implementation

{$R *.dfm}

uses UnitSettings, UnitLogs, UnitBatchAdd, UnitAbout;

procedure TMainForm.A1Click(Sender: TObject);
begin
  Self.Enabled := False;
  AboutForm.Show;
end;

procedure TMainForm.A2Click(Sender: TObject);
Var
  LURL: string;
  LYIE: TYouTubeVideoInfoExtractor;
  I: Integer;
  LPass: TUserPass;
begin
  LURL := InputBox('Playlist or user', 'Enter the URL:', '');
  if Length(LURL) > 0 then
  begin
    LPass.UserName := UserEdit.Text;
    LPass.Password := PassEdit.Text;
    LYIE := TYouTubeVideoInfoExtractor.Create(LURL, YouTubePath, FTempFolder, LPass, not SettingsForm.DontPreviewImgBtn.Checked);
    LYIE.GetPlayListInfo;
    AbortVideoAddBtn.Top := (LoadPanel.Height div 2) - (AbortVideoAddBtn.Height div 2);
    LoadPanel.Visible := True;
    LoadPanel.BringToFront;
    MenuState(false);
    FStopAddingLink := False;
    try
      LoadPanel.Caption := 'Extracting video links from playlist, this may take a while...';
      while LYIE.PlaylistStatus = stReading do
      begin
        if FStopAddingLink then
        begin
          LYIE.StopAll;
          Break;
        end;
        Application.ProcessMessages;
        Sleep(100);
      end;
      if not FStopAddingLink then
      begin
        if LYIE.PlayListVideoLinks.Count > 0 then
        begin
          if LogForm.Main.Lines.Count > 0 then
          begin
            AddToLog(0, '');
          end;
          AddToLog(0, 'Found ' + FloatToStr(LYIE.PlayListVideoLinks.Count) + ' videos.');
          AddToLog(0, '');
          for I := 0 to LYIE.PlayListVideoLinks.Count - 1 do
          begin
            if FStopAddingLink then
            begin
              Break;
            end;
            LoadPanel.Caption := 'Adding videos to the list...(' + FloatToStr(i + 1) + '/' + FloatToStr(LYIE.PlayListVideoLinks.Count) + ')';
            AddURL('http://www.youtube.com/watch?v=' + LYIE.PlayListVideoLinks[i]);
          end;
        end
        else
        begin
          Application.MessageBox('Could not get any links from playlist.', 'Error', MB_ICONERROR);
        end;
      end;
    finally
      LYIE.Free;
      Self.Enabled := True;
      LoadPanel.Visible := False;
      // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
      MenuState(true);
    end;
  end;
end;

procedure TMainForm.A3Click(Sender: TObject);
var
  LURL: string;
begin
  LURL := InputBox('Enter URL', 'Enter URL:', '');
  LURL := ReplaceText(LURL, 'https://', 'http://');

  if Length(Trim(LURL)) > 0 then
  begin
    AbortVideoAddBtn.Top := (LoadPanel.Height div 2) - (AbortVideoAddBtn.Height div 2);
    LoadPanel.Visible := True;
    LoadPanel.BringToFront;
    MenuState(False);
    FStopAddingLink := False;
    // SendMessage(LinkList.Handle, WM_SETREDRAW, 0, 0);
    try
      LoadPanel.Caption := 'Adding given URL to list...';
      AddURL(Trim(LURL));
    finally
      Self.Enabled := True;
      LoadPanel.Visible := False;
      // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
      MenuState(true);
    end;
  end;
end;

procedure TMainForm.AbortVideoAddBtnClick(Sender: TObject);
begin
  FStopAddingLink := True;
end;

procedure TMainForm.AddLinkBtnClick(Sender: TObject);
var
  P: TPoint;
begin
  P := AddLinkBtn.ClientToScreen(Point(0, 0));

  AddLinkMenu.Popup(P.X, P.Y + AddLinkBtn.Height)
end;

procedure TMainForm.AddToLog(const LogID: Integer; const Msg: string);
begin
  case LogID of
    0: // main log
      begin
        if Length(Msg) > 0 then
        begin
          LogForm.Main.Lines.Add('[' + DateTimeToStr(Now) + '] ' + Msg);
        end
        else
        begin
          LogForm.Main.Lines.Add('');
        end;
      end;
  end;
end;

procedure TMainForm.AddURL(const Url: string);
var
  YIE: TYouTubeVideoInfoExtractor;
  I: Integer;
  LDownloadItem: TDownloadItem;
  LVideoDownloaderItem: TVideoDownloaderItem;
  LPass: TUserPass;
begin
  if Length(Url) > 0 then
  begin
    LPass.UserName := UserEdit.Text;
    LPass.Password := PassEdit.Text;
    YIE := TYouTubeVideoInfoExtractor.Create(Url, YouTubePath, FTempFolder, LPass, not SettingsForm.DontPreviewImgBtn.Checked);
    try
      // read info from link
      YIE.Start;
      while (YIE.FormatStatus = stReading) or (YIE.ThumbStatus = stReading) or (YIE.TitleStatus = stReading) or (YIE.SubtitleStatus = stReading) do
      begin
        if FStopAddingLink then
        begin
          YIE.StopAll;
          Break;
        end;
        Application.ProcessMessages;
        Sleep(100);
      end;
      if not FStopAddingLink then
      begin
        if YIE.FormatList.Count > 0 then
        begin
          LDownloadItem := TDownloadItem.Create;
          LDownloadItem.Formats.AddStrings(YIE.FormatList);
          for I := 0 to LDownloadItem.Formats.Count - 1 do
          begin
            Application.ProcessMessages;
            // select the one meets user's selection
            if ContainsText(LDownloadItem.Formats[i], SettingsForm.PreferedFormatEdit.Text) then
            begin
              LDownloadItem.FormatIndex := i;
              Break;
            end;
          end;
          LDownloadItem.FormatIntegers.AddStrings(YIE.FormatInts);
          // that means couldnt find 1080p dash
          if LDownloadItem.FormatIndex = -1 then
          begin
            LDownloadItem.FormatIndex := YIE.FormatList.Count - 1;
          end;
          LDownloadItem.ImagePath := YIE.ImageName;
          LDownloadItem.OutputExtensions.AddStrings(YIE.OutExt);
          LDownloadItem.OutputExtensionIndex := 0;
          LDownloadItem.OutputFileName := YIE.FileName;
          LDownloadItem.Subtitles.AddStrings(YIE.Subtitles);
          LDownloadItem.SubIndex := 0;
          LDownloadItem.LinkType := YIE.LinkType;
          FDownloadItems.Add(LDownloadItem);
          LVideoDownloaderItem := TVideoDownloaderItem.Create(VideoDownloaderList, FVideoDownloadListItems.Count, FVideoDownloadListItems.Count * 110);
          LVideoDownloaderItem.LinkLabel.Caption := Url;
          LVideoDownloaderItem.FileNameLabel.Caption := YIE.FileName;
          LVideoDownloaderItem.FileNameLabel.Hint := LVideoDownloaderItem.FileNameLabel.Caption;
          // load program icon if download of thumb fails or user selected not to load it
          if FileExists(YIE.ImageName) then
          begin
            LVideoDownloaderItem.PrevievImg.Picture.LoadFromFile(YIE.ImageName);
          end
          else
          begin
            LVideoDownloaderItem.PrevievImg.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\icon.ico');
          end;
          LVideoDownloaderItem.DeleteButton.OnClick := DeleteBtnClick;
          LVideoDownloaderItem.ProgressLabel.Caption := 'Waiting...';
          VideoDownloaderList.InsertControl(LVideoDownloaderItem.Panel);
          LVideoDownloaderItem.FormatList.Items.AddStrings(YIE.FormatList);
          LVideoDownloaderItem.FormatList.ItemIndex := LDownloadItem.FormatIndex;
          LVideoDownloaderItem.FormatList.OnChange := FormatListChange;
          LVideoDownloaderItem.SubtitleList.Items.AddStrings(YIE.Subtitles);
          LVideoDownloaderItem.SubtitleList.ItemIndex := LDownloadItem.SubIndex;
          LVideoDownloaderItem.SubtitleList.OnChange := SubListChange;
          LVideoDownloaderItem.LinkLabel.OnClick := LabelClick;
          FVideoDownloadListItems.Add(LVideoDownloaderItem);
        end
        else
        begin
          AddToLog(0, 'Unable to add ' + Url + '. (Couldn''t find any formats)');
        end;
      end;
    finally
      YIE.Free;
    end;
  end;
end;

procedure TMainForm.BatchAdd(const Links: TStrings; const SingleLink: Boolean);
Var
  LURL: string;
  LYIE: TYouTubeVideoInfoExtractor;
  I, j: Integer;
  LPass: TUserPass;
begin
  if Links.Count > 0 then
  begin
    AbortVideoAddBtn.Top := (LoadPanel.Height div 2) - (AbortVideoAddBtn.Height div 2);
    LoadPanel.Caption := 'Please wait...';
    LoadPanel.Visible := True;
    LoadPanel.BringToFront;
    MenuState(False);
    FStopAddingLink := False;
    // SendMessage(LinkList.Handle, WM_SETREDRAW, 0, 0);
    try
      for I := 0 to Links.Count - 1 do
      begin
        if FStopAddingLink then
        begin
          Break;
        end;
        Application.ProcessMessages;
        LURL := Trim(Links[i]);
        if Length(LURL) > 0 then
        begin
          if SingleLink then
          begin
            // normal link
            LoadPanel.Caption := 'Adding videos to the list...(' + FloatToStr(i + 1) + '/' + FloatToStr(Links.Count) + ')';
            AddURL(LURL);
          end
          else
          begin
            // playlist
            LoadPanel.Caption := 'Extracting video links from playlist, this may take a while...';
            LPass.UserName := UserEdit.Text;
            LPass.Password := PassEdit.Text;
            LYIE := TYouTubeVideoInfoExtractor.Create(LURL, YouTubePath, FTempFolder, LPass, not SettingsForm.DontPreviewImgBtn.Checked);
            try
              LYIE.GetPlayListInfo;
              while (LYIE.PlaylistStatus = stReading) and (not FStopAddingLink) do
              begin
                Application.ProcessMessages;
                Sleep(10);
              end;
              if LYIE.PlayListVideoLinks.Count > 0 then
              begin
                for j := 0 to LYIE.PlayListVideoLinks.Count - 1 do
                begin
                  LoadPanel.Caption := 'Adding videos to the list...(' + FloatToStr(j + 1) + '/' + FloatToStr(LYIE.PlayListVideoLinks.Count) + ')';
                  AddURL('http://www.youtube.com/watch?v=' + LYIE.PlayListVideoLinks[j]);
                end;
              end
              else
              begin
                // show only if user didnt stop
                if not FStopAddingLink then
                begin
                  Application.MessageBox('Could not get any links from playlist.', 'Error', MB_ICONERROR);
                end;
              end;
            finally
              LYIE.Free;
            end;
          end;
        end;
      end;
    finally
      Self.Enabled := True;
      LoadPanel.Visible := False;
      // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
      MenuState(true);
    end;
  end;
end;

procedure TMainForm.Batchaddlinks1Click(Sender: TObject);
begin
  Self.Enabled := False;
  BatchAddForm.PMode := SingleLink;
  BatchAddForm.Show;
end;

procedure TMainForm.Batchaddplaylists1Click(Sender: TObject);
begin
  Self.Enabled := False;
  BatchAddForm.PMode := Playlist;
  BatchAddForm.Show;
end;

procedure TMainForm.C1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar(ExtractFileDir(Application.ExeName) + '\changelog.txt'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.C3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar(ExtractFileDir(Application.ExeName) + '\tools\youtube-dl.exe'), '-U', nil, SW_SHOWNORMAL);
end;

function TMainForm.CheckOutputFiles(out MissingFiles: TStringList): Boolean;
var
  I: Integer;
begin
  for I := 0 to FFilesToCheck.Count - 1 do
  begin
    // if output doesnt exist
    if not FileExists(FFilesToCheck[i]) then
    begin
      MissingFiles.Add(FFilesToCheck[i]);
      AddToLog(0, 'Missing output file ' + FFilesToCheck[i] + '.');
    end
    else
    begin
      // if file is empty
      if GetFileSizeEx(FFilesToCheck[i]) < 1 then
      begin
        MissingFiles.Add(FFilesToCheck[i]);
        AddToLog(0, 'Output file ' + FFilesToCheck[i] + ' is empty.');
      end;
    end;
  end;
  Result := 0 <> MissingFiles.Count;
end;

procedure TMainForm.CheckUpdateThreadExecute(Sender: TObject; Params: Pointer);
begin
  UpdateChecker.Url := 'http://sourceforge.net/projects/tvideodownloader/files/version.txt/download';
  UpdateChecker.Start;

  CheckUpdateThread.CancelExecute;
end;

procedure TMainForm.ClearLinksBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    FVideoDownloadListItems[i].Panel.Visible := False;
    FVideoDownloadListItems[i].Free;
  end;
  FVideoDownloadListItems.Clear;
  FDownloadItems.Clear;
end;

procedure TMainForm.ClearTempFolderEx(const DeleteOnlyText: Boolean);
var
  lSearchRec: TSearchRec;
  lFind: integer;
  lPath: string;
  LType: string;
begin
  lPath := IncludeTrailingPathDelimiter(FTempFolder);
  if DeleteOnlyText then
  begin
    LType := '*.txt';
  end
  else
  begin
    LType := '*.*';
  end;
  try
    lFind := FindFirst(lPath + LType, faAnyFile, lSearchRec);
    while lFind = 0 do
    begin
      DeleteFile(lPath + lSearchRec.Name);

      lFind := FindNext(lSearchRec);
    end;
  finally
    FindClose(lSearchRec);
  end;
end;

function TMainForm.CreateTempName: string;
var
  LGUID: TGUID;
begin
  CreateGUID(LGUID);
  Result := GUIDToString(LGUID);
end;

procedure TMainForm.DownloadState;
var
  I: Integer;
  j: Integer;
begin
  StartDownloadBtn.Enabled := False;
  AddLinkBtn.Enabled := False;
  DirectoryEdit.Enabled := False;
  ClearLinksBtn.Enabled := False;
  StopDownloadBtn.Enabled := True;
  SettingsBtn.Enabled := False;
  PassBtn.Enabled := False;
  if PassPnl.Visible then
  begin
    PassPnl.Visible := False;
  end;
  if PassBtn.Down then
  begin
    PassBtn.Down := False;
  end;
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    for j := 0 to FVideoDownloadListItems[i].Panel.ControlCount - 1 do
    begin
      if (FVideoDownloadListItems[i].Panel.Controls[j] is TsComboBox) or (FVideoDownloadListItems[i].Panel.Controls[j] is TsButton) then
        FVideoDownloadListItems[i].Panel.Controls[j].Enabled := False;
    end;
    for j := 0 to FVideoDownloadListItems[i].Panel2.ControlCount - 1 do
    begin
      if (FVideoDownloadListItems[i].Panel2.Controls[j] is TsComboBox) or (FVideoDownloadListItems[i].Panel2.Controls[j] is TsButton) then
        FVideoDownloadListItems[i].Panel2.Controls[j].Enabled := False;
    end;
    for j := 0 to FVideoDownloadListItems[i].Panel3.ControlCount - 1 do
    begin
      if (FVideoDownloadListItems[i].Panel3.Controls[j] is TsComboBox) or (FVideoDownloadListItems[i].Panel3.Controls[j] is TsButton) then
        FVideoDownloadListItems[i].Panel3.Controls[j].Enabled := False;
    end;
  end;
  for I := 0 to MainMenu1.Items.Count - 1 do
  begin
    MainMenu1.Items[i].Enabled := False;
  end;
end;

procedure TMainForm.DeleteBtnClick(Sender: TObject);
var
  LItemIndex: integer;
begin
  LItemIndex := (Sender as TsButton).Tag;
  FVideoDownloadListItems[LItemIndex].Panel.Visible := False;
  FVideoDownloadListItems.Delete(LItemIndex);
  FDownloadItems.Delete(LItemIndex);
end;

procedure TMainForm.DownloadNormalState;
var
  I: Integer;
  j: Integer;
begin
  StartDownloadBtn.Enabled := True;
  AddLinkBtn.Enabled := True;
  DirectoryEdit.Enabled := True;
  ClearLinksBtn.Enabled := True;
  StopDownloadBtn.Enabled := False;
  SettingsBtn.Enabled := True;
  PassBtn.Enabled := True;
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    for j := 0 to FVideoDownloadListItems[i].Panel.ControlCount - 1 do
    begin
      if (FVideoDownloadListItems[i].Panel.Controls[j] is TsComboBox) or (FVideoDownloadListItems[i].Panel.Controls[j] is TsButton) then
        FVideoDownloadListItems[i].Panel.Controls[j].Enabled := True;
    end;
    for j := 0 to FVideoDownloadListItems[i].Panel2.ControlCount - 1 do
    begin
      if (FVideoDownloadListItems[i].Panel2.Controls[j] is TsComboBox) or (FVideoDownloadListItems[i].Panel2.Controls[j] is TsButton) then
        FVideoDownloadListItems[i].Panel2.Controls[j].Enabled := True;
    end;
    for j := 0 to FVideoDownloadListItems[i].Panel3.ControlCount - 1 do
    begin
      if (FVideoDownloadListItems[i].Panel3.Controls[j] is TsComboBox) or (FVideoDownloadListItems[i].Panel3.Controls[j] is TsButton) then
        FVideoDownloadListItems[i].Panel3.Controls[j].Enabled := True;
    end;
  end;
  for I := 0 to MainMenu1.Items.Count - 1 do
  begin
    MainMenu1.Items[i].Enabled := True;
  end;
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    for j := 0 to FVideoDownloadListItems[i].Panel.ControlCount - 1 do
    begin
      FVideoDownloadListItems[i].Panel.Controls[j].Enabled := True;
      if FVideoDownloadListItems[i].Panel.Controls[j] is TsProgressBar then
      begin
        TsProgressBar(FVideoDownloadListItems[i].Panel.Controls[j]).Position := 0;
      end;
      FVideoDownloadListItems[i].ResetProgressLabel;
    end;
  end;

  Self.Caption := 'TVideoDownloader';
  TotalBar.Position := 0;
  VideoDownloaderProgressLabel.Caption := 'Progress: 0/0';
  SetProgressValue(Handle, 0, MaxInt);
end;

procedure TMainForm.FormatListChange(Sender: TObject);
var
  LItemIndex: Integer;
  LTmp: TDownloadItem;
begin
  LItemIndex := (Sender as TsComboBox).Tag;
  LTmp := FDownloadItems[LItemIndex];
  LTmp.FormatIndex := (Sender as TsComboBox).ItemIndex;
  FDownloadItems[LItemIndex] := LTmp;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  SaveOptions;
  for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
  begin
    FVideoDownloadProcesses[i].Stop;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FDownloadItems := TDownloadItemList.Create;
  FVideoDownloadListItems := TVideoDownloaderItemList.Create;
  for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
    FVideoDownloadProcesses[i] := TEncoder.Create;
  FFilesToCheck := TStringList.Create;
  // windows 7 taskbar
  if CheckWin32Version(6, 1) then
  begin
    if not InitializeTaskbarAPI then
    begin
      Application.MessageBox('You seem to have Windows 7 but program can''t start taskbar progressbar!', 'Error', MB_ICONERROR);
    end;
  end;
  if not MediaInfoDLL_Load(ExtractFileDir(Application.ExeName) + '\mediainfo.dll') then
  begin
    Application.MessageBox('Couldn''t load mediainfo.dll library.', 'Fatal Error', MB_ICONERROR);
    Application.Terminate;
  end;

  if not Portable then
  begin
    FMyDocFolder := Info.Folders.Personal + '\TVideoDownloader\';
    FLogFolder := Info.Folders.AppData + '\TVideoDownloader';
  end
  else
  begin
    FLogFolder := ExtractFileDir(Application.ExeName) + '\';
    FMyDocFolder := FLogFolder;
  end;

  if not DirectoryExists(FLogFolder) then
  begin
    ForceDirectories(FLogFolder);
  end;
  YouTubePath := ExtractFileDir(Application.ExeName) + '\tools\youtube-dl.exe';
  if not FileExists(YouTubePath) then
  begin
    Application.MessageBox('Cannot find youtube-dl!', 'Fatal Error', MB_ICONERROR);
    Application.Terminate;
  end;
  FFMpegPath := ExtractFileDir(Application.ExeName) + '\tools\ffmpeg.exe';
  if not FileExists(FFMpegPath) then
  begin
    Application.MessageBox('Cannot find ffmpeg!', 'Fatal Error', MB_ICONERROR);
    Application.Terminate;
  end;
  FRenamePath := ExtractFileDir(Application.ExeName) + '\tools\renametool.exe';
  if not FileExists(FRenamePath) then
  begin
    Application.MessageBox('Cannot find renametool!', 'Fatal Error', MB_ICONERROR);
    Application.Terminate;
  end;
  FTempFolder := Info.Folders.Temp + '\TVideoDownloader';
  if not DirectoryExists(FTempFolder) then
  begin
    ForceDirectories(FTempFolder);
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  FFilesToCheck.Free;
  FDownloadItems.Free;
  FVideoDownloadListItems.Free;
  for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
    FVideoDownloadProcesses[i].Free;
end;

procedure TMainForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VideoDownloaderList.Perform(WM_VSCROLL, 1, 0)
end;

procedure TMainForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VideoDownloaderList.Perform(WM_VSCROLL, 0, 0)
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  LoadOptions;
end;

function TMainForm.GetFileSizeEx(const FilePath: string): Int64;
var
  LFS: TFileStream;
begin
  Result := 0;
  if FileExists(FilePath) then
  begin
    LFS := TFileStream.Create(FilePath, fmOpenRead and fmShareDenyNone);
    try
      try
        Result := LFS.Size;
      except
        on E: EFOpenError do
          AddToLog(0, 'Unable to check file size for ' + ExtractFileName(FilePath) + ' because it is in use.');
      end;
    finally
      LFS.Free;
    end;
  end;
end;

function TMainForm.GetProgress(const ProcessIndex: Integer): Integer;
var
  StrPos1, StrPos2: Integer;
  TmpStr: string;
  TmpInt: Integer;
begin
  Result := 0;
  TmpStr := FVideoDownloadProcesses[ProcessIndex].ConsoleOutput;
  StrPos1 := Pos('[download]', TmpStr);
  StrPos2 := Pos('%', TmpStr);
  TmpStr := Trim(copy(TmpStr, StrPos1 + 10, StrPos2 - StrPos1 - 12));
  if TryStrToInt(TmpStr, TmpInt) then
  begin
    Result := TmpInt;
  end;
end;

function TMainForm.GetStatusInfo(const ProcessIndex: Integer): string;
const
  Download_STR = '[download]';
begin
  if FVideoDownloadProcesses[ProcessIndex].CurrentProcessType = '5' then
  begin
    if copy(FVideoDownloadProcesses[ProcessIndex].ConsoleOutput, 1, Length(Download_STR)) = Download_STR then
    begin
      Result := FVideoDownloadProcesses[ProcessIndex].Info + ' ' + Trim(StringReplace(FVideoDownloadProcesses[ProcessIndex].ConsoleOutput, Download_STR, '', [rfReplaceAll, rfIgnoreCase]))
    end;
  end
  else if FVideoDownloadProcesses[ProcessIndex].CurrentProcessType = '2' then
  begin
    Result := 'Muxing...';
  end
  else if FVideoDownloadProcesses[ProcessIndex].CurrentProcessType = '7' then
  begin
    Result := FVideoDownloadProcesses[ProcessIndex].Info + ' ' + FVideoDownloadProcesses[ProcessIndex].ConsoleOutput;
  end
  else
  begin
    Result := 'N/A';
  end;
end;

function TMainForm.HasAudio(const FileName: string): Boolean;
var
  MediaInfoHandle: Cardinal;
  LAudioCount: string;
  LAudioCountInt: Integer;
begin
  Result := false;
  if (FileExists(FileName)) then
  begin
    // New handle for mediainfo
    MediaInfoHandle := MediaInfo_New();
    if MediaInfoHandle <> 0 then
    begin
      try
        // Open a file in complete mode
        MediaInfo_Open(MediaInfoHandle, PWideChar(FileName));
        MediaInfo_Option(0, 'Complete', '1');

        // get length
        LAudioCount := MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'Count', Info_Text, Info_Name);

        if Length(LAudioCount) > 0 then
        begin
          if TryStrToInt(LAudioCount, LAudioCountInt) then
          begin
            if LAudioCountInt > 0 then
            begin
              Result := True;
            end;
          end;
        end;
      finally
        MediaInfo_Close(MediaInfoHandle);
      end;
    end;
  end;
end;

procedure TMainForm.LabelClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PWideChar(TsLabel(Sender).Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.LoadOptions;
var
  OptionFile: TIniFile;
begin
  OptionFile := TIniFile.Create(FLogFolder + '\settings.ini');
  try
    with OptionFile do
    begin
      PostEncodeList2.ItemIndex := ReadInteger('Options', 'PostEncode2', 0);
      DirectoryEdit.Text := ReadString('Options', 'Out', FMyDocFolder);
      if ReadBool('Options', 'Update', True) then
      begin
        CheckUpdateThread.Execute(nil);
      end;
    end;
  finally
    OptionFile.Free;
  end;
end;

procedure TMainForm.LogsBtnClick(Sender: TObject);
begin
  LogForm.Show;
end;

procedure TMainForm.M1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2DCLCV369NLBW', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.MenuState(const _Enabled: Boolean);
var
  I: Integer;
begin
  for I := 0 to MainMenu1.Items.Count - 1 do
  begin
    MainMenu1.Items[i].Enabled := _Enabled;
  end;
  if _Enabled then
  begin
    VideoAddBar.Style := pbstNormal;
  end
  else
  begin
    VideoAddBar.Style := pbstMarquee;
  end;
end;

procedure TMainForm.OpenOutBtnClick(Sender: TObject);
begin
  if (DirectoryExists(DirectoryEdit.Text)) then
  begin
    ShellExecute(Application.Handle, 'open', PChar(DirectoryEdit.Text), nil, nil, SW_SHOWNORMAL);
  end
  else
  begin
    Application.MessageBox('Cannot open output folder because it does not exist!', 'Error', MB_ICONERROR);
  end;
end;

procedure TMainForm.PassBtnClick(Sender: TObject);
begin
  if PassPnl.Visible then
  begin
    // hide
    PassPnl.Visible := False;
    PassBtn.Down := False;
  end
  else
  begin
    // show
    PassPnl.Visible := True;
    PassBtn.Down := True;
  end;
end;

procedure TMainForm.ProcessPanelVisibility(const Visible: Boolean);
begin
  if Visible then
  begin
    ProcessingPanel.Left := (Self.Width div 2) - (ProcessingPanel.Width div 2);
    ProcessingPanel.Top := (Self.Height div 2) - (ProcessingPanel.Height div 2);
    ProcessingPanel.Visible := True;
    ProcessingPanel.BringToFront;
  end
  else
  begin
    ProcessingPanel.Visible := False;
  end;
end;

procedure TMainForm.S1Click(Sender: TObject);
const
  NewLine = '%0D%0A';
var
  mail: PChar;
  mailbody: string;
begin
  mailbody := AboutForm.sLabel1.Caption;
  mailbody := mailbody + NewLine + 'Bugs: ' + NewLine + NewLine + NewLine + 'Suggestions: ' + NewLine + NewLine + NewLine;
  mail := PwideChar('mailto:ozok26@gmail.com?subject=TVideoDownloader&body=' + mailbody);

  ShellExecute(0, 'open', mail, nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.S2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://rg3.github.io/youtube-dl/supportedsites.html', '', nil, SW_SHOWNORMAL);
end;

procedure TMainForm.SaveDownloadLogs;
var
  LStreamWriter: TStreamWriter;
  i: integer;
  j: Integer;
  LContinue: Boolean;
begin
  LContinue := True;
  if not DirectoryExists(fLogFolder) then
  begin
    if not ForceDirectories(fLogFolder) then
    begin
      LContinue := False;
    end;
  end;
  if LContinue then
  begin
    for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
    begin
      Application.ProcessMessages;
      LStreamWriter := TStreamWriter.Create(fLogFolder + '\' + FloatToStr(i + 1) + 'log.txt', False, TEncoding.UTF8);
      try
        for j := 0 to FVideoDownloadProcesses[i].GetConsoleOutput.Count - 1 do
        begin
          Application.ProcessMessages;
          LStreamWriter.WriteLine(FVideoDownloadProcesses[i].GetConsoleOutput[j]);
        end;
      finally
        LStreamWriter.Close;
        LStreamWriter.Free;
      end;
    end;
  end;
end;

procedure TMainForm.SaveOptions;
var
  OptionFile: TIniFile;
begin
  OptionFile := TIniFile.Create(FLogFolder + '\Settings.ini');
  try
    with OptionFile do
    begin
      WriteInteger('Options', 'PostEncode2', PostEncodeList2.ItemIndex);
      WriteString('Options', 'Out', DirectoryEdit.Text);
    end;
  finally
    OptionFile.Free
  end;
end;

procedure TMainForm.SettingsBtnClick(Sender: TObject);
begin
  Self.Enabled := False;
  SettingsForm.Show;
end;

function TMainForm.ShutDown(RebootParam: Longword): Boolean;
var
  TTokenHd: THandle;
  TTokenPvg: TTokenPrivileges;
  cbtpPrevious: DWORD;
  rTTokenPvg: TTokenPrivileges;
  pcbtpPreviousRequired: DWORD;
  tpResult: Boolean;
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    tpResult := OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, TTokenHd);
    if tpResult then
    begin
      tpResult := LookupPrivilegeValue(nil, SE_SHUTDOWN_NAME, TTokenPvg.Privileges[0].Luid);
      TTokenPvg.PrivilegeCount := 1;
      TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      cbtpPrevious := Sizeof(rTTokenPvg);
      pcbtpPreviousRequired := 0;
      if tpResult then
        AdjustTokenPrivileges(TTokenHd, False, TTokenPvg, cbtpPrevious, rTTokenPvg, pcbtpPreviousRequired);
    end;
  end;
  Result := ExitWindowsEx(RebootParam, 0);
end;

procedure TMainForm.StartDownloadBtnClick(Sender: TObject);
var
  i: Integer;
  LSelectedFormatStr: string;
  LStreamWriter: TStreamWriter;
  j: Integer;
  LDownloadedVideoName: string;
  LCMD: string;
  LDownloadSub: Boolean;
  LRenameFile: TStringList;
  LOutputFile: string;
  // LFileNameExtractor: TFileNameExtractor;
  LDASHAudioExt: string;
  LDASHAudioCode: string;
  LDASHVideoExt: string;
  LPos1: integer;
  LPass: string;
begin
  if FVideoDownloadListItems.Count > 0 then
  begin
    ProcessPanelVisibility(True);
    MainForm.Enabled := False;
    try
      LRenameFile := TStringList.Create;
      try
{$REGION 'Dir checks block'}
        if not DirectoryExists(DirectoryEdit.Text) then
        begin
          if ForceDirectories(DirectoryEdit.Text) then
          begin
            if not(ForceDirectories(ExcludeTrailingPathDelimiter(DirectoryEdit.Text))) then
            begin
              Application.MessageBox('Cannot create output folder.', 'Error', MB_ICONERROR);
              Exit;
            end;
          end
          else
          begin
            Application.MessageBox('Cannot create output folder.', 'Error', MB_ICONERROR);
            Exit;
          end;
        end;
{$ENDREGION}
{$REGION 'reset block'}
        // reset
        for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
        begin
          FVideoDownloadProcesses[i].ResetValues;
          FProgressStrs[i] := '';
        end;
        FVideoDownloadTotalCMDCount := 0;
        FVideoDownloaderTime := 0;
        // remove cmd log from last time
        if FileExists(FLogFolder + '\cmd.txt') then
        begin
          DeleteFile(FLogFolder + '\cmd.txt')
        end;
        FSkippedVideoCount := 0;
{$ENDREGION}
        // create command line
        for i := 0 to FVideoDownloadListItems.Count - 1 do
        begin
          Application.ProcessMessages;
          // reset it for each file
          LRenameFile.Clear;

          LDownloadedVideoName := FVideoDownloadListItems[i].FileNameLabel.Caption;
          if SettingsForm.DashVideoBtn.Checked then
          begin
            if ContainsText(LSelectedFormatStr, 'DASH, video') then
            begin
              LDownloadedVideoName := CreateTempName;
            end;
          end;
          // get file name
          LPos1 := PosEx(',', FVideoDownloadListItems[i].FormatList.Text);
          if LPos1 > 1 then
          begin
            LOutputFile := FVideoDownloadListItems[i].FileNameLabel.Caption + '.' + LowerCase(Copy(FVideoDownloadListItems[i].FormatList.Text, 1, LPos1 - 1));
          end;
          // don't download twice
          if SettingsForm.DontDoubleDownloadBtn.Checked then
          begin
            if FileExists(DirectoryEdit.Text + '\' + LOutputFile) then
            begin
              if HasAudio(DirectoryEdit.Text + '\' + LOutputFile) then
              begin
                AddToLog(0, 'Ignoring "' + LOutputFile + '" because it contains audio.');
                FVideoDownloadListItems[i].ProgressLabel.Caption := 'Already downloaded';
                FVideoDownloadListItems[i].ProgressBar.Position := 100;
                Inc(FSkippedVideoCount);
                Continue;
              end;
            end;
          end;
          if (Length(UserEdit.Text) > 0) and (Length(PassEdit.Text) > 0) then
          begin
            LPass := ' -u ' + UserEdit.Text + ' -p ' + PassEdit.Text;
          end;
          // youtube-dl command line
          case FDownloadItems[i].LinkType of
            general:
              begin
                LCMD := ' ' + LPass + ' -o "' + ExcludeTrailingPathDelimiter(DirectoryEdit.Text) + '\%(uploader)s - %(title)s.%(ext)s" -i --no-playlist -f ' + FDownloadItems[i].FormatIntegers[FDownloadItems[i].FormatIndex];
              end;
            soundcloud:
              begin
                LCMD := ' ' + LPass + ' -o "' + ExcludeTrailingPathDelimiter(DirectoryEdit.Text) + '\%(uploader)s - %(title)s.%(ext)s" -i --no-playlist -x --audio-format ' + FDownloadItems[i].FormatIntegers[FDownloadItems[i].FormatIndex];
              end;
          end;
          LDownloadSub := False;
          if FDownloadItems[i].SubIndex > 0 then
          begin
            LCMD := LCMD + ' --write-sub --sub-lang ' + LowerCase(FVideoDownloadListItems[i].SubtitleList.Text);
            LDownloadSub := True;
          end;
          LCMD := LCMD + ' -v -c -w ' + FVideoDownloadListItems[i].LinkLabel.Caption;
          FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].CommandLines.Add(LCMD);
          FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].ProcessTypes.Add('5');
          FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].EncoderPaths.Add(YouTubePath);
          FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].FileIndexes.Add(FloatToStr(i));
          FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].Infos.Add('[Downloading]');
          Inc(FVideoDownloadTotalCMDCount);
          // if dash video selected
          // detect if selected format is indeed dash video only
          LSelectedFormatStr := FVideoDownloadListItems[i].FormatList.Text;
          if SettingsForm.DashVideoBtn.Checked and ContainsText(LSelectedFormatStr, 'DASH, video') then
          begin
            // audio extension and code
            LDASHAudioExt := VideoTypeToAudio(LSelectedFormatStr);
            LDASHVideoExt := VideoTypeToVideo(LSelectedFormatStr);
            LDASHAudioCode := VideoTypeToAudioCode(LSelectedFormatStr);
            // get audio
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].CommandLines.Add(' -o "' + ExcludeTrailingPathDelimiter(DirectoryEdit.Text) + '\%(uploader)s - %(title)s.%(ext)s" -i --no-playlist -f ' + LDASHAudioCode +
              ' -c -w ' + FVideoDownloadListItems[i].LinkLabel.Caption);
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].ProcessTypes.Add('5');
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].EncoderPaths.Add(YouTubePath);
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].FileIndexes.Add(FloatToStr(i));
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].Infos.Add('[Downloading]');
            Inc(FVideoDownloadTotalCMDCount);
            // mux both into video file
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].CommandLines.Add(' -y -i "' + DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + LDASHVideoExt + '" -i "' + DirectoryEdit.Text + '\'
              + FVideoDownloadListItems[i].FileNameLabel.Caption + LDASHAudioExt + '" -acodec copy -vcodec copy "' + DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + '_muxed' + LDASHVideoExt + '"');
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].ProcessTypes.Add('');
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].EncoderPaths.Add(FFMpegPath);
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].FileIndexes.Add(FloatToStr(i));
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].Infos.Add('[Muxing]');
            Inc(FVideoDownloadTotalCMDCount);
            // delete downloaded video and audio files
            // rename muxed video to normal
            LRenameFile.Add(DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + LDASHAudioExt);
            LRenameFile.Add(DirectoryEdit.Text + '\' + LOutputFile);
            LRenameFile.Add(DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + '_muxed' + LDASHVideoExt);
            LRenameFile.SaveToFile(FTempFolder + '\' + FloatToStr(i) + '.txt', TEncoding.UTF8);
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].CommandLines.Add('"' + FRenamePath + '" "' + FTempFolder + '\' + FloatToStr(i) + '.txt"');
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].ProcessTypes.Add('6');
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].EncoderPaths.Add('');
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].FileIndexes.Add(FloatToStr(i));
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].Infos.Add('[Renaming]');
            Inc(FVideoDownloadTotalCMDCount);
          end;
          // file check
          FFilesToCheck.Add(DirectoryEdit.Text + '\' + LOutputFile);

          // remux dash m4a to mp4 audio
          if ContainsText(LSelectedFormatStr, 'M4A, AUDIO, ONLY, DASH') then
          begin
            LCMD := ' -add "' + DirectoryEdit.Text + '\' + LOutputFile + '" -new "' + DirectoryEdit.Text + '\' + LOutputFile + '"';
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].CommandLines.Add(LCMD);
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].ProcessTypes.Add('1');
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].EncoderPaths.Add(Mp4BoxPath);
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].FileIndexes.Add(FloatToStr(i));
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].Infos.Add('[Remuxing]');
            Inc(FVideoDownloadTotalCMDCount);
          end;

          // extract ogg file from webm
          if ContainsText(LSelectedFormatStr, 'WEBM, AUDIO, ONLY, DASH') then
          begin
            LCMD := ' -y -i "' + DirectoryEdit.Text + '\' + LOutputFile + '" -vn -f ogg "' + DirectoryEdit.Text + '\' + ChangeFileExt(LOutputFile, '.ogg') + '"';
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].CommandLines.Add(LCMD);
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].ProcessTypes.Add('1');
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].EncoderPaths.Add(FFMpegPath);
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].FileIndexes.Add(FloatToStr(i));
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].Infos.Add('[Extracting audio]');
            Inc(FVideoDownloadTotalCMDCount);
            FFilesToCheck.Add(DirectoryEdit.Text + '\' + ChangeFileExt(LOutputFile, '.ogg'));
          end;
        end;

        // add commands to log
        with LogForm.CMDLog do
        begin
          Lines.Clear;
          for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
          begin
            Lines.Add('Command lines' + FloatToStr(i + 1) + ':');
            Lines.AddStrings(FVideoDownloadProcesses[i].CommandLines);
          end;
        end;

        AddToLog(0, 'Ignoring ' + FloatToStr(FSkippedVideoCount) + ' files.');

        // start downloading
        if FVideoDownloadTotalCMDCount > 0 then
        begin
          // write commands to text file
          if FileExists(fLogFolder + '\cmd.txt') then
          begin
            DeleteFile(fLogFolder + '\cmd.txt')
          end;
          for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
          begin
            Application.ProcessMessages;
            LStreamWriter := TStreamWriter.Create(fLogFolder + '\cmd.txt', True, TEncoding.UTF8);
            try
              LStreamWriter.WriteLine('Download process' + FloatToStr(i + 1) + ': ');
              for j := 0 to FVideoDownloadProcesses[i].CommandLines.Count - 1 do
              begin
                Application.ProcessMessages;
                LStreamWriter.WriteLine(FVideoDownloadProcesses[i].CommandLines[j]);
              end;
            finally
              LStreamWriter.Close;
              LStreamWriter.Free;
            end;
          end;
          TotalBar.Max := FVideoDownloadTotalCMDCount + FSkippedVideoCount;
          for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
          begin
            if FVideoDownloadProcesses[i].CommandCount > 0 then
            begin
              FVideoDownloadProcesses[i].Start;
            end;
          end;
          VideoDownloaderPosTimer.Enabled := True;
          TrayIcon.Active := True;
          DownloadState();
          SetProgressState(Handle, tbpsNormal);
        end
        else
        begin
          Application.MessageBox('Did not create any commands. Perhaps you already downloaded all videos? Check logs please.', 'Info', MB_ICONINFORMATION);
        end;
      finally
        LRenameFile.Free;
      end;
    finally
      ProcessPanelVisibility(False);
      Self.Enabled := True;
    end;
  end
  else
  begin
    Application.MessageBox('Please add links first.', 'Error', MB_ICONERROR);
  end;
end;

procedure TMainForm.StopDownloadBtnClick(Sender: TObject);
var
  i: integer;
begin
  if ID_YES = Application.MessageBox('Stop downloading?', 'Stop', MB_ICONQUESTION or MB_YESNO) then
  begin
    ProcessPanelVisibility(True);
    try
      VideoDownloaderPosTimer.Enabled := False;
      for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
        FVideoDownloadProcesses[i].Stop;
      ClearTempFolderEx(True);
      DownloadNormalState;
    finally
      ProcessPanelVisibility(false);
    end;
  end;
end;

procedure TMainForm.SubListChange(Sender: TObject);
var
  LItemIndex: Integer;
  LTmp: TDownloadItem;
begin
  LItemIndex := (Sender as TsComboBox).Tag;
  LTmp := FDownloadItems[LItemIndex];
  LTmp.SubIndex := (Sender as TsComboBox).ItemIndex;
  FDownloadItems[LItemIndex] := LTmp;
end;

procedure TMainForm.UpdateDownloadProgressUI;
var
  i: integer;
  j: Integer;
  Lprogress: Integer;
begin
  for j := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
  begin
    if FVideoDownloadProcesses[j].CommandCount > 0 then
    begin
      if FVideoDownloadProcesses[j].EncoderStatus = esEncoding then
      begin
        if FVideoDownloadProcesses[j].FilesDone < FVideoDownloadProcesses[j].CommandCount then
        begin
          for I := 0 to FVideoDownloadProcesses[j].FileIndexes.Count - 1 do
          begin
            Application.ProcessMessages;
            if StrToInt(FVideoDownloadProcesses[j].FileIndexes[i]) < FVideoDownloadProcesses[j].FileIndex then
            begin
              FProgressStrs[j] := 'Done';
              if FProgressStrs[j] <> FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressLabel.Caption then
              begin
                FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressLabel.Caption := 'Done';
              end;
              FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressBar.Position := 100;
            end
            else if StrToInt(FVideoDownloadProcesses[j].FileIndexes[i]) = FVideoDownloadProcesses[j].FileIndex then
            begin
              FProgressStrs[j] := GetStatusInfo(j);
              if FProgressStrs[j] <> FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressLabel.Caption then
              begin
                FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressLabel.Caption := FProgressStrs[j];
              end;
              Lprogress := GetProgress(j);
              if FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressBar.Position <> Lprogress then
              begin
                FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressBar.Position := Lprogress;
              end;
            end;
          end;
        end;
      end
      else
      begin
        if FVideoDownloadProcesses[j].CommandCount > 0 then
        begin
          for I := 0 to FVideoDownloadProcesses[j].FileIndexes.Count - 1 do
          begin
            Application.ProcessMessages;
            FProgressStrs[j] := 'Done';
            if FProgressStrs[j] <> FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressLabel.Caption then
            begin
              FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressLabel.Caption := 'Done';
            end;
            FVideoDownloadListItems[StrToInt(FVideoDownloadProcesses[j].FileIndexes[i])].ProgressBar.Position := 100;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.VideoDownloaderPosTimerTimer(Sender: TObject);
var
  LTotalFilesDone: integer;
  I: Integer;
  LMissingFileList: TStringList;
begin
  LTotalFilesDone := 0;
  for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
  begin
    if FVideoDownloadProcesses[i].CommandCount > 0 then
    begin
      Inc(LTotalFilesDone, FVideoDownloadProcesses[i].FilesDone);
    end;
  end;

  if LTotalFilesDone = FVideoDownloadTotalCMDCount then
  begin
    UpdateDownloadProgressUI;
    VideoDownloaderPosTimer.Enabled := False;
    // TimeTimer.Enabled := False;
    ClearTempFolderEx(True);
    DownloadNormalState;
    if SettingsForm.PlaySoundBtn.Checked then
    begin
      if FileExists(ExtractFileDir(Application.ExeName) + '\done.wav') then
      begin
        sndPlaySound('done.wav', SND_ASYNC);
      end;
    end;
    // save logs
    SaveDownloadLogs;

    // post-encode action
    case PostEncodeList2.ItemIndex of
      0:
        begin
          // check output files
          LMissingFileList := TStringList.Create;
          try
            if CheckOutputFiles(LMissingFileList) then
            begin
              TrayIcon.Active := True;
              TrayIcon.BalloonHint('TVideoDownloader', 'TVideoDownloader failed to download ' + FloatToStr(LMissingFileList.Count) + ' files. Please check logs.', btError, 5000, True);
            end
            else
            begin
              AddToLog(0, 'TVideoDownloader could locate all output files.');
              TrayIcon.Active := True;
              TrayIcon.BalloonHint('TVideoDownloader', 'TVideoDownloader finished downloading.', btInfo, 5000, True);
            end;
            TrayIcon.ShowApplication;
            AddToLog(0, '');
          finally
            LMissingFileList.Free;
          end;
          SaveOptions;
        end;
      1:
        begin
          SaveOptions;
          Application.Terminate;
        end;
      2:
        begin
          SaveOptions;
          if (DirectoryExists(DirectoryEdit.Text)) then
          begin
            ShellExecute(Application.Handle, 'open', PChar(DirectoryEdit.Text), nil, nil, SW_SHOWNORMAL);
          end
          else
          begin
            Application.MessageBox('Cannot open output folder because it does not exist!', 'Error', MB_ICONERROR);
          end;
        end;
      3:
        begin
          SaveOptions;
          ShutDown(EWX_SHUTDOWN or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
      4:
        begin
          SaveOptions;
          ShutDown(EWX_REBOOT or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
      5:
        begin
          SaveOptions;
          ShutDown(EWX_LOGOFF or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
    end;
  end
  else
  begin
    UpdateDownloadProgressUI;
    TotalBar.Max := FVideoDownloadTotalCMDCount + FSkippedVideoCount;
    TotalBar.Position := LTotalFilesDone + FSkippedVideoCount;
    VideoDownloaderProgressLabel.Caption := 'Progress: ' + FloatToStr(LTotalFilesDone + FSkippedVideoCount) + '/' + FloatToStr(FVideoDownloadTotalCMDCount + FSkippedVideoCount);
    if FVideoDownloadTotalCMDCount > 0 then
    begin
      MainForm.Caption := FloatToStr((100 * (LTotalFilesDone + FSkippedVideoCount)) div (FVideoDownloadTotalCMDCount + FSkippedVideoCount)) + '% ' + ' [TVideoDownloader]';
      SetProgressValue(Handle, LTotalFilesDone + FSkippedVideoCount, FVideoDownloadTotalCMDCount + FSkippedVideoCount);
    end;
  end;
end;

function TMainForm.VideoTypeToAudio(const TypeStr: string): string;
const
  // video types.
  MP4 = 'MP4';
  WEBM = 'WEBM';
  _3GP = '3GP';
  FLV = 'FLV';
begin
  Result := '.m4a';
  if MP4 = copy(TypeStr, 1, Length(MP4)) then
  begin
    Result := '.m4a';
  end
  else if _3GP = copy(TypeStr, 1, Length(_3GP)) then
  begin
    Result := '.m4a'
  end
  else if WEBM = copy(TypeStr, 1, Length(WEBM)) then
  begin
    Result := '.ogg';
  end
  else if FLV = copy(TypeStr, 1, Length(FLV)) then
  begin
    Result := '.mp3';
  end;
end;

function TMainForm.VideoTypeToAudioCode(const TypeStr: string): string;
const
  // video types.
  MP4 = 'MP4';
  WEBM = 'WEBM';
  _3GP = '3GP';
  FLV = 'FLV';
begin
  // flv and 3gp DASH
  Result := '140';
  if MP4 = copy(TypeStr, 1, Length(MP4)) then
  begin
    Result := '140';
  end
  else if _3GP = copy(TypeStr, 1, Length(_3GP)) then
  begin
    Result := '140'
  end
  else if WEBM = copy(TypeStr, 1, Length(WEBM)) then
  begin
    Result := '171';
  end
  else if FLV = copy(TypeStr, 1, Length(FLV)) then
  begin
    Result := '140';
  end;
end;

function TMainForm.VideoTypeToVideo(const TypeStr: string): string;
const
  // video types.
  MP4 = 'MP4';
  WEBM = 'WEBM';
  _3GP = '3GP';
  FLV = 'FLV';
begin
  Result := '.mp4';
  if MP4 = copy(TypeStr, 1, Length(MP4)) then
  begin
    Result := '.mp4';
  end
  else if _3GP = copy(TypeStr, 1, Length(_3GP)) then
  begin
    Result := '.3gp'
  end
  else if WEBM = copy(TypeStr, 1, Length(WEBM)) then
  begin
    Result := '.webm';
  end
  else if FLV = copy(TypeStr, 1, Length(FLV)) then
  begin
    Result := '.flv';
  end;
end;

{ TVideoDownloaderItem }

constructor TVideoDownloaderItem.Create(const ParentControl: TsScrollBox; const _Index, PreviousBottom: Integer);
begin
  Panel := TsPanel.Create(nil);
  Panel2 := TsPanel.Create(nil);
  Panel3 := TsPanel.Create(nil);
  LinkLabel := TsLabel.Create(nil);
  ProgressLabel := TsLabel.Create(nil);
  PrevievImg := TsImage.Create(nil);
  DeleteButton := TsButton.Create(nil);
  DeleteButton.Tag := _Index;
  FileNameLabel := TsLabel.Create(nil);
  FormatList := TsComboBox.Create(nil);
  ProgressBar := TsProgressBar.Create(nil);
  SubtitleList := TsComboBox.Create(nil);
  Panel.ParentColor := False;
  Panel.Color := clGray;
  LinkLabel.Font.Color := clBlue;
  LinkLabel.Cursor := crHandPoint;
  LinkLabel.Font.Style := [fsUnderline];
  ProgressBar.Smooth := True;

  Panel.InsertControl(PrevievImg);
  Panel.InsertControl(Panel2);

  Panel2.InsertControl(LinkLabel);
  Panel2.InsertControl(FileNameLabel);
  Panel2.InsertControl(FormatList);
  Panel2.InsertControl(SubtitleList);
  Panel2.InsertControl(ProgressLabel);
  Panel2.InsertControl(ProgressBar);
  Panel2.InsertControl(Panel3);

  Panel3.InsertControl(DeleteButton);

  Panel2.BorderStyle := bsNone;
  Panel3.BorderStyle := bsNone;
  Panel2.BevelOuter := bvNone;
  Panel3.BevelOuter := bvNone;

  Panel.Align := alTop;
  Panel.Height := 150;
  Panel.Top := PreviousBottom;

  PrevievImg.Width := Panel.Height;
  PrevievImg.Height := Panel.Height;
  PrevievImg.AutoSize := False;
  PrevievImg.Center := True;
  PrevievImg.Transparent := True;
  PrevievImg.Align := alLeft;

  Panel2.Align := alClient;
  Panel3.Align := alBottom;
  Panel3.Height := 30;

  LinkLabel.Align := alTop;
  LinkLabel.AlignWithMargins := True;
  FileNameLabel.Align := alTop;
  FileNameLabel.AlignWithMargins := True;
  FormatList.Align := alTop;
  SubtitleList.Align := alTop;
  ProgressLabel.Align := alBottom;
  ProgressLabel.AlignWithMargins := True;
  ProgressBar.Align := alBottom;
  ProgressBar.Height := 10;
  FormatList.Style := csDropDownList;
  SubtitleList.Style := csDropDownList;

  DeleteButton.Width := 100;
  DeleteButton.Height := 30;
  DeleteButton.Caption := 'Remove';
  DeleteButton.Align := alRight;
end;

destructor TVideoDownloaderItem.Destroy;
begin

  inherited;
end;

procedure TVideoDownloaderItem.ResetProgressLabel;
begin
  ProgressLabel.Caption := '';
  ProgressBar.Position := 0;
end;

procedure TMainForm.UpdateCheckerDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
var
  VersionFile: TStringList;
  LatestVersion: Integer;
begin
  VersionFile := TStringList.Create;
  try
    VersionFile.LoadFromStream(Stream);
    if VersionFile.Count = 1 then
    begin
      if TryStrToInt(VersionFile.Strings[0], LatestVersion) then
      begin
        if LatestVersion > BuildInt then
        begin
          if ID_YES = Application.MessageBox('There is a new version. Would you like to download it?', 'New Version', MB_ICONQUESTION or MB_YESNO) then
          begin
            ShellExecute(0, 'open', 'https://sourceforge.net/projects/tvideodownloader/', nil, nil, SW_SHOWNORMAL);
          end;

        end;
      end;
    end;
  finally
    FreeAndNil(VersionFile);
  end;
end;

end.
