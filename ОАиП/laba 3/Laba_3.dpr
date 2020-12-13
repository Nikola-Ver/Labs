program Laba_3;
{$APPTYPE CONSOLE}

var x: array [1..20, 1..4] of Real;
     N: array [1..20, 2..4] of Integer;
   xn, dx, zn, E, tsum, psum:Real;
   H, k, i, o:Integer;
begin
 H:=20;
 xn:=-0.6;
 dx:=0.05;
 o:=1;
 E:=0.1;

 for i:=1 to H do
  begin
     x[i,1]:=xn*(11*xn*xn-15*xn+6);
     x[i,1]:=x[i,1]+6*(1-xn)*(1-xn)*(1-xn)*ln(1-xn);
     x[i,1]:=x[i,1]/36;
     xn:=xn+dx;
  end;

while (o <> 4) do
 begin
    o:=o+1;
    E:=E/10;
    xn:=-0.6;
     for  i:=1 to H do
      begin
         k:=1;
         tsum:=xn*xn*xn;
         zn:=1;
           repeat
              tsum:=tsum*zn;
              psum:=tsum;
              zn:=k*(k+1)*(k+2)*(k+3);
              tsum:=tsum*xn;
              tsum:=tsum/zn;
              x[i,o]:=x[i,o]+tsum;
              N[i,o]:=N[i,o]+1;
              k:=k+1;
           until Abs(Abs(tsum)-Abs(psum)) < E;
       xn:=xn+dx;
      end;
 end;

    write('-----------------------------------------------------------------------');
    writeln;
    write('|    x    |   f1(x)     |     E=0.01   |     E=0.001  |    E=0.0001   |');
    Writeln;
    write('|         |             |--------------|--------------|---------------|');
    writeln;
    write('|         |             |   f2(x)  | N |  f2 (x)  | N |    f2(x)  | N |');
    writeln;
    write('|---------|-------------|----------|---|----------|---|-----------|---|');
    Writeln;

 xn:=-0.6;
 for i:=1 to H do
  begin
    write('|  ',xn:5:2,'  |');
    write('  ',x[i,1]:10:8,' |');
    write(x[i,2]:10:8,'|',N[i,2]:2,' |');
    write(x[i,3]:10:8,'|',N[i,3]:2,' |');
    write(x[i,4]:10:8,' |',N[i,4]:2,' |');
    Writeln;
    if (i < 20) then
    begin
      write('|---------|-------------|----------|---|----------|---|-----------|---|');
      writeln;
    end
    else
    begin
      write('-----------------------------------------------------------------------');
    end;
   xn:=xn+dx;
  end;
 readln;
end.
