unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin,
  lNetComponents;

type

  { TForm1 }

  TForm1 = class(TForm)
    udp: TLUDPComponent;
    mateBtn: TButton;
    kinderriegelBtn: TButton;
    customBtn: TButton;
    custombarcode: TEdit;
    receiverhost: TEdit;
    receiverport: TSpinEdit;
    procedure customBtnClick(Sender: TObject);
    procedure kinderriegelBtnClick(Sender: TObject);
    procedure mateBtnClick(Sender: TObject);
  private

  public
    procedure sendBarcode(code: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.mateBtnClick(Sender: TObject);
begin
  sendBarcode('4029764001807');
end;

procedure TForm1.kinderriegelBtnClick(Sender: TObject);
begin
  sendBarcode('40084077');
end;

procedure TForm1.customBtnClick(Sender: TObject);
begin
  sendBarcode(custombarcode.Text);
end;

procedure TForm1.sendBarcode(code: String);
begin

  udp.Connect('0.0.0.0', receiverport.Value);
  udp.SendMessage(code, receiverhost.Text);
  udp.Disconnect();
end;

end.

