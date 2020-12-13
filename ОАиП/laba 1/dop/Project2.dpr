program Project2;

{$APPTYPE CONSOLE}

uses
SysUtils;

var s:string;
a, xk, x, xp, N:Integer;

procedure Func(x:Integer);

begin
 Str(x, s);
 s:=s[Length(s)] + s;
 Delete(s,Length(s),1);
 Val(s,xk,a);
 if ((N = xk div x) and (0 = xk mod x)) then
  begin
   Writeln('Initial value: ',x,';',' Final value: ',xk,';',' N = ',N);
  end;
end;

begin
 repeat
  writeln('Enter the final value of ');
  readln(xp);
  writeln('Enter N');
  readln(N);
  if ((xp<10) or (N<1)) then
   begin
    Writeln;
    Writeln('Incorrect data entered. Please, try again');
    Writeln;
   end;
 until ((xp > 10) and (N >= 1));

 x:=10;

 while(x <= xp) do
  begin
   Func(x);
   x:= x + 1;
  end;

readln;

end.
