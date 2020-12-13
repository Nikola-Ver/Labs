program L7;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TSet = Set of Byte;

procedure Input(var X: TSet);
var
  i,d: Integer;
  Num: Byte;
begin
  repeat
    i:= 0;
    Readln(Num);
    Include(X,Num);
    for d := 0 to 255 do
      if d in X then
        i:= i + 1;
  until (i = 10);
end;

procedure MakeSet(Mn: TSet; var PodMn: TSet);
var
  i: Byte;
begin
  for i := 0 to 255 do
    begin
      if (i in Mn) and (i mod 7 = 0) then
        Include(PodMn,i);
    end;
end;

function SearchPower(Mn: TSet): String;
var
  i, d: Byte;
begin
  d:= 0;
  for i := 0 to 255 do
    if i in Mn then
      Inc(d);

  Result:= 'Мощность множества Y1 = ' + IntToStr(d);
end;

procedure Output(Mn: TSet);
var
  i: Byte;
  Flag: Boolean;
begin
  Flag:= True;
  for i := 0 to 255 do
    if (i in Mn) then
      if Flag then
        begin
          Flag:= False;
          Write(IntToStr(i));
        end
      else
        Write(',' + IntTostr(i));
  Writeln('}');
end;

var
  Y,Y1,X1,X2,X3: TSet;
begin
  X1:= [];
  X2:= [];
  X3:= [];

  Writeln('Введите множество X1:');
  Input(X1);
  Writeln('Введите множество X2:');
  Input(X2);
  Writeln('Введите множество X3:');
  Input(X3);
  Writeln;

  Y:= (X1 + X2) * (X2 + X3);
  Write('Множество Y = {');
  Output(Y);
  Writeln;
  MakeSet(Y,Y1);
  Write('Подмножество Y1 = {');
  OutPut(Y1);
  Writeln;
  Writeln(SearchPower(Y1));

  Readln;
end.
