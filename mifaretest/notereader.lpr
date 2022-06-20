program notereader;

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
  WriteLn('----NOTE PRESENT----');
  Sleep(1000);
  WriteLn('----DATAEXCH S1----');
  Sleep(1000);
  WriteLn('----DATAEXCH S2----');
  Sleep(1000);
  WriteLn('----BEGIN JSON----');
  //WriteLn('{"error":"strimming", "notevalue":"10","oldBalance":"12.30", "newBalance":"55"}');
  WriteLn('{"error":"", "notevalue":"10","oldBalance":"12.30", "newBalance":"55"}');
  WriteLn('----END JSON----');
  Sleep(500);
  //end;
end.

