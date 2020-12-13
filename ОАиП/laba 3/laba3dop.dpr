program laba3dop;

{$APPTYPE CONSOLE}

 var x, u, s, c, tsum, psum, e, zn, ch, h, sum1, sum2, f:real;
   n, z:Integer;

begin
  repeat
    Write('Enter value for function: ');
    Readln(u);
    if (u = 0) then Writeln('An error occurred while typing, please try again ...');
    Writeln;
  until (u<>0);

  x:=u*u*pi/2;
  z:=trunc(x/pi);
  n:=z mod 2;
  if (n=1) then z:=z-1;
  x:=x-z*pi;

  e:=0.00001;
  zn:=1;
  h:=0.5;
  ch:=x;
  n:=1;

  if (u < 0) then h:=(-1)*h;

  repeat
    psum:=tsum;
    tsum:=ch/zn;
    ch:=(-1)*ch*x*x;
    zn:=zn*(n+1)*(n+2);
    n:=n+2;
    s:=s+tsum;
  until (Abs(Abs(psum)-Abs(tsum))<e);

  psum:=0;
  tsum:=0;
  zn:=1;
  n:=0;
  ch:=1;

  repeat
    psum:=tsum;
    tsum:=ch/zn;
    ch:=(-1)*ch*x*x;
    zn:=zn*(n+1)*(n+2);
    n:=n+2;
    c:=c+tsum;
  until (Abs(Abs(psum)-Abs(tsum))<e);

  x:=u*u*pi/2;
  psum:=0;
  tsum:=0;
  ch:=1;
  zn:=1;
  n:=0;

  repeat
    psum:=tsum;
    tsum:=ch/zn;
    ch:=(-1)*ch*(n+1)*(n+3);
    zn:=zn*x*x*4;
    n:=n+4;
    sum1:=sum1+tsum;
  until (Abs(Abs(psum)-Abs(tsum))<e);

  psum:=0;
  tsum:=0;
  ch:=1;
  zn:=2*x;
  n:=1;

  repeat
    psum:=tsum;
    tsum:=ch/zn;
    ch:=(-1)*ch*(n+2)*(n+4);
    zn:=zn*x*x*4;
    n:=n+4;
    sum2:=sum2+tsum;
  until (Abs(Abs(psum)-Abs(tsum))<e);

  f:=h-1/(Exp(ln(2*Pi*x)*0.5))*(c*sum1+s*sum2);

  Writeln('Function value: ',f);

 readln;
end.
