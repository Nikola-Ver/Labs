program Laba2;

{$APPTYPE CONSOLE}

uses
  DateUtils, Windows, SysUtils, FileRecType;

var
  Command: String;
  CommandTo, Name: TString;
  Admin, Props, Presence: Boolean;
  Price, FirstPrice: TPriceRef;
  Goods, FirstGoods: TGoodsRef;
  Order, FirstOrder: TOrderRef;
  Code, i, CurrentCode, CurrentNumber: Integer;
begin
  CurrentNumber:= 0;
  Admin:= False;
  Props:= False;

  New(Order);
  New(Price);
  New(Goods);

  FirstOrder:= Order;
  FirstGoods:= Goods;
  FirstPrice:= Price;

  SetConsoleCP(1251);
  SetConsoleOutPutCP(1251);

  {������� ������ ������ (��������� � �����)}
  ReadFile(Price, Goods, Order);

  Writeln('_____,,,^._.^,,,_____':118);
  Writeln('|  Meow Coraparation! |':119);
  Writeln('```````````````````````':119);
  Writeln;
  Writeln('�Help - ������ ������');
  Writeln;

  Order:= FirstOrder;
  Goods:= FirstGoods;
  Price:= FirstPrice;

  repeat
    Code:= 0;
    Presence:= False;

    Write('>> ');
    Readln(Command);

    if (LowerCase(Command) = 'save') or (LowerCase(Command) = 'saveexit') then
      begin
        Price:= FirstPrice;
        Goods:= FirstGoods;
        Order:= FirstOrder;
        SaveFile(Price, Goods, Order);
      end; //������ � ������

    if LowerCase(Command) = 'quitprops' then
      begin
        Props:= False;
        Writeln;
        Writeln('�� ����� � ���������� ���������!');
        Writeln;
      end;//������ � ������

    if LowerCase(Command) = 'list' then
      begin
        Writeln;
        Price:= FirstPrice;
        if Price.Ref <> nil then
        begin
          Writeln('---------------------------------------------------------');
          Writeln('|   ���������  |         ��������        |  ����������  |');
          Writeln('|  � ��������  |                         |   � ��./��.  |');
          Writeln('|--------------|-------------------------|--------------|');
          repeat
            Price:= Price.Ref;
            Writeln('|', Price.info.Cost:14, '|',Price.info.Name:25, '|', Price.info.Quantity:14, '|');
          until (Price.Ref = nil);
          Writeln('---------------------------------------------------------');
        end
        else
          Writeln('������ ����!');
        Writeln;
      end;//������ � ������

    if LowerCase(Command) = 'props' then
      if not Props then
        begin
          repeat
            Write('>> ������� ���� ��������: ');
            Readln(CommandTo);
          until (Length(CommandTo) > 0);

          Name:= CommandTo;
          Props:= True;

          while (Order.Ref <> nil) and (Order.info.Props <> CommandTo) do
          begin
            Order:= Order.Ref;
            Inc(Code);
          end;

          if (Order.Ref <> nil) or (Order.info.Props = CommandTo) then
            begin
              Writeln;
              Writeln('� ������������, ',CommandTo,'!');
              Writeln;
            end
          else
            begin
              New(Order.Ref);
              Order:= Order.Ref;
              Order.info.Props:= CommandTo;
              Order.Ref:= nil;
              Writeln;
              Writeln('�������� ��������!');
              Writeln;
            end;
        end
      else
        begin
          Writeln;
          Writeln('�� ��� �������������! ����� �������� �������� �������� �QuitProps - ����� �� ���������...');
          Writeln;
        end;

    if LowerCase(Command) = 'password' then
      begin
        if Not Admin then
        begin
          Write('>> ������� ������: ');
          Readln(Command);
          Writeln;
          if Command = '65683164' then
            begin
              Writeln('������ ������ �������!');
              Admin:= True;
            end
          else
            Writeln('�������� ������!');
          Writeln;
        end
        else
          Writeln('�� ��� ������������� ��� �����! ����� ����� �� ������ ������ ������ �Quit - ����� ����� �� ������ ������');
      end;//������ � ������

    if (LowerCase(Command) = 'quit') and Admin then
      begin
        Admin:= False;
        Writeln;
        Writeln('�������� ����� ��������������!');
        Writeln;
      end;//������ � ������

    if (LowerCase(Command) = 'fix') and Admin then
      begin
        Price:= FirstPrice;
        while Price.Ref <> nil do
          Price:= Price.Ref;
        CurrentCode:= Price.info.Code;

        Price:= FirstPrice;
        Writeln;
        Write('>> �������� ������: ');
        Readln(CommandTo);
        while (Price.Ref <> nil) and (Price.info.Name <> CommandTo) do
        begin
          Price:= Price.Ref;
          Inc(Code);
        end;

        if Price.info.Name <> CommandTo then
          begin
            New(Price.Ref);
            Price:= Price.Ref;
            Price.Ref:= nil;
          end
        else
          Presence:= True;

        Price.info.Code:= CurrentCode + 1;
        Price.info.Name:= CommandTo;
        if not Presence then
          begin
            repeat
              Write('>> ���� ������ (� ����������� �������� �� ��. ��� �� ��.): ');
              Readln(Command);
              if StrToInt(Command) < 0 then
                Writeln('�� �� ������ ������� ������������� ���������!')
            until (StrToInt(Command) >= 0);
            Price.info.Cost:= StrToInt(Command);
          end
        else
          begin
            Write('>> �������� ���� ��������? (�Yes - ����� �������� ����): ');
            Readln(Command);
            if LowerCase(Command) = 'yes' then
              repeat
                Write('>> ������� ����� ����: ');
                Readln(Command);
                if StrToInt(Command) < 0 then
                  Writeln('�� �� ������ ������� ������������� ���������!')
                else
                  begin
                    Price.info.Cost:= StrToInt(Command);
                    Writeln;
                    Writeln('���� �������� �������!');
                    Writeln;
                  end;
              until (StrToInt(Command) >= 0);
          end;
        repeat
          if not Presence then
            begin
              Write('>> ����������: ');
              Readln(Command);
            end
          else
            begin
              Write('>> �������� ����������? (�Yes - ����� �������� ����������): ');
              Readln(Command);
              if LowerCase(Command) = 'yes' then
                repeat
                  Write('>> ������� ����������, ������� �� ������ ��������: ');
                  Readln(Command);
                  if (Price.info.Quantity + StrToInt(Command) < 0) then
                    Writeln('�� �� ������ ������� ������ ��� �������� ������!')
                  else
                    begin
                      Writeln;
                      Writeln('���������� �������� �������!');
                    end;
                until ((Price.info.Quantity + StrToInt(Command) >= 0))
              else
                Command:= '0';
            end;
          if Presence and (Price.info.Quantity + StrToInt(Command) < 0) then
            Writeln('�� �� ������ ������ ������ ��� �������, ��� ������� ������������� ���������� ������!');
        until (Price.info.Quantity + StrToInt(Command) >= 0) or (StrToInt(Command) >= 0);

        if Presence then Price.info.Quantity:= Price.info.Quantity + StrToInt(Command)
        else Price.info.Quantity:= StrToInt(Command);
        Writeln;
        Writeln('����� ������� �������� ��� �����!');
        Writeln;

        if Price.info.Quantity = 0 then
          begin
            Price:= FirstPrice;
            for i := 1 to Code - 1 do
              Price:= Price.Ref;
            Price.Ref:= Price.Ref.Ref;
          end;
      end;//����������� ��� ���� �������!

    if (LowerCase(Command) = 'delete') and Admin then
      begin
        Write('>> ������� �����, ������� �� ������ �������: ');
        Readln(CommandTo);
        Price:= FirstPrice;

        while (Price.Ref <> nil) and (Price.info.Name <> CommandTo) do
        begin
          Price:= Price.Ref;
          Inc(Code);
        end;

        if (Price.Ref <> nil) or (Price.info.Name = CommandTo) then
          begin
            Price:= FirstPrice;
            for i := 1 to Code - 1 do
              Price:= Price.Ref;
            if Price.Ref <> nil then
              Price.Ref:= Price.Ref.Ref
            else
              Price.Ref:= nil;
            Writeln;
            Writeln('����� ������� ������!');
            Writeln;
          end
        else
          Writeln('������ ������ ���� � ������!');
      end;//����������� ��� ���� �������!

    if (LowerCase(Command) = 'fixbasket') and Props then
      begin
        Write('>> �������� ������: ');
        Readln(CommandTo);

        Order:= FirstOrder;
        while Order.Ref <> nil do
        begin
          Order:= Order.Ref;
          if CurrentNumber > Order.info.Number then
            CurrentNumber:= Order.info.Number;
        end;

        Price:= FirstPrice;
        while (Price.Ref <> nil) and (Price.info.Name <> CommandTo) do
          Price:= Price.Ref;

        Goods:= FirstGoods;
        while (Goods.Ref <> nil) and (Goods.info.Code <> Price.info.Code) do
          Goods:= Goods.Ref;

        Order:= FirstOrder;
        while (Order.Ref <> nil) and (Order.info.Props <> Name) do
          Order:= Order.Ref;

        if Goods.Ref <> nil then
          begin
            Write('>> �������� ���������� ������ � ����� ������? (�Yes - ����� ��������): ');
            CurrentNumber:= Order.info.Number;
            Readln(Command);
          end;

        if (Goods.Ref = nil) or (LowerCase(Command) = 'yes') then
          if Price.info.Name = CommandTo then
            begin
              Write('>> ���������� ������: ');
              Readln(Command);
              if Price.info.Quantity - StrToInt(Command) >= 0 then
                begin
                  Price.info.Quantity:= Price.info.Quantity - StrToInt(Command);

                  if Price.Ref = nil then
                    begin
                      Goods.info.Code:= Price.info.Code;
                      Goods.info.Quantity:= StrToInt(Command);
                      Order.info.Number:= CurrentNumber + 1;
                      Order.info.Date:= Now;
                    end
                  else
                    begin
                      if StrToInt(Command) > 0 then
                        begin
                          Goods.info.Quantity:= Goods.info.Quantity + StrToInt(Command);
                          Goods.info.Code:= Price.info.Code;
                          Order.info.Date:= Now;
                        end
                      else
                        Writeln('�� �� ������ ����� ���������� ������ �������, ���� ������ 0');
                    end;

                  Writeln;
                  Writeln('����� ������� �������� � �����!');
                  Writeln;

                  if Price.info.Quantity = 0 then
                    begin
                      Code:= Price.info.Code;
                      Price:= FirstPrice;
                      while Price.Ref.info.Code <> Code do
                        Price:= Price.Ref;

                      if Price.Ref <> nil then
                        Price.Ref:= Price.Ref.Ref
                      else
                        Price.Ref:= nil;
                    end;
                end
              else
                Writeln('��������, �� �� ������ ����� ��������, ',Price.info.Quantity);
          end
        else
          Writeln('������ ������ ��� �� ������!');
      end;

    if (LowerCase(Command) = 'deleteall') and Admin then
      begin
        Writeln;
        Writeln('������ ��������� ������!');
        Writeln;
        Price:= FirstPrice;
        Price.Ref:= nil;
      end;//������ � ������

    if LowerCase(Command) = 'help' then help(Admin, Props);//������ � ������

  until (LowerCase(Command) = 'exit') or (LowerCase(Command) = 'saveexit');
end.
