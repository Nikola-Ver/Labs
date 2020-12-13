program Sort;

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

Procedure Qsort(var PMAS:TMAS; const LBorder,RBorder: Integer);
Procedure QuickSort(LBorder,RBorder: Integer); {рекурсивная подпрограмма-процедура}
var i,j,oporn_element,temp:Integer;
begin
  i:=LBorder;
  j:=RBorder;

  oporn_element:= PMAS[(LBorder+RBorder) div 2];

  Repeat
    Inc (s);
    while PMAS[i] < oporn_element do
    begin
      Inc (s);
      Inc (i);
    end;

    Inc (s);
    while PMAS[j] > oporn_element do
    begin
      Dec (j);
      Inc (s);
    end;
    if i <= j then
    begin
      Inc (o);
      temp:= PMAS[i];
      PMAS[i]:= PMAS[j];
      PMAS[j]:= temp;

      Inc (i);
      Dec (j);
    end;
  until i > j;

  if j > LBorder then QuickSort(LBorder,j);
  if i < RBorder then QuickSort(i,RBorder);
end;
begin
  QuickSort(LBorder,RBorder);
end;

procedure out(z:integer);
  begin
      s:=0;
      o:=0;
      A:=B;
      Qsort(A,1,z);
    Writeln('| ', z:6,'    |             |           |');
    Writeln('| unsorted  |',s:10,'   |',o:9,'  |');
    Writeln('|  items    |             |           |');
    Writeln('|-----------|-------------|-----------|');
    Writeln('| ', z:6,'    |             |           |');
      s:=0;
      o:=0;
      Qsort(A,1,z);
    Writeln('|  sorted   |',s:10,'   |',o:9,'  |');
    Writeln('|  items    |             |           |');
    Writeln('|-----------|-------------|-----------|');
      s:=0;
      o:=0;
      Reverse(A,z);
      Qsort(A,1,z);
    Writeln('| ', z:6,'    |             |           |');
    Writeln('|reverse or-|',s:10,'   |',o:9,'  |');
    Writeln('| der items |             |           |');
      if z <> 2000 then Writeln('|-----------|-------------|-----------|')
        else            Writeln('--------------------------------------')
  end;

begin
  Randomize;
  for i:=1 to n do B[i]:=Random(100);
  A:=B;
    Writeln('---------------------------------------');
    Writeln('|           |       Quick Sort        |');
    Writeln('|  Array    |-------------------------|');
    Writeln('|  type     |  Number of  | Number of |');
    Writeln('|           | comparisons | exchanges |');
    Writeln('|-----------|-------------|-----------|');

  z:=10;
  out(z);

  z:=100;
  out(z);

  z:=2000;
  out(z);

  readln
end.
