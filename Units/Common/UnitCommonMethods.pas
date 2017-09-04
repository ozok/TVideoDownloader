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
unit UnitCommonMethods;

interface

uses
  Classes, System.SysUtils;

function StringStartsWith(const Str: string; const SubStr: string): Boolean;

function CreateTempFileName: string;

function IntToTime(const TimeAsInt: integer): string;

implementation

function IntToTime(const TimeAsInt: integer): string;
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

function CreateTempFileName: string;
var
  LGUID: TGUID;
begin
  CreateGUID(LGUID);
  Result := GUIDToString(LGUID);
end;

function StringStartsWith(const Str: string; const SubStr: string): Boolean;
begin
  if Length(SubStr) > Length(Str) then
  begin
    Result := False;
  end
  else
  begin
    Result := CompareMem(Pointer(SubStr), Pointer(Str), ByteLength(SubStr));
  end;
end;

end.

