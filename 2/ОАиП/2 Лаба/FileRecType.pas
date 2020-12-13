unit FileRecType;

interface

type

  TString = String[25];

 {��� ������}
  TFPrice = record
    Code: Integer;
    Cost: Integer;
    Name: TString;
    Quantity: Integer;
  end;

  TFGoods = record
    Code: Integer;
    Number: Integer;
    Quantity: Integer;
  end;

  TFOrder = record
    Number: Integer;
    Date: TDateTime;
    Props: TString;
  end;

 {��� �������}
  TPriceRef = ^TPrice;

  TPrice = record
      info: TFPrice;
      Ref: TPriceRef;
  end;

  TGoodsRef = ^TGoods;

  TGoods = record
      info: TFGoods;
      Ref: TGoodsRef;
  end;

  TOrderRef = ^TOrder;

  TOrder = record
      info: TFOrder;
      Ref: TOrderRef;
  end;


procedure ReadFile(var PPrice: TPriceRef; var PGoods: TGoodsRef; var POrder: TOrderRef);
procedure SaveFile(var PPrice: TPriceRef; var PGoods: TGoodsRef; var POrder: TOrderRef);
procedure help(AdminFlag, PropsFlag: Boolean);

implementation

procedure ReadFile(var PPrice: TPriceRef; var PGoods: TGoodsRef; var POrder: TOrderRef);
var
  PriceTxt: file of TFPrice;
  GoodsTxt: file of TFGoods;
  OrderTxt: file of TFOrder;
begin
  AssignFile(PriceTxt,'Price.dat');
  AssignFile(OrderTxt,'Order.dat');
  AssignFile(GoodsTxt,'Goods.dat');

  Reset(PriceTxt);
  Reset(GoodsTxt);
  Reset(OrderTxt);

  {������������ ������ ������ Order � ������}
  while not eof(OrderTxt) do
  begin
    New(POrder.Ref);
    POrder:= POrder.Ref;
    Read(OrderTxt, POrder.info);
  end;

  {������������ ������ ������ Price � ������}
  while not eof(PriceTxt) do
  begin
    New(PPrice.Ref);
    PPrice:= PPrice.Ref;
    Read(PriceTxt, PPrice.info);
  end;

  {������������ ������ ������ Goods � ������}
  while not eof(GoodsTxt) do
  begin
    New(PGoods.Ref);
    PGoods:= PGoods.Ref;
    Read(GoodsTxt, PGoods.info);
  end;

  PPrice.Ref:= nil;
  POrder.Ref:= nil;
  PGoods.Ref:= nil;

  CloseFile(PriceTxt);
  CloseFile(GoodsTxt);
  CloseFile(OrderTxt);
end;

procedure SaveFile(var PPrice: TPriceRef; var PGoods: TGoodsRef; var POrder: TOrderRef);
var
  PriceTxt: file of TFPrice;
  GoodsTxt: file of TFGoods;
  OrderTxt: file of TFOrder;
begin
  AssignFile(PriceTxt,'Price.dat');
  AssignFile(OrderTxt,'Order.dat');
  AssignFile(GoodsTxt,'Goods.dat');

  Rewrite(PriceTxt);
  Rewrite(GoodsTxt);
  Rewrite(OrderTxt);

  {������������ ������ ������ Order}
  while (POrder.Ref <> nil) do
  begin
    POrder:= POrder.Ref;
    Write(OrderTxt, POrder.info);
  end;

  {������������ ������ ������ Price}
  while (PPrice.Ref <> nil) do
  begin
    PPrice:= PPrice.Ref;
    Write(PriceTxt, PPrice.info);
  end;

  {������������ ������ ������ Goods}
  while (PGoods.Ref <> nil) do
  begin
    PGoods:= PGoods.Ref;
    Write(GoodsTxt, PGoods.info);
  end;

  POrder.Ref:= nil;
  PPrice.Ref:= nil;
  PGoods.Ref:= nil;

  CloseFile(PriceTxt);
  CloseFile(GoodsTxt);
  CloseFile(OrderTxt);
end;

procedure help(AdminFlag, PropsFlag: Boolean);
begin
  Writeln;
  Writeln('�Props - ����� �������� ���� �������� ��� �������������� (���� ����������� �������)');//��������
  Writeln('�Password - ��� ����������� ������');//��������
  Writeln('�List - ������ �������');//��������
  Writeln('�Sort - ���������� �������');
  Writeln('�Save - ��������� ���������');//��������
  Writeln('�SaveExit - ����� � ����������� ���������');//��������
  Writeln('�Exit - ����� ��� ����������');//��������

  if PropsFlag then
  begin
    Writeln;
    Writeln('������� �������:');
    Writeln('�Basket - �������� ������ ������');
    Writeln('�DeleteBasket - ������� ����� �� ������');
    Writeln('�FixBasket - ����� �������� � �����');//��������
    Writeln('�ClearBasket - ��������� ������� �����');
    Writeln('�Buy - ����� ������ ������ � ������');
    Writeln('�QuitProps - ����� �� ���������');//��������
  end;

  if AdminFlag then
    begin
      Writeln;
      Writeln('������� ��������������:');//��������
      Writeln('�Fix - ������������� ������ �������');//��������
      Writeln('�Delete - ����� ������� �� ������ �������');//��������
      Writeln('�DelteAll - ������� ���� ������');//��������
      Writeln('�Quit - ����� ����� �� ������ ������');//��������
    end;
  Writeln;
end;

end.
