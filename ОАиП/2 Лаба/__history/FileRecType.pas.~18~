unit FileRecType;

interface

type

  TString = String[25];

 {Для файлов}
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

 {Для записей}
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

  {Перезаписать старый список Order в запись}
  while not eof(OrderTxt) do
  begin
    New(POrder.Ref);
    POrder:= POrder.Ref;
    Read(OrderTxt, POrder.info);
  end;

  {Перезаписать старый список Price в запись}
  while not eof(PriceTxt) do
  begin
    New(PPrice.Ref);
    PPrice:= PPrice.Ref;
    Read(PriceTxt, PPrice.info);
  end;

  {Перезаписать старый список Goods в запись}
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

  {Перезаписать старый список Order}
  while (POrder.Ref <> nil) do
  begin
    POrder:= POrder.Ref;
    Write(OrderTxt, POrder.info);
  end;

  {Перезаписать старый список Price}
  while (PPrice.Ref <> nil) do
  begin
    PPrice:= PPrice.Ref;
    Write(PriceTxt, PPrice.info);
  end;

  {Перезаписать старый список Goods}
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
  Writeln('•Props - чтобы оставить свой реквизит или авторизоваться (дает возможность покупок)');//Работает
  Writeln('•Password - для авторизации админа');//Работает
  Writeln('•List - список товаров');//Работает
  Writeln('•Sort - сортировка списков');
  Writeln('•Save - сохранить изменения');//Работает
  Writeln('•SaveExit - выход с сохранением изменений');//Работает
  Writeln('•Exit - выйти без сохранения');//Работает

  if PropsFlag then
  begin
    Writeln;
    Writeln('Команды клиента:');
    Writeln('•Basket - просмотр списка заказа');
    Writeln('•DeleteBasket - удалить товар из заказа');
    Writeln('•FixBasket - чтобы добавить в заказ');//Работает
    Writeln('•ClearBasket - полностью очищает заказ');
    Writeln('•Buy - чтобы купить товары в заказе');
    Writeln('•QuitProps - выйти из реквизита');//Работает
  end;

  if AdminFlag then
    begin
      Writeln;
      Writeln('Команды администратора:');//Работает
      Writeln('•Fix - редактировать список товаров');//Работает
      Writeln('•Delete - чтобы удалить из списка товаров');//Работает
      Writeln('•DelteAll - удалить весь список');//Работает
      Writeln('•Quit - чтобы выйти из режима админа');//Работает
    end;
  Writeln;
end;

end.
