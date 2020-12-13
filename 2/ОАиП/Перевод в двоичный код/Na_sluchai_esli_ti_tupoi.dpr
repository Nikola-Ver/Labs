program Na_sluchai_esli_ti_tupoi;
{$APPTYPE CONSOLE}
 var  v,d:Real;
  a, i, c, z:Integer;
 b: array [1..1000] of Integer;
 s, y:string;
 procedure dark(y:string);
begin
  i:=1;
  Write('Enter value (10 -> 2): ');
  readln(s);
  Val(s,v,c);
 if (Abs(v-trunc(v))<0.0000000001) then
 else
 begin
  Write('Enter the number of decimal places: ');
  readln(z);
 end;
if v < 0 then Writeln('Poshel nahui))')
else begin
  a:=Trunc(v);
  d:=v;
  v:=v-trunc(v);
 if c = 1 then Write('I dover9y ludishkam posle takogo...')
 else begin
  while (a > 1) do
  begin
    b[i]:=a mod 2;
    a:=a div 2;
    i:=i+1
  end;
  if d < 1 then write('0')
  else
 begin
  if b[i] = 0 then b[i]:=1;
  write('In 2 systems: ');
  while (i>0) do
  begin
    write(b[i]);
    i:=i-1;
  end;
 end;
  if (abs(d-trunc(d))<0.00000000000001) then
  else begin
     write('.');
     for i:=1 to z do
     begin
      v:=v*2;
      c:=Trunc(v);
      if c = 1 then v:=v-1;
      write(c);
     end;
   end;
 end;
end;
writeln;
end;
begin
 repeat
   dark(y);
   Readln(y);
 until (y = 'stop');
end.
