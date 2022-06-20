program financetokenreader;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils
  { you can add units after this };

var
  i: integer;
  params: string;

begin
  params := '';
  for i := 0 to ParamCount  do
  begin
    params += ParamStr(i) + ' ';
  end;

  ////while true do
  //begin
  WriteLn(params);
  Sleep(2000);
  WriteLn('----TAG PRESENT----');
  Sleep(2000);
  WriteLn('----BEGIN JSON----');
  WriteLn('{"error":"", "token":"abc"}');
  WriteLn('----END JSON----');
  Sleep(500);
  //end;
end.

