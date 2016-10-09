unit UnitCommonMethods;

interface

uses
  Classes, System.SysUtils;

function StringStartsWith(const Str: string; const SubStr: string):Boolean;
function CreateTempFileName: string;

implementation

function CreateTempFileName: string;
var
  LGUID: TGUID;
begin
  CreateGUID(LGUID);
  Result := GUIDToString(LGUID);
end;

function StringStartsWith(const Str: string; const SubStr: string):Boolean;
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
