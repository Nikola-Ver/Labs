program laba7_2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const Min_Strok = 4;
  Max_Strok = Min_Strok * 2;
 Max_Char = 30;

type TText = array [1..Max_Strok] of String[Max_Char];

var Text, Cast_Text: TText;
  Flag: Boolean;


{Показывает количество строк и максимальное количество символов в строке}
procedure Max_Quantity_Of_Char(Quantity: Integer);
 var Current_Quantity: Integer;
begin
  Writeln('Maximum number of string and characters [', Min_Strok,', ', Max_Char,']');
  for Current_Quantity:= 1 to Quantity do Write('.');
  Writeln
end;


{Ввод массива}
procedure Enter(var Text: TText);
 var Stroka: Integer;
begin
  for Stroka:= 1 to Min_Strok do Readln(Text[Stroka]);
  Writeln;
  Writeln
end;


{Удаление лишних пробелов}
procedure Removing_Extra_Spaces(var Text:TText);
 var Stroka: Integer;
begin
  Stroka:= 1;
  while (Stroka <= Min_Strok) do
  begin
    Text[Stroka]:=Trim(Text[Stroka]);
    Inc(Stroka)
  end;
end;


{Удаление переносов}
procedure Removing_Carry(var Text:TText);
 var Stroka, Cast_Stroka, First_Symbol_Carry, Last_Symbol_Carry: Integer;
  Temp: String;
begin
  Cast_Stroka:= 1;
  for Stroka:= 1 to Min_Strok do
  begin
    if Text[Stroka, Length(Text[Stroka])] = '-' then
    begin
      Last_Symbol_Carry:= 1;
      First_Symbol_Carry:= Length(Text[Stroka]);

      while (Text[Stroka, First_Symbol_Carry] <> #32) and (First_Symbol_Carry > 0) do Dec(First_Symbol_Carry);
      Temp:= Copy(Text[Stroka], First_Symbol_Carry + 1, Length(Text[Stroka]) - First_Symbol_Carry - 1);

      while (Text[Stroka + 1, Last_Symbol_Carry] <> #32) and (Text[Stroka + 1, Last_Symbol_Carry] <> #0) do Inc(Last_Symbol_Carry);
      Temp:=Temp + Copy(Text[Stroka + 1], 1, Last_Symbol_Carry - 1);

      if (Length(Temp) > Max_Char) then Flag:=False;

      if First_Symbol_Carry > 0 then Cast_Text[Cast_Stroka]:= Copy(Text[Stroka], 1, First_Symbol_Carry)
      else Dec(Cast_Stroka);
      Cast_Text[Cast_Stroka + 1]:=Temp;
      Delete(Text[Stroka + 1], 1, Last_Symbol_Carry)
    end
    else
    begin
      Cast_Text[Cast_Stroka]:= Text[Stroka];
      Dec(Cast_Stroka)
    end;

    Inc(Cast_Stroka, 2)
  end
end;


{Перезаписывает массив без переносов}
procedure Rewrite(var Cast_Text, Text: TText);
 var Symbol: Integer;
  Stroka, Cast_Stroka: Integer;
 Temp:String;
begin
  Cast_Stroka:= 1;
  Stroka:= 1;
  while (Cast_Stroka <= Max_Strok) and (Length(Cast_Text[Cast_Stroka]) > 0) do
  begin
    Symbol:= 1;
    while (Cast_Text[Cast_Stroka, Symbol] <> #32) and (Cast_Text[Cast_Stroka, Symbol] <> #0) do Inc(Symbol);
    Temp:= Copy(Cast_Text[Cast_Stroka], 1, Symbol);
    Delete(Cast_Text[Cast_Stroka], 1, Symbol);

    if (Length(Cast_Text[Cast_Stroka]) = 0) then Inc(Cast_Stroka);

    if (Length(Text[Stroka]) + Length(Temp) <= Max_Char) then Text[Stroka]:= Text[Stroka] + Temp
    else
    begin
      Inc(Stroka);
      Text[Stroka]:=Temp
    end
  end
end;


{Вывод массива без переносов}
procedure Conclusion(Text: TText);
 var Stroka, Current_Quantity: Integer;
begin
  Stroka:= 1;
  if Length(Text[Stroka]) <> 0 then
  begin
    Writeln('Text without hyphenation');
    for Current_Quantity:= 1 to Max_Char do Write('.');
    Writeln;
    while (Stroka <= Max_Strok) and (Length(Text[Stroka]) > 0) do
    begin
      Writeln(Text[Stroka]);
      Inc(Stroka)
    end
  end
  else Writeln('. . . Empty string . . .')
end;


{Очистка массивов}
procedure Cleaning_Arrays(var Cast_Text:TText);
 var Stroka, Current_Strok_Count, Symbol: Integer;
begin
  for Stroka:= 1 to Min_Strok do Delete(Text[Stroka], 1, Length(Text[Stroka]));

  Current_Strok_Count:= 1;
  while (Current_Strok_Count <= Max_Strok) and (Length(Cast_Text[Current_Strok_Count]) > 0) do Inc(Current_Strok_Count);

  Stroka:= 1;
  while (Stroka <= Current_Strok_Count) do
  begin
    Cast_Text[Stroka]:=Trim(Cast_Text[Stroka]);
    Inc(Stroka)
  end;

  for Stroka:= 1 to Current_Strok_Count do
  begin
    Symbol:= 1;
    while Symbol <= Length(Cast_Text[Stroka]) do
    begin
      if (Cast_Text[Stroka, Symbol] = Cast_Text[Stroka, Symbol + 1]) and (Cast_Text[Stroka, Symbol] = #32) then
      begin
        Delete(Cast_Text[Stroka], Symbol, 1);
        Dec(Symbol)
      end;
      Inc(Symbol)
    end
  end;

  Stroka:= 2;
  while (Stroka <= Current_Strok_Count) do
  begin
    if Length(Cast_Text[Stroka]) > 0 then Cast_Text[Stroka]:=#32 + Cast_Text[Stroka] + #32; 
    Inc(Stroka, 2)
  end
end;


begin
  Flag:= True;

  Max_Quantity_Of_Char(Max_Char);

  Enter(Text);

  Removing_Extra_Spaces(Text);

  Removing_Carry(Text);

  if Flag then
  begin
    Cleaning_Arrays(Cast_Text);

    Rewrite(Cast_Text, Text);

    Conclusion(Text)
  end
  else Writeln('Error, a word is longer than a line . . .');

  readln
end.

