library test_interop;

uses
  SysUtils,
  Classes;

function AddIntegers(const _a, _b: integer): integer; stdcall;
begin
  Result := _a + _b;
end;

exports
   AddIntegers;

begin
end.
