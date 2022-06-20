unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  fphttpclient, fpopenssl, opensslsockets, fpjson, jsonparser, inifiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    monthlyclosingTab: TTabSheet;
    userBalanceSum: TLabel;
    Label2: TLabel;
    userBalanceView: TListView;
    debugout: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    monthlyClosingView: TListView;
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure WebRequest(path: string; var Data: TJSONData);
    procedure DoBalance();
    procedure DoMonthly();

  private
    endpoint: string;
    apikey: string;
    servicetoken: string;
  public


  end;

var
  Form1: TForm1;

  conf: TIniFile;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.WebRequest(path: string; var Data: TJSONData);
var
  AURL: string;
  http: tfphttpclient;
  l: TStringStream;
  P: TJSONParser;
begin
  AURL := endpoint + path;

  l := TStringStream.Create('');
  http := tfphttpclient.Create(nil);

  try
    http.AllowRedirect := True;

    http.AddHeader('X-Api-Key', apikey);
    http.AddHeader('X-Servicetoken', servicetoken);
    http.AddHeader('Content-Type', 'application/json');

    debugout.Lines.Add('=> GET ' + AURL);

    http.httpmethod('GET', AURL, l, []);

    debugout.Lines.Add(l.DataString);

    l.Position := 0;
    P := TJSONParser.Create(l);
    try
      Data := P.Parse;
    finally
      P.Free;
    end;

  finally
    http.Free;
    l.Free;
  end;

end;

procedure TForm1.DoBalance();
var
  i: integer;
  D: TJSONData;
  itm: TListItem;
begin

  webrequest('/service/mifare/userbalance', D);
  for i := 0 to TJSONObject(d).Arrays['accounts'].Count - 1 do
  begin
    itm := userBalanceView.Items.Add;
    itm.Caption := TJSONObject(d).Arrays['accounts'].Objects[
      i].Objects['user'].Strings['nickname'];
    itm.SubItems.Add(TJSONObject(d).Arrays['accounts'].Objects[
      i].Floats['balance'].ToString + ' €');

  end;

  userBalanceSum.Caption := TJSONObject(d).Floats['sum'].ToString + ' €';
end;

procedure TForm1.DoMonthly();
var
  i: integer;
  D: TJSONData;
  curr: TJSONObject;
  itm: TListItem;
begin

  webrequest('/service/mifare/monthlyclosing', D);
  for i := 0 to TJSONArray(d).Count - 1 do
  begin
    curr := TJSONArray(d).Objects[i];
    itm := monthlyClosingView.Items.Add;
    itm.Caption := curr.Integers['finyear'].ToString;

    itm.SubItems.Add(curr.Integers['finmonth'].ToString);
    itm.SubItems.Add(curr.Floats['donationsin'].ToString + ' €');
    itm.SubItems.Add(curr.Floats['membershipfeein'].ToString + ' €');
    itm.SubItems.Add(curr.Floats['snacktransferrounded'].ToString + ' €');
    itm.SubItems.Add(curr.Floats['snackint'].ToString + ' €');
    itm.SubItems.Add(curr.Floats['snackext'].ToString + ' €');

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  conf := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\conf.ini');
  endpoint := conf.ReadString('API', 'endpoint', '');
  apikey := conf.ReadString('API', 'apikey', '');
  servicetoken := conf.ReadString('API', 'servicetoken', '');

  DoBalance();
  DoMonthly();

end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

end.
