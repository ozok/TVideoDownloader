unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, Generics.Collections,
  UnitDownloadProcess, Vcl.Mask, JvComponentBase, JvComputerInfoEx, StrUtils,
  MediaInfoDll, windows7taskbar, UnitCommonTypes, JvTrayIcon,
  UnitYouTubeVideoInfoExtractor, ShellAPI, Winapi.MMSystem, IniFiles,
  JvUrlListGrabber, JvUrlGrabbers, JvThread, System.Types, DownloadItemFrame,
  JvDragDrop, IdBaseComponent, IdThreadComponent, JvExMask, JvToolEdit, System.ImageList,
  Vcl.ImgList, System.DateUtils;

type
  TMainForm = class(TForm)
    PassPnl: TPanel;
    sLabel1: TLabel;
    UserEdit: TEdit;
    PassEdit: TEdit;
    VideoDownloaderList: TScrollBox;
    VideoDownloadToolBarPanel: TPanel;
    AddLinkBtn: TButton;
    ClearLinksBtn: TButton;
    SettingsBtn: TButton;
    StartDownloadBtn: TButton;
    StopDownloadBtn: TButton;
    PassBtn: TButton;
    ProgressPanel: TPanel;
    sPanel3: TPanel;
    VideoDownloaderProgressLabel: TLabel;
    TotalBar: TProgressBar;
    PostEncodeList2: TComboBox;
    OutputPanel: TPanel;
    AddLinkMenu: TPopupMenu;
    A3: TMenuItem;
    Batchaddlinks1: TMenuItem;
    A2: TMenuItem;
    Batchaddplaylists1: TMenuItem;
    OpenOutBtn: TButton;
    Info: TJvComputerInfoEx;
    VideoDownloaderPosTimer: TTimer;
    TrayIcon: TJvTrayIcon;
    MainMenu1: TMainMenu;
    L1: TMenuItem;
    E1: TMenuItem;
    H1: TMenuItem;
    NormalPanel: TPanel;
    LoadPanel: TPanel;
    AbortVideoAddBtn: TButton;
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
    LogsBtn: TButton;
    S2: TMenuItem;
    DonateBtn: TButton;
    ProcessingPanel: TPanel;
    sPanel1: TPanel;
    LinkEdit: TEdit;
    LinkTypeList: TComboBox;
    AddSingleLinkBtn: TButton;
    GetLatestYoutubedlBtn: TButton;
    LoadPanelLabel: TLabel;
    C2: TMenuItem;
    SaveDialog: TSaveDialog;
    E2: TMenuItem;
    sPanel2: TPanel;
    TimeLabel: TLabel;
    TimeTimer: TTimer;
    OpenOutputFolderBtn: TButton;
    I1: TMenuItem;
    ImportDlg: TOpenDialog;
    Importlinksfromatextfile1: TMenuItem;
    DirectoryEdit: TJvDirectoryEdit;
    Label1: TLabel;
    ButtonImages: TImageList;
    LoadProgressBar: TProgressBar;
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
    procedure TrayIconBalloonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AddSingleLinkBtnClick(Sender: TObject);
    procedure LinkEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//    procedure DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
    procedure FormResize(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure E2Click(Sender: TObject);
    procedure TimeTimerTimer(Sender: TObject);
    procedure I1Click(Sender: TObject);
  private
    { Private declarations }
    FDownloadItems: TDownloadItemList;
    // total download cmd
    FVideoDownloadTotalCMDCount: Integer;
    // time passed downloading
    FVideoDownloaderTime: Integer;
    FStopAddingLink: Boolean;
    FSkippedVideoCount: integer;
    FMyDocFolder: string;

    // backend paths
    FYoutubedlPath: string;
    FFFMpegPath: string;
    FTempFolder: string;
    FMp4BoxPath: string;
    // backend paths
    // list of output files to be checked
    FFilesToCheck: TStringList;
    FUserUpdateCheck: Boolean;

    // create guid file name
    function CreateTempName: string;
    // check if video has audio
    function HasAudio(const FileName: string): Boolean;
    procedure SaveDownloadLogs;
    //
    function VideoTypeToAudio(const TypeStr: string): string;
    function VideoTypeToAudioCode(const TypeStr: string): string;
    function VideoTypeToVideo(const TypeStr: string): string;
    // UI
    procedure DownloadState;
    procedure DownloadNormalState;
    procedure MenuState(const _Enabled: Boolean);
    procedure AddingState;
    procedure PostAddingState;
    // clear temp folder
    procedure ClearTempFolderEx(const DeleteOnlyText: Boolean);
    // add a link to the list
    procedure AddURL(const Url: string);
    // download item events
    procedure DeleteBtnClick(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
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
    procedure AddPanelVisibility(const Visible: Boolean);
    function IntToTime(const TimeAsInt: integer): string;
  public
    { Public declarations }
    FAppDataFolder: string;
    // download processes
    FVideoDownloadProcesses: array[0..15] of TDownloadProcess;
    // video download list items
    // FVideoDownloadListItems: TVideoDownloaderItemList;
    FVideoDownloadListItems: TList<TDownloadUIItem>;
    // number of processes that exited with an exitcode other than 0
    FProcessErrorCount: integer;
    // add links in batch
    procedure BatchAdd(const Links: TStrings; const SingleLink: Boolean);
    // add line to log
    procedure AddToLog(const LogID: Integer; const Msg: string);
  end;

var
  MainForm: TMainForm;

const
  Portable = False;
  BuildInt = 318;

implementation

{$R *.dfm}

uses
  UnitSettings, UnitLogs, UnitBatchAdd, UnitAbout, UnitYoutubedlUpdateChecker,
  UnitPreview;

procedure TMainForm.A1Click(Sender: TObject);
begin
  Self.Enabled := false;
  AboutForm.Show;
end;

procedure TMainForm.A2Click(Sender: TObject);
var
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
    LYIE := TYouTubeVideoInfoExtractor.Create(LURL, FYoutubedlPath, FTempFolder, LPass, not SettingsForm.DontPreviewImgBtn.Checked);
    LYIE.GetPlayListInfo;
    AddPanelVisibility(True);
    LoadPanel.BringToFront;
    MenuState(false);
    AddingState;
    FStopAddingLink := false;
    try
      LoadPanelLabel.Caption := 'Extracting video links from playlist, this may take a while...';
      while LYIE.PlaylistStatus = stReading do
      begin
        if FStopAddingLink then
        begin
          LYIE.StopAll;
          Break;
        end;
        Application.ProcessMessages;
        Sleep(100);
        LoadPanelLabel.Caption := 'Extracting video links from playlist, this may take a while...(Found ' + LYIE.PlaylistFoundVideosCount.ToString() + ' videos)';
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
            LoadPanelLabel.Caption := 'Adding videos to the list...(' + FloatToStr(i + 1) + '/' + FloatToStr(LYIE.PlayListVideoLinks.Count) + ')';
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
      AddPanelVisibility(false);
      // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
      MenuState(True);
      PostAddingState;
      Self.Width := Self.Width + 1;
      Self.Width := Self.Width - 1;
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
    AddPanelVisibility(True);
    LoadPanel.BringToFront;
    MenuState(false);
    AddingState;
    FStopAddingLink := false;
    // SendMessage(LinkList.Handle, WM_SETREDRAW, 0, 0);
    try
      LoadPanelLabel.Caption := 'Adding given URL to list...';
      AddURL(Trim(LURL));
    finally
      Self.Enabled := True;
      AddPanelVisibility(false);
      // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
      MenuState(True);
      PostAddingState;
      Self.Width := Self.Width + 1;
      Self.Width := Self.Width - 1;
    end;
  end;
end;

procedure TMainForm.AbortVideoAddBtnClick(Sender: TObject);
begin
  FStopAddingLink := True;
end;

procedure TMainForm.AddingState;
begin
  MenuState(false);
  VideoDownloadToolBarPanel.Enabled := false;
  sPanel1.Enabled := false;
  VideoDownloaderList.Enabled := false;
  OutputPanel.Enabled := false;
  ProgressPanel.Enabled := false;
end;

procedure TMainForm.AddLinkBtnClick(Sender: TObject);
var
  P: TPoint;
begin
  P := AddLinkBtn.ClientToScreen(Point(0, 0));

  AddLinkMenu.Popup(P.X, P.Y + AddLinkBtn.Height)
end;

procedure TMainForm.AddPanelVisibility(const Visible: Boolean);
begin
  if Visible then
  begin
    LoadPanel.Width := Self.ClientWidth - 60;
    LoadPanel.Left := 30;
    LoadPanel.Top := (Self.Height div 2) - (LoadPanel.Height div 2);
    LoadPanel.Visible := True;
    LoadProgressBar.Style := pbstMarquee;
    LoadPanel.BringToFront;
  end
  else
  begin
    LoadPanel.Visible := false;
    LoadProgressBar.Style := pbstNormal;
  end;
end;

procedure TMainForm.AddSingleLinkBtnClick(Sender: TObject);
var
  LURL: string;
  LYIE: TYouTubeVideoInfoExtractor;
  I: Integer;
  LPass: TUserPass;
begin
  LURL := Trim(LinkEdit.Text);
  if Length(LURL) > 0 then
  begin
    case LinkTypeList.ItemIndex of
      0: // single link
        begin
          AbortVideoAddBtn.Top := (LoadPanel.Height div 2) - (AbortVideoAddBtn.Height div 2);
          AddPanelVisibility(True);
          LoadPanel.BringToFront;
          MenuState(false);
          AddingState;
          FStopAddingLink := false;
          // SendMessage(LinkList.Handle, WM_SETREDRAW, 0, 0);
          try
            LoadPanelLabel.Caption := 'Adding given URL to list...';
            AddURL(Trim(LURL));
          finally
            Self.Enabled := True;
            AddPanelVisibility(false);
            // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
            RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
            MenuState(True);
            PostAddingState;
            Self.Width := Self.Width + 1;
            Self.Width := Self.Width - 1;
          end;
        end;
      1: // playlist/user
        begin
          LPass.UserName := UserEdit.Text;
          LPass.Password := PassEdit.Text;
          LYIE := TYouTubeVideoInfoExtractor.Create(LURL, FYoutubedlPath, FTempFolder, LPass, not SettingsForm.DontPreviewImgBtn.Checked);
          LYIE.GetPlayListInfo;
          AddPanelVisibility(True);
          LoadPanel.BringToFront;
          MenuState(false);
          AddingState;
          FStopAddingLink := false;
          try
            LoadPanelLabel.Caption := 'Extracting video links from playlist, this may take a while...';
            while LYIE.PlaylistStatus = stReading do
            begin
              if FStopAddingLink then
              begin
                LYIE.StopAll;
                Break;
              end;
              Application.ProcessMessages;
              Sleep(100);
              LoadPanelLabel.Caption := 'Extracting video links from playlist, this may take a while...(Found ' + LYIE.PlaylistFoundVideosCount.ToString() + ' videos)';
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
                  LoadPanelLabel.Caption := 'Adding videos to the list...(' + FloatToStr(i + 1) + '/' + FloatToStr(LYIE.PlayListVideoLinks.Count) + ')';
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
            AddPanelVisibility(false);
            // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
            RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
            MenuState(True);
            PostAddingState;
            Self.Width := Self.Width + 1;
            Self.Width := Self.Width - 1;
          end;
        end;
    end;
  end;
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
  LVideoDownloaderItem: TDownloadUIItem;
  LPass: TUserPass;
  LStartDate: TDateTime;
  LDiff: integer;
begin
  LStartDate := Now;
  if Length(Url) > 0 then
  begin
    LPass.UserName := UserEdit.Text;
    LPass.Password := PassEdit.Text;
    YIE := TYouTubeVideoInfoExtractor.Create(Url, FYoutubedlPath, FTempFolder, LPass, not SettingsForm.DontPreviewImgBtn.Checked);
    try
      // read info from link
      YIE.Start;
      while (YIE.FormatStatus = stReading) or (YIE.ThumbStatus = stReading) or (YIE.TitleStatus = stReading) or (YIE.SubtitleStatus = stReading) do
      begin
        LDiff := Abs(SecondsBetween(Now, LStartDate));
        if FStopAddingLink or (LDiff >= Round(SettingsForm.LinkAddTimeOutEdit.Value)) then
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
          LVideoDownloaderItem := TDownloadUIItem.Create(nil);
          LVideoDownloaderItem.Width := VideoDownloaderList.ClientWidth;
          LVideoDownloaderItem.Top := FVideoDownloadListItems.Count * 112;
          LVideoDownloaderItem.LinkLabel.Caption := Url;
          LVideoDownloaderItem.FileNameLabel.Caption := YIE.FileName;
          LVideoDownloaderItem.FileNameLabel.Hint := LVideoDownloaderItem.FileNameLabel.Caption;
          LVideoDownloaderItem.DeleteButton.OnClick := DeleteBtnClick;
          LVideoDownloaderItem.PreviewBtn.OnClick := PreviewBtnClick;
          // load program icon if download of thumb fails or user selected not to load it
          if FileExists(YIE.ImageName) then
          begin
            try
              LVideoDownloaderItem.PrevievImg.Picture.LoadFromFile(YIE.ImageName);
            except
              // load default image in case of an error
              LVideoDownloaderItem.PrevievImg.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\icon.ico');
            end;
          end
          else
          begin
            LVideoDownloaderItem.PrevievImg.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\icon.ico');
          end;
          LVideoDownloaderItem.DeleteButton.OnClick := DeleteBtnClick;
          LVideoDownloaderItem.ProgressLabel.Caption := 'Waiting...';
          VideoDownloaderList.InsertControl(LVideoDownloaderItem);
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
var
  LURL: string;
  LYIE: TYouTubeVideoInfoExtractor;
  I, j: Integer;
  LPass: TUserPass;
begin
  if Links.Count > 0 then
  begin
    AbortVideoAddBtn.Top := (LoadPanel.Height div 2) - (AbortVideoAddBtn.Height div 2);
    LoadPanelLabel.Caption := 'Please wait...';
    AddPanelVisibility(True);
    LoadPanel.BringToFront;
    MenuState(false);
    AddingState;
    FStopAddingLink := false;
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
            LoadPanelLabel.Caption := 'Adding videos to the list...(' + FloatToStr(i + 1) + '/' + FloatToStr(Links.Count) + ')';
            AddURL(LURL);
          end
          else
          begin
            // playlist
            LoadPanelLabel.Caption := 'Extracting video links from playlist, this may take a while...';
            LPass.UserName := UserEdit.Text;
            LPass.Password := PassEdit.Text;
            LYIE := TYouTubeVideoInfoExtractor.Create(LURL, FYoutubedlPath, FTempFolder, LPass, not SettingsForm.DontPreviewImgBtn.Checked);
            try
              LYIE.GetPlayListInfo;
              while (LYIE.PlaylistStatus = stReading) and (not FStopAddingLink) do
              begin
                Application.ProcessMessages;
                Sleep(10);
                LoadPanelLabel.Caption := 'Extracting video links from playlist, this may take a while...(Found ' + LYIE.PlaylistFoundVideosCount.ToString() + ' videos)';
              end;
              if LYIE.PlayListVideoLinks.Count > 0 then
              begin
                for j := 0 to LYIE.PlayListVideoLinks.Count - 1 do
                begin
                  LoadPanelLabel.Caption := 'Adding videos to the list...(' + FloatToStr(j + 1) + '/' + FloatToStr(LYIE.PlayListVideoLinks.Count) + ')';
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
      AddPanelVisibility(false);
      // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
      MenuState(True);
      PostAddingState;
      Self.Width := Self.Width + 1;
      Self.Width := Self.Width - 1;
    end;
  end;
end;

procedure TMainForm.Batchaddlinks1Click(Sender: TObject);
begin
  Self.Enabled := false;
  BatchAddForm.PMode := SingleLink;
  BatchAddForm.Show;
end;

procedure TMainForm.Batchaddplaylists1Click(Sender: TObject);
begin
  Self.Enabled := false;
  BatchAddForm.PMode := Playlist;
  BatchAddForm.Show;
end;

procedure TMainForm.C1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar(ExtractFileDir(Application.ExeName) + '\changelog.txt'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.C2Click(Sender: TObject);
begin
  if UpdateChecker.Status <> gsStopped then
  begin
    Application.MessageBox('Update checker is already running.', 'Error', MB_ICONINFORMATION);
    Exit;
  end;
  CheckUpdateThread.Execute(PWideChar('User'));
end;

procedure TMainForm.C3Click(Sender: TObject);
begin
  YoutubedlUpdateChecker.Path := FYoutubedlPath;
  Self.Enabled := false;
  YoutubedlUpdateChecker.Show;
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
  FUserUpdateCheck := Params <> nil;
  CheckUpdateThread.CancelExecute;
end;

procedure TMainForm.ClearLinksBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    FVideoDownloadListItems[i].Visible := false;
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
  // remove files from temp folder
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
      try
        DeleteFile(lPath + lSearchRec.Name);
      except
        on E: Exception do
        begin
          AddToLog(0, 'Unable to delete ' + lSearchRec.Name + '. Error: ' + E.Message);
        end;
      end;
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
  StartDownloadBtn.Enabled := false;
  AddLinkBtn.Enabled := false;
  DirectoryEdit.Enabled := false;
  ClearLinksBtn.Enabled := false;
  StopDownloadBtn.Enabled := True;
  SettingsBtn.Enabled := false;
  PassBtn.Enabled := false;
  sPanel1.Enabled := false;
  GetLatestYoutubedlBtn.Enabled := false;
  if PassPnl.Visible then
  begin
    PassPnl.Visible := false;
  end;
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    for j := 0 to FVideoDownloadListItems[i].ControlCount - 1 do
    begin
      if (FVideoDownloadListItems[i].Controls[j] is TComboBox) or (FVideoDownloadListItems[i].Controls[j] is TButton) then
        FVideoDownloadListItems[i].Controls[j].Enabled := false;
    end;
  end;
  for I := 0 to MainMenu1.Items.Count - 1 do
  begin
    MainMenu1.Items[i].Enabled := false;
  end;
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    FVideoDownloadListItems[i].Disable;
  end;
end;

//procedure TMainForm.DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
//var
//  LURL: string;
//begin
//  LURL := DropTextTarget1.Text.Trim;
//  if Length(LURL) > 0 then
//  begin
//    AbortVideoAddBtn.Top := (LoadPanel.Height div 2) - (AbortVideoAddBtn.Height div 2);
//    AddPanelVisibility(True);
//    LoadPanel.BringToFront;
//    MenuState(false);
//    AddingState;
//    FStopAddingLink := false;
//    // SendMessage(LinkList.Handle, WM_SETREDRAW, 0, 0);
//    try
//      LoadPanelLabel.Caption := 'Adding given URL to list...';
//      AddURL(Trim(LURL));
//    finally
//      Self.Enabled := True;
//      AddPanelVisibility(false);
//      // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
//      RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
//      MenuState(True);
//      PostAddingState;
//      Self.Width := Self.Width + 1;
//      Self.Width := Self.Width - 1;
//    end;
//  end;
//end;

//procedure TMainForm.DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
//var
//  LURL: string;
//begin
//  LURL := DropTextTarget1.Text.Trim;
//  if Length(LURL) > 0 then
//  begin
//    AbortVideoAddBtn.Top := (LoadPanel.Height div 2) - (AbortVideoAddBtn.Height div 2);
//    AddPanelVisibility(True);
//    LoadPanel.BringToFront;
//    MenuState(false);
//    AddingState;
//    FStopAddingLink := false;
//    // SendMessage(LinkList.Handle, WM_SETREDRAW, 0, 0);
//    try
//      LoadPanelLabel.Caption := 'Adding given URL to list...';
//      AddURL(Trim(LURL));
//    finally
//      Self.Enabled := True;
//      AddPanelVisibility(false);
//      // SendMessage(LinkList.Handle, WM_SETREDRAW, 1, 0);
//      RedrawWindow(VideoDownloaderList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
//      MenuState(True);
//      PostAddingState;
//      Self.Width := Self.Width + 1;
//      Self.Width := Self.Width - 1;
//    end;
//  end;
//end;

procedure TMainForm.E2Click(Sender: TObject);
var
  LOutputFile: TStringList;
  I: Integer;
begin
  if FVideoDownloadListItems.Count > 0 then
  begin
    if SaveDialog.Execute then
    begin
      LOutputFile := TStringList.Create;
      try
        for I := 0 to FVideoDownloadListItems.Count - 1 do
        begin
          LOutputFile.Add(FVideoDownloadListItems[i].LinkLabel.Caption);
        end;
        LOutputFile.SaveToFile(ChangeFileExt(SaveDialog.FileName, '.txt'));
      finally
        LOutputFile.Free;
      end;
    end;
  end;
end;

procedure TMainForm.DeleteBtnClick(Sender: TObject);
var
  LItemIndex: integer;
  I: Integer;
begin
  LItemIndex := (Sender as TButton).Tag;
  FVideoDownloadListItems[LItemIndex].Visible := false;
  FVideoDownloadListItems.Delete(LItemIndex);
  FDownloadItems.Delete(LItemIndex);
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    if FVideoDownloadListItems[i].DeleteButton.Tag > LItemIndex then
    begin
      FVideoDownloadListItems[i].DeleteButton.Tag := FVideoDownloadListItems[i].DeleteButton.Tag - 1;
    end;
    FVideoDownloadListItems[i].Top := i * 112;
  end;
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
  StopDownloadBtn.Enabled := false;
  SettingsBtn.Enabled := True;
  PassBtn.Enabled := True;
  sPanel1.Enabled := True;
  GetLatestYoutubedlBtn.Enabled := True;
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    for j := 0 to FVideoDownloadListItems[i].ControlCount - 1 do
    begin
      if (FVideoDownloadListItems[i].Controls[j] is TComboBox) or (FVideoDownloadListItems[i].Controls[j] is TButton) then
        FVideoDownloadListItems[i].Controls[j].Enabled := True;
    end;
  end;
  for I := 0 to MainMenu1.Items.Count - 1 do
  begin
    MainMenu1.Items[i].Enabled := True;
  end;
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    for j := 0 to FVideoDownloadListItems[i].ControlCount - 1 do
    begin
      FVideoDownloadListItems[i].Controls[j].Enabled := True;
      if FVideoDownloadListItems[i].Controls[j] is TProgressBar then
      begin
        TProgressBar(FVideoDownloadListItems[i].Controls[j]).Position := 0;
      end;
      FVideoDownloadListItems[i].ResetProgressLabel;
    end;
  end;
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    FVideoDownloadListItems[i].Enable;
  end;

  Self.Caption := 'TVideoDownloader';
  TotalBar.Position := 0;
  VideoDownloaderProgressLabel.Caption := 'Progress: 0/0';
  FVideoDownloaderTime := 0;
  TimeLabel.Caption := '00:00:00';
  SetProgressValue(Handle, 0, MaxInt);
end;

procedure TMainForm.FormatListChange(Sender: TObject);
var
  LItemIndex: Integer;
  LTmp: TDownloadItem;
begin
  LItemIndex := (Sender as TComboBox).Tag;
  LTmp := FDownloadItems[LItemIndex];
  LTmp.FormatIndex := (Sender as TComboBox).ItemIndex;
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
  ClearTempFolderEx(false);

end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FStopAddingLink := True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FDownloadItems := TDownloadItemList.Create;
  FVideoDownloadListItems := TList<TDownloadUIItem>.Create;
  for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
    FVideoDownloadProcesses[i] := TDownloadProcess.Create;
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
    FAppDataFolder := Info.Folders.AppData + '\TVideoDownloader';
  end
  else
  begin
    FAppDataFolder := ExtractFileDir(Application.ExeName) + '\';
    FMyDocFolder := FAppDataFolder;
  end;

  if not DirectoryExists(FAppDataFolder) then
  begin
    ForceDirectories(FAppDataFolder);
  end;
  FYoutubedlPath := ExtractFileDir(Application.ExeName) + '\tools\youtube-dl.exe';
  if not FileExists(FYoutubedlPath) then
  begin
    Application.MessageBox('Cannot find youtube-dl!', 'Fatal Error', MB_ICONERROR);
    Application.Terminate;
  end;
  if not Portable then
  begin
    if not FileExists(FAppDataFolder + '\youtube-dl.exe') then
    begin
      if not CopyFile(PWideChar(FYoutubedlPath), PWideChar(FAppDataFolder + '\youtube-dl.exe'), false) then
      begin
        Application.MessageBox('Unable to copy youtube-dl to appdata folder.', 'Fatal Error', MB_ICONERROR);
        Application.ProcessMessages;
      end
      else
      begin
        FYoutubedlPath := FAppDataFolder + '\youtube-dl.exe';
      end;
    end
    else
    begin
      FYoutubedlPath := FAppDataFolder + '\youtube-dl.exe';
    end;
  end;
  FFFMpegPath := ExtractFileDir(Application.ExeName) + '\tools\ffmpeg.exe';
  if not FileExists(FFFMpegPath) then
  begin
    Application.MessageBox('Cannot find ffmpeg!', 'Fatal Error', MB_ICONERROR);
    Application.Terminate;
  end;
  FMp4BoxPath := ExtractFileDir(Application.ExeName) + '\tools\mp4box.exe';
  if not FileExists(FMp4BoxPath) then
  begin
    Application.MessageBox('Cannot find Mp4BoxPath!', 'Fatal Error', MB_ICONERROR);
    Application.Terminate;
  end;
  FTempFolder := Info.Folders.Temp + '\TVideoDownloader';
  if not DirectoryExists(FTempFolder) then
  begin
    ForceDirectories(FTempFolder);
  end;
  ClearTempFolderEx(false);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for I := 0 to FVideoDownloadListItems.Count - 1 do
  begin
    FVideoDownloadListItems[i].Free;
  end;
  for I := 0 to FDownloadItems.Count - 1 do
  begin
    FDownloadItems[i].Free;
  end;
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

procedure TMainForm.FormResize(Sender: TObject);
begin
  if LoadPanel.Visible then
  begin
    AddPanelVisibility(True);
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  LoadOptions;
  if FindCmdLineSwitch('/UpdateYoutube-dl') then
  begin
    YoutubedlUpdateChecker.UpdateThread.Execute(nil);
  end;
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

procedure TMainForm.I1Click(Sender: TObject);
var
  LFile: TStringList;
begin
  if ImportDlg.Execute then
  begin
    LFile := TStringList.Create;
    try
      LFile.LoadFromFile(ImportDlg.FileName);
      BatchAdd(LFile, True);
    finally
      LFile.Free;
    end;
  end;
end;

function TMainForm.IntToTime(const TimeAsInt: integer): string;
var
  LHours: integer;
  LMinutes: integer;
  LSeconds: integer;
  LHoursStr: string;
  LMinutesStr: string;
  LSecondsStr: string;
begin
  if TimeAsInt > 0 then
  begin
    LHours := TimeAsInt div 3600;
    LMinutes := (TimeAsInt div 60) - (LHours * 60);
    LSeconds := (TimeAsInt mod 60);

    if LHours > 9 then
      LHoursStr := LHours.ToString()
    else
      LHoursStr := '0' + LHours.ToString();
    if LMinutes > 9 then
      LMinutesStr := LMinutes.ToString()
    else
      LMinutesStr := '0' + LMinutes.ToString();
    if LSeconds > 9 then
      LSecondsStr := LSeconds.ToString()
    else
      LSecondsStr := '0' + LSeconds.ToString();
    Result := LHoursStr + ':' + LMinutesStr + ':' + LSecondsStr;
  end
  else
  begin
    Result := '00:00:00';
  end;
end;

procedure TMainForm.LabelClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PWideChar(TLabel(Sender).Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.LinkEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    AddSingleLinkBtnClick(Self);
  end;
end;

procedure TMainForm.LoadOptions;
var
  OptionFile: TIniFile;
begin
  OptionFile := TIniFile.Create(FAppDataFolder + '\settings.ini');
  try
    with OptionFile do
    begin
      PostEncodeList2.ItemIndex := ReadInteger('Options', 'PostEncode2', 0);
      DirectoryEdit.Text := ReadString('Options', 'Out', FMyDocFolder);
      LinkTypeList.ItemIndex := ReadInteger('Options', 'LinkType', 0);
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
    PassPnl.Visible := false;
  end
  else
  begin
    // show
    PassPnl.Visible := True;
  end;
end;

procedure TMainForm.PostAddingState;
begin
  MenuState(True);
  VideoDownloadToolBarPanel.Enabled := True;
  sPanel1.Enabled := True;
  VideoDownloaderList.Enabled := True;
  OutputPanel.Enabled := True;
  ProgressPanel.Enabled := True;
end;

procedure TMainForm.PreviewBtnClick(Sender: TObject);
var
  LItemIndex: integer;
begin
  LItemIndex := (Sender as TButton).Tag;
  PreviewForm.Url := FVideoDownloadListItems[LItemIndex].LinkLabel.Caption;
  PreviewForm.Show;
  Self.Enabled := False;
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
    ProcessingPanel.Visible := false;
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
  mail := PWideChar('mailto:ozok26@gmail.com?subject=TVideoDownloader&body=' + mailbody);

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
  if not DirectoryExists(FAppDataFolder) then
  begin
    if not ForceDirectories(FAppDataFolder) then
    begin
      LContinue := false;
    end;
  end;
  if LContinue then
  begin
    for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
    begin
      Application.ProcessMessages;
      LStreamWriter := TStreamWriter.Create(FAppDataFolder + '\' + FloatToStr(i + 1) + 'log.txt', false, TEncoding.UTF8);
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
  OptionFile := TIniFile.Create(FAppDataFolder + '\Settings.ini');
  try
    with OptionFile do
    begin
      WriteInteger('Options', 'PostEncode2', PostEncodeList2.ItemIndex);
      WriteString('Options', 'Out', DirectoryEdit.Text);
      WriteInteger('Options', 'LinkType', LinkTypeList.ItemIndex);
    end;
  finally
    OptionFile.Free
  end;
end;

procedure TMainForm.SettingsBtnClick(Sender: TObject);
begin
  Self.Enabled := false;
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
        AdjustTokenPrivileges(TTokenHd, false, TTokenPvg, cbtpPrevious, rTTokenPvg, pcbtpPreviousRequired);
    end;
  end;
  Result := ExitWindowsEx(RebootParam, 0);
end;

procedure TMainForm.StartDownloadBtnClick(Sender: TObject);
var
  i: Integer;
  LSelectedFormatStr: string;
  j: Integer;
  LDownloadedVideoName: string;
  LCMD: string;
  // LDownloadSub: Boolean;
  LRenameFile: TStringList;
  LOutputFile: string;
  // LFileNameExtractor: TFileNameExtractor;
  LDASHAudioExt: string;
  LDASHAudioCode: string;
  LDASHVideoExt: string;
  LPos1: integer;
  LPass: string;
  LDownloadJob: TDownloadJob;
  LRenameJob: TRenameJob;
begin
  if FVideoDownloadListItems.Count > 0 then
  begin
    ProcessPanelVisibility(True);
    MainForm.Enabled := false;
    try
      LRenameFile := TStringList.Create;
      try
{$REGION 'Dir checks block'}
        if not DirectoryExists(DirectoryEdit.Text) then
        begin
          if ForceDirectories(DirectoryEdit.Text) then
          begin
            if not (ForceDirectories(ExcludeTrailingPathDelimiter(DirectoryEdit.Text))) then
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
        end;
        for I := 0 to FVideoDownloadListItems.Count - 1 do
        begin
          FVideoDownloadListItems[i].ProgressLabel.Caption := 'Waiting...';
        end;
        FVideoDownloadTotalCMDCount := 0;
        FVideoDownloaderTime := 0;
        FSkippedVideoCount := 0;
        FProcessErrorCount := 0;
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
                FVideoDownloadListItems[i].ProgressBar.Progress := 100;
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
                LCMD := ' ' + LPass + ' -o "' + ExcludeTrailingPathDelimiter(DirectoryEdit.Text) + '\%(upload_date)s - %(uploader)s - %(title)s.%(ext)s" -i --no-playlist -f ' + FDownloadItems[i].FormatIntegers[FDownloadItems[i].FormatIndex];
              end;
            soundcloud:
              begin
                LCMD := ' ' + LPass + ' -o "' + ExcludeTrailingPathDelimiter(DirectoryEdit.Text) + '\%(upload_date)s - %(uploader)s - %(title)s.%(ext)s" -i --no-playlist -x --audio-format ' + FDownloadItems[i].FormatIntegers[FDownloadItems[i].FormatIndex];
              end;
          end;
          // LDownloadSub := False;
          if FDownloadItems[i].SubIndex > 0 then
          begin
            LCMD := LCMD + ' --write-sub --sub-lang ' + LowerCase(FVideoDownloadListItems[i].SubtitleList.Text);
            // LDownloadSub := True;
          end;
          LCMD := LCMD + ' -v -c -w ' + FVideoDownloadListItems[i].LinkLabel.Caption;
          LDownloadJob.CommandLine := LCMD;
          LDownloadJob.ProcessType := youtubedl;
          LDownloadJob.ApplicationPath := FYoutubedlPath;
          LDownloadJob.FileIndex := i;
          LDownloadJob.ProcessInfo := '[Downloading Video]';
          FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].DownloadJobs.Add(LDownloadJob);
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
            LDownloadJob.CommandLine := ' -o "' + ExcludeTrailingPathDelimiter(DirectoryEdit.Text) + '\%(upload_date)s - %(uploader)s - %(title)s' + LDASHAudioExt + '" -i --no-playlist -f ' + LDASHAudioCode + ' -c -w ' + FVideoDownloadListItems[i].LinkLabel.Caption;
            LDownloadJob.ProcessType := youtubedl;
            LDownloadJob.ApplicationPath := FYoutubedlPath;
            LDownloadJob.FileIndex := i;
            LDownloadJob.ProcessInfo := '[Downloading Audio]';
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].DownloadJobs.Add(LDownloadJob);

            // mux both into video file
            LDownloadJob.CommandLine := ' -y -i "' + DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + LDASHVideoExt + '" -i "' + DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + LDASHAudioExt + '" -acodec copy -vcodec copy "' + DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + '_muxed' + LDASHVideoExt + '"';
            LDownloadJob.ProcessType := ffmpeg;
            LDownloadJob.ApplicationPath := FFFMpegPath;
            LDownloadJob.FileIndex := i;
            LDownloadJob.ProcessInfo := '[Muxing Audio and Video]';
            // delete downloaded temp. video and audio files
            // rename muxed video to normal
            LRenameJob.AudioFilePath := DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + LDASHAudioExt;
            LRenameJob.VideoFilePath := DirectoryEdit.Text + '\' + LOutputFile;
            LRenameJob.TempMuxedFilePath := DirectoryEdit.Text + '\' + FVideoDownloadListItems[i].FileNameLabel.Caption + '_muxed' + LDASHVideoExt;
            LDownloadJob.RenameJob := LRenameJob;
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].DownloadJobs.Add(LDownloadJob);
          end;
          // file check
          FFilesToCheck.Add(DirectoryEdit.Text + '\' + LOutputFile);

          // remux dash m4a to mp4 audio
          if ContainsText(LSelectedFormatStr, 'M4A, AUDIO, ONLY, DASH') then
          begin
            LCMD := ' -add "' + DirectoryEdit.Text + '\' + LOutputFile + '" -new "' + DirectoryEdit.Text + '\' + LOutputFile + '"';
            LDownloadJob.CommandLine := LCMD;
            LDownloadJob.ProcessType := mp4box;
            LDownloadJob.ApplicationPath := FMp4BoxPath;
            LDownloadJob.FileIndex := i;
            LDownloadJob.ProcessInfo := '[Remuxing to Mp4]';
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].DownloadJobs.Add(LDownloadJob);
          end;

          // extract ogg file from webm
          if ContainsText(LSelectedFormatStr, 'WEBM, AUDIO, ONLY, DASH') then
          begin
            LCMD := ' -y -i "' + DirectoryEdit.Text + '\' + LOutputFile + '" -vn -f ogg "' + DirectoryEdit.Text + '\' + ChangeFileExt(LOutputFile, '.ogg') + '"';
            LDownloadJob.CommandLine := LCMD;
            LDownloadJob.ProcessType := ffmpeg;
            LDownloadJob.ApplicationPath := FFFMpegPath;
            LDownloadJob.FileIndex := i;
            LDownloadJob.ProcessInfo := '[Extracting Ogg]';
            FVideoDownloadProcesses[i mod SettingsForm.ProcessCountBar.Position].DownloadJobs.Add(LDownloadJob);
            FFilesToCheck.Add(DirectoryEdit.Text + '\' + ChangeFileExt(LOutputFile, '.ogg'));
          end;
        end;

        // add commands to log
        with LogForm.CMDLog do
        begin
          Lines.Clear;
          for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
          begin
            if FVideoDownloadProcesses[i].DownloadJobs.Count > 0 then
            begin
              Lines.Add('Command lines' + FloatToStr(i + 1) + ':');
              for j := 0 to FVideoDownloadProcesses[i].DownloadJobs.Count - 1 do
              begin
                Lines.Add(FVideoDownloadProcesses[i].DownloadJobs[j].CommandLine);
                Inc(FVideoDownloadTotalCMDCount);
              end;
            end;
          end;
        end;

        AddToLog(0, 'Ignoring ' + FloatToStr(FSkippedVideoCount) + ' files.');

        // start downloading
        if FVideoDownloadTotalCMDCount > 0 then
        begin
          VideoDownloaderProgressLabel.Caption := 'Progress: 0/' + FVideoDownloadTotalCMDCount.ToString();
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
          TimeTimer.Enabled := VideoDownloaderPosTimer.Enabled;
          DownloadState();
          SetProgressState(Handle, tbpsNormal);
        end
        else
        begin
          Application.MessageBox('Did not create any commands. Perhaps you''ve already downloaded all videos? Check logs please.', 'Info', MB_ICONINFORMATION);
        end;
      finally
        LRenameFile.Free;
      end;
    finally
      ProcessPanelVisibility(false);
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
      VideoDownloaderPosTimer.Enabled := false;
      TimeTimer.Enabled := VideoDownloaderPosTimer.Enabled;
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
  LItemIndex := (Sender as TComboBox).Tag;
  LTmp := FDownloadItems[LItemIndex];
  LTmp.SubIndex := (Sender as TComboBox).ItemIndex;
  FDownloadItems[LItemIndex] := LTmp;
end;

procedure TMainForm.TimeTimerTimer(Sender: TObject);
begin
  Inc(FVideoDownloaderTime);
  TimeLabel.Caption := IntToTime(FVideoDownloaderTime);
end;

procedure TMainForm.TrayIconBalloonClick(Sender: TObject);
begin
  TrayIcon.ShowApplication;
  TrayIcon.Active := false;
end;

procedure TMainForm.VideoDownloaderPosTimerTimer(Sender: TObject);
var
  LTotalFilesDone: integer;
  I: Integer;
  LMissingFileList: TStringList;
  LNewPos: integer;
begin
  LTotalFilesDone := 0;
  for I := Low(FVideoDownloadProcesses) to High(FVideoDownloadProcesses) do
  begin
    if FVideoDownloadProcesses[i].DownloadJobs.Count > 0 then
    begin
      Inc(LTotalFilesDone, FVideoDownloadProcesses[i].FilesDone);
    end;
  end;

  if LTotalFilesDone = FVideoDownloadTotalCMDCount then
  begin
    VideoDownloaderPosTimer.Enabled := false;
    TimeTimer.Enabled := VideoDownloaderPosTimer.Enabled;
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
          if FProcessErrorCount > 0 then
          begin
            AddToLog(0, FloatToStr(FProcessErrorCount) + ' processes did not exit properly. This may mean something went wrong.');
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
    TotalBar.Max := 100;
    LNewPos := (100 * (LTotalFilesDone + FSkippedVideoCount) div FVideoDownloadTotalCMDCount);

    TotalBar.Position := LNewPos;
    VideoDownloaderProgressLabel.Caption := 'Progress: ' + FloatToStr(LTotalFilesDone + FSkippedVideoCount) + '/' + FloatToStr(FVideoDownloadTotalCMDCount + FSkippedVideoCount);
    if FVideoDownloadTotalCMDCount > 0 then
    begin
      MainForm.Caption := FloatToStr(TotalBar.Position) + '% [TVideoDownloader]';
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
  if MP4 = Copy(TypeStr, 1, Length(MP4)) then
  begin
    Result := '.m4a';
  end
  else if _3GP = Copy(TypeStr, 1, Length(_3GP)) then
  begin
    Result := '.m4a'
  end
  else if WEBM = Copy(TypeStr, 1, Length(WEBM)) then
  begin
    Result := '.ogg';
  end
  else if FLV = Copy(TypeStr, 1, Length(FLV)) then
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
  if MP4 = Copy(TypeStr, 1, Length(MP4)) then
  begin
    Result := '140';
  end
  else if _3GP = Copy(TypeStr, 1, Length(_3GP)) then
  begin
    Result := '140'
  end
  else if WEBM = Copy(TypeStr, 1, Length(WEBM)) then
  begin
    Result := '171';
  end
  else if FLV = Copy(TypeStr, 1, Length(FLV)) then
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
  if MP4 = Copy(TypeStr, 1, Length(MP4)) then
  begin
    Result := '.mp4';
  end
  else if _3GP = Copy(TypeStr, 1, Length(_3GP)) then
  begin
    Result := '.3gp'
  end
  else if WEBM = Copy(TypeStr, 1, Length(WEBM)) then
  begin
    Result := '.webm';
  end
  else if FLV = Copy(TypeStr, 1, Length(FLV)) then
  begin
    Result := '.flv';
  end;
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
            ShellExecute(0, 'open', 'http://www.ozok26.com/tvdeodownloader-8', nil, nil, SW_SHOWNORMAL);
          end;
        end
        else
        begin
          if FUserUpdateCheck then
          begin
            Application.MessageBox('You have the latest version available.', 'Info', MB_ICONERROR);
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(VersionFile);
  end;
end;

end.

