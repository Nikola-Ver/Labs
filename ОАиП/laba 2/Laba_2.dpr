program Laba_2;
{$APPTYPE CONSOLE}
var xn, f, Sum: Real;
     n,k:Integer;
begin
 xn:=0.6;
  while (Abs(1.35-xn)>0.001) do
  begin
   Sum:=0;
   n:=10;
   k:=1;
   while (n < 16) do
   begin
    while (k <> n) do
      begin
       f:=Exp(Ln(xn)*1/3)/xn;
       f:=f - Exp((-1)*(k*xn));
       f:=f*sin(xn+k);
       k:=k+1;
       Sum:=Sum + f
      end;
    f:=Sqr(xn) + Sqrt(xn);
    f:=1/f;
    Sum:=f+Sum;
    Writeln('n = ',n,' x = ',xn:0:4,' f = ', Sum:0:4);
    n:=n+1
    end;
    Writeln;
    xn:=xn+0.25
  end;
 readln;
end.
