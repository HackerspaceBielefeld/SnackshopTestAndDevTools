program mftest;

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
  WriteLn('{"error":"", "oldBalance":"12.30", "newBalance":"55"}');
  //WriteLn('{"error":"","transactions":[{"id":"1","created":"2021-04-01T21:12:12.000Z","usagetext":"test","amount":"5.3","oldbalance":"12.51","newbalance":"10.01"}]}');
  WriteLn('----END JSON----');
  Sleep(500);
  //end;
end.

