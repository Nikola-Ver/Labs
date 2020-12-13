program Laba5;

{$APPTYPE CONSOLE}

const n = 2000;


type TMas = array [1..n] of Integer;


var A, B:TMas;
 i, z, s ,o :Integer;


procedure Reverse(var A:TMas; z:integer);
 var i, temp:Integer;
  begin
    for i:=1 to (z div 2) do
      begin
        temp:=A[i];
        A[i]:=A[z-i+1];
        A[z-i+1]:=temp
      end
  end;


procedure DirectSelection(var A:TMas; z:integer);
 var i, k, iMin, temp:Integer;
  begin
    for k := 1 to (z-1) do
    begin
      iMin := z;
      for i := z downto k do
      begin
        Inc(s);
        if (A[i] <= A[iMin]) then iMin := i
      end;
      if (iMin <> k) then
      begin
        temp:=A[k];
        A[k]:=A[iMin];
        A[iMin]:=temp;
        Inc(o)
      end
    end
  end;


procedure Shell(var A:TMas; z:integer);
 var i, step, j, temp:Integer;
  begin
    step:=z div 2;
    while (step > 0) do
    begin
      for i:= step+1 to z do
      begin
        j:=i;
        temp:=A[i];
        while ((j > step) and (temp < A[j-step])) do
         begin
           Inc(s);
           A[j]:=A[j-step];
           j:=j-step;
           Inc(o)
         end;
        Inc(s);
        Inc(o);
        A[j]:=temp
      end;
      step:=step div 2
    end
  end;


procedure out(z:integer);
  begin
      s:=0;
      o:=0;
      A:=B;
      Shell(A,z);
    Writeln('| ', z:6,'    |             |           |             |           |');
      Write('| unsorted  |',s:10,'   |',o:9,'  |');
      s:=0;
      o:=0;
      A:=B;
      DirectSelection(A, z);
    Writeln(' ',s:10,'  |',o:9,'  |');
    Writeln('|  items    |             |           |             |           |');
    Writeln('|-----------|-------------|-----------|-------------|-----------|');
    Writeln('| ', z:6,'    |             |           |             |           |');
      s:=0;
      o:=0;
      Shell(A,z);
     Write('|  sorted   |',s:10,'   |',o:9,'  |');
      s:=0;
      o:=0;
      DirectSelection(A, z);
    Writeln(' ',s:10,'  |',o:9,'  |');
    Writeln('|  items    |             |           |             |           |');
    Writeln('|-----------|-------------|-----------|-------------|-----------|');
      s:=0;
      o:=0;
      Reverse(A,z);
      Shell(A,z);
    Writeln('| ', z:6,'    |             |           |             |           |');
     Write('|reverse or-|',s:10,'   |',o:9,'  |');
      s:=0;
      o:=0;
      Reverse(A,z);
      DirectSelection(A, z);
    Writeln(' ',s:10,'  |',o:9,'  |');
    Writeln('| der items |             |           |             |           |');
      if z <> 2000 then Writeln('|-----------|-------------|-----------|-------------|-----------|')
        else Writeln('-----------------------------------------------------------------')
  end;

begin
  Randomize;
  for i:=1 to n do B[i]:=Random(100);
  A:=B;
    Writeln('-----------------------------------------------------------------');
    Writeln('|           |          Shell          |     Direct Selection    |');
    Writeln('|  Array    |-------------------------|-------------------------|');
    Writeln('|  type     |  Number of  | Number of |  Number of  | Number of |');
    Writeln('|           | comparisons | exchanges | comparisons | exchanges |');
    Writeln('|-----------|-------------|-----------|-------------|-----------|');

  z:=10;
  out(z);

  z:=100;
  out(z);

  z:=2000;
  out(z);

  readln
end.
