program laba_4_dop;

{$APPTYPE CONSOLE}

const n = 20;

type TMas = array [1..n] of integer;

var B:TMas;
i, k, quantity, temp:Integer;

procedure swap(var i:integer);
begin
  temp:=B[i];
  B[i]:=B[i+1];
  B[i+1]:=temp;
end;


begin
  quantity:=0;
  //randomize;
  //for i:=1 to n do B[i]:=random(n) - n div 2;
  for i := 1 to n do readln(B[i]);
  writeln;

  for i := 1 to n do write(B[i],' ');
  writeln;

  for i := 1 to n do if B[i]<0 then quantity:= quantity + 1;
  quantity:= n - quantity + 1;

  k:=n;
  repeat
    i:=1;

    if B[k]<0 then k:=k-1;
    repeat
      if B[i]<0 then swap(i);
      i:=i+1
    until (i=n);

  until (quantity = k);

  for i := 1 to n do write(B[i],' ');

  readln;
end.
