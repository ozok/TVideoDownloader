unit UnitYTSearch;

interface

uses
  System.Classes, System.SysUtils, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdThreadComponent, Generics.Collections, JvHtmlParser,
  StrUtils;

type
  TSearchResultItem = record
    Link: string;
    ImgPath: string;
    Title: string;
    From: string;
    ViewCount: string;
  end;

type
  TYTSearcher = class
  private
    FRunning: Boolean;
    FQuery: string;
    FHttp: TIdHTTP;
    FSSL: TIdSSLIOHandlerSocketOpenSSL;
    FThread: TIdThreadComponent;
    FResults: TList<TSearchResultItem>;
    FErrorCode: Integer;
    FHtmlParser: TJvHTMLParser;
    procedure ThreadComponentRun(Sender: TIdThreadComponent);
    procedure JvHTMLParserKeyFound(Sender: TObject; Key, Results, OriginalLine: string);
    function ParseTitleLine(const Line: string): string;
    function ParseLinkLine(const Line: string): string;
  public
    property Results: TList<TSearchResultItem> read FResults;
    property Running: Boolean read FRunning;
    property ErrorCode: Integer read FErrorCode;
    constructor Create();
    destructor Destroy; override;
    procedure Download(const Query: string);
  end;

implementation

uses
  UnitMain;

const
  USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36 OPR/36.0.2130.65';
  URL_START = 'https://www.youtube.com/results?search_query=';

const
  STATE_UNKOWN = -1;
  STATE_OK = 0;
  STATE_DOWNLOADED_DATA_EMPTY = 1;
  STATE_ERROR_WHILE_DOWNLOADING = 2;

{ TYTSearcher }

constructor TYTSearcher.Create;
begin
  FSSL := TIdSSLIOHandlerSocketOpenSSL.Create();
  FHttp := TIdHTTP.Create();
  FHttp.Request.UserAgent := USER_AGENT;
  FThread := TIdThreadComponent.Create();
  FThread.OnRun := ThreadComponentRun;
  FResults := TList<TSearchResultItem>.Create;
  FHtmlParser := TJvHTMLParser.Create(nil);
  FHtmlParser.OnKeyFound := JvHTMLParserKeyFound;

  FRunning := False;
  FErrorCode := STATE_UNKOWN;
end;

destructor TYTSearcher.Destroy;
begin
  FSSL.Free;
  FHttp.Free;
  FThread.Free;
  FResults.Free;
  FHtmlParser.Free;
end;

procedure TYTSearcher.Download(const Query: string);
begin
  while not FThread.Terminated do
  begin
    FThread.Terminate;
    Sleep(50);
  end;
  FResults.Clear;

  FRunning := True;
  FQuery := Query;
  FThread.Start;
end;

procedure TYTSearcher.JvHTMLParserKeyFound(Sender: TObject; Key, Results, OriginalLine: string);
const
  A_CLASS = 'yt-uix-sessionlink yt-uix-tile-link yt-ui-ellipsis yt-ui-ellipsis-2       spf-link';
begin
  if Results.contains(A_CLASS) then
  begin
    MainForm.Memo1.Lines.Add(ParseTitleLine(Results) + '/' + ParseLinkLine(Results));
  end;
end;

function TYTSearcher.ParseLinkLine(const Line: string): string;
const
  START_STR = 'href="/';
  END_STR = '" class="';
var
  LStartPos, LEndPos: integer;
begin
  LStartPos := Pos(START_STR, Line);
  LEndPos := Pos(END_STR, Line);
  Result := Line.Substring(LStartPos + Length(START_STR) - 1, LEndPos - LStartPos - Length(START_STR))
end;

function TYTSearcher.ParseTitleLine(const Line: string): string;
const
  START_STR = 'dir="ltr">';
  END_STR = '</';
var
  LStartPos, LEndPos: integer;
begin
  LStartPos := Pos(START_STR, Line);
  LEndPos := Pos(END_STR, Line);
  Result := Line.Substring(LStartPos + Length(START_STR) - 1, LEndPos - LStartPos - Length(START_STR))
end;

procedure TYTSearcher.ThreadComponentRun(Sender: TIdThreadComponent);
var
  LDataStr: string;
  LDataList: TStringList;
begin
  try
    LDataStr := FHttp.Get(URL_START + FQuery);
    if LDataStr.Length > 0 then
    begin
      LDataList := TStringList.Create;
      try
        LDataList.Text := LDataStr;

        FHtmlParser.ClearConditions;
        FHtmlParser.AddCondition('URL', '<a', 'a>');
        FHtmlParser.AnalyseString(LDataStr);
      finally
        LDataList.Free;
      end;
      FErrorCode := STATE_OK;
    end
    else
    begin
      FErrorCode := STATE_DOWNLOADED_DATA_EMPTY;
    end;
  except
    on E: Exception do
    begin
      FErrorCode := STATE_ERROR_WHILE_DOWNLOADING;
    end;
  end;

  FRunning := False;
  FThread.Terminate;
end;

end.

