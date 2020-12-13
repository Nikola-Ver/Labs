program laba_4;

{$APPTYPE CONSOLE}

const n = 10;

type TMas = array [1..n] of integer;

var i, k: integer;
  B:TMas;

begin
  i:=1;
  repeat
    readln(B[i]);
    i:=i+1;
  until (i-1=n);
  //randomize;
  //for i := 1 to n do B[i]:= random(n)-n div 2;
  for i := 1 to n do write(B[i],'  ');
  Writeln;
    k := 0;
    for i := 1 to n do
    begin
       if B[i] = 0 then inc(k)
       else B[i - k]:=B[i];
    end;
    for i:=(n-k)+1 to n do B[i]:=0;
    for i := 1 to n do write(B[i],'  ');
    readln
end.

