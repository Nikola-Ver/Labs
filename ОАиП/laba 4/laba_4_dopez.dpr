program laba_4_dopez;

{$APPTYPE CONSOLE}

const n = 15;

type TMas = array [1..n] of integer;

var B:TMas;
 i, k:Integer;

procedure swap(var a,b:integer);
 var temp:integer;
  begin
    temp:=a;
    a:=b;
    b:=temp;
  end;

begin
  k:=0;
  randomize;
  for i:=1 to n do B[i]:=random(101) - 50;
 // for i := 1 to n do readln(B[i]);
  writeln;

  for i := 1 to n do write(B[i],' ');
  writeln;

  for i := 1 to n do if B[i]<0 then k:= k + 1;

    for k:=k downto 1 do
        for i:=1 to (n-1) do if B[i]<0 then swap(B[i], B[i+1]);

  for i := 1 to n do write(B[i],' ');

  readln;
end.
