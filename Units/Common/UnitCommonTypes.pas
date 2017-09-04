{ *
  * Copyright (C) 2014-2017 ozok <ozok26@gmail.com>
  *
  * This file is part of TVideoDownloader.
  *
  * TVideoDownloader is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * TVideoDownloader is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with TVideoDownloader.  If not, see <http://www.gnu.org/licenses/>.
  *
  * }
unit UnitCommonTypes;

interface

uses
  Generics.Collections, Classes, Windows, SysUtils, Messages;

type
  TUserPass = record
    UserName: string;
    Password: string;
  end;

type
  TFormadItem = class
    Id: string;
    Desc: string;
    Ext: string;
    VideoCodec: string;
    AudioCodec: string;
  end;

type
  TLinkType = (general = 0, soundcloud = 1);

type
  TDownloadItem = class(TObject)
  private
    FFormats: TList<TFormadItem>;
    FFormatIndex: Integer;
    FFormatIntegers: TStringList;
    FOutputExtensions: TStringList;
    FOutputExtensionIndex: Integer;
    FSubtitles: TStringList;
    FSubIndex: integer;
    FImagePath: string;
    FOutputFileName: string;
    FType: TLinkType;
  public
    property Formats: TList<TFormadItem> read FFormats write FFormats;
    property FormatIndex: Integer read FFormatIndex write FFormatIndex;
    property OutputExtensions: TStringList read FOutputExtensions write FOutputExtensions;
    property OutputExtensionIndex: Integer read FOutputExtensionIndex write FOutputExtensionIndex;
    property ImagePath: string read FImagePath write FImagePath;
    property OutputFileName: string read FOutputFileName write FOutputFileName;
    property Subtitles: TStringList read FSubtitles write FSubtitles;
    property SubIndex: integer read FSubIndex write FSubIndex;
    property LinkType: TLinkType read FType write FType;
    constructor Create;
    destructor Destroy; override;
  end;

  TDownloadItemList = TList<TDownloadItem>;

implementation

{ TDownloadItem }

constructor TDownloadItem.Create;
begin
  FFormats := TList<TFormadItem>.Create;
  FFormatIntegers := TStringList.Create;
  FOutputExtensions := TStringList.Create;
  FSubtitles := TStringList.Create;
  FFormatIndex := -1;
  FSubIndex := -1;
  FType := general;
end;

destructor TDownloadItem.Destroy;
begin
  FFormats.Free;
  FFormatIntegers.Free;
  FOutputExtensions.Free;
  FSubtitles.Free;
  inherited;
end;

end.

