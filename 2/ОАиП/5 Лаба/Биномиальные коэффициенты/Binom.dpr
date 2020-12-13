program Binom;

{$APPTYPE CONSOLE}

procedure Factorial(var Num, FactNum: Int64; var k: Byte);
begin
  if k < Num then
    begin
      inc(k);
      FactNum:= FactNum * k;
      Factorial(Num, FactNum, k);
    end;
end;

procedure Coefficient(n,i: Integer);
var
  FactNum, Calc, Num: Int64;
  k: Byte;
  j: Integer;
begin
  FactNum:= 1;
  k:= 1;
  Calc:= 1;

  for j:= 0 to i - 1 do
    Calc:= Calc * (n - j);

  Num:= i;
  Factorial(Num, FactNum, k);
  Calc:= Calc div FactNum;
  Write(Calc,' ');

  if i < n then Coefficient(n,i + 1);
end;

var
  Coeff: Integer;
begin
  Readln(Coeff);
  if Coeff <> 0  then
    Coefficient(Coeff, 0)
  else
    Write('1');
  Readln;
end.
