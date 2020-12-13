program Laba_1;
{$APPTYPE CONSOLE}
uses
  SysUtils;
var xn, xk, dx, e, x, y: real;
procedure Func(x: real);
begin
  if (x < e) or (pi - Abs(2-x) < e) or ((abs(x-1/3)<e) and (abs(x+1/3)>e)) then
    writeln('For x = ', x:0:4, ' the value of the function is not defined')
  else
  begin
    y:= Sqrt(pi - Abs(2-x));
    y:= Ln(y)/(3-1/x);
    y:= y*exp(ln(x)*2/3)*sin(1.4*x);
    writeln('x = ', x:0:4, '; y = ', y:0:4);
  end;
end;
begin
repeat
  writeln('Enter the initial value of x');
  readln(xn);
  writeln('Enter the final value of x');
  readln(xk);
  writeln('Enter a step');
  readln(dx);
  if ((xn>xk) and (dx >= 0))
     or
     ((xn<xk) and (dx <= 0)) then
  begin
    writeln('Incorrect data entered. Please, try again');
  end;
until ((xn<=xk) and (dx > 0))
      or
      ((xn>=xk) and (dx < 0));
x:=xn;
e:=dx/1000;
while(((x < xk + e) and (dx > 0))
       or
     ((x > xk + e) and (dx < 0))) do
begin
  Func(x);
  x:= x + dx;
end;
if((x - dx + e  < xk) and (dx > 0))
     or
  ((x - dx + e > xk) and (dx < 0)) then
begin
  Func(xk);
end;
readln;
end.

