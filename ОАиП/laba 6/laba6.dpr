program laba6;

{$APPTYPE CONSOLE}

const n = 5;

type TMas = array [1..n, 1..n] of Integer;

var Mas: TMas; //= ((1,1,1,0,0),(1,1,1,0,0),(0,0,1,1,1),(0,0,1,1,1),(0,0,1,1,1));
  i, j, k, size, d, h, p:Integer;

begin
  {Randomize;
  for i:=1 to n do
    for j:=1 to n do Mas[i,j]:=Random(2);
    
  for i:=1 to n do
  begin
    for j:=1 to n do write(Mas[i,j]:2);
    Writeln;
  end;
  Writeln;}

  { Ввод данных }
  for i:=1 to n do
    for j:=1 to n do Read(Mas[i,j]);
  Readln;
  Writeln;

  Writeln('Squares filled 1');
  Writeln('----------------');

  { Подсчет и вывод количества квадратов 2x2, 3x3, kxk заполненных 1 }
  for size:=2 to n do // Поиск квадратов (квадрат не может быть больше самой матрицы)
  begin
    k:=0;
    for h:=1 to (n-size+1) do // Смещение по столбцам матрицы
      for d:=1 to (n-size+1) do // Смещение по строкам матрицы
      begin
        p:=0;
        for j:=d to (size+d-1) do
          for i:=h to (size+h-1) do
            if (1 = Mas[i,j]) then Inc(p);
        if (p = Sqr(size)) then Inc(k)
      end;
    if k<>0 then
        Writeln(Size,'x',size,' - ',k)
  end;

  Writeln;
  Writeln;
  Writeln('Squares filled 0');
  Writeln('----------------');                    

  { Подсчет и вывод количества квадратов 2x2, 3x3, kxk заполненных 0 }
  for size:=2 to n do // Поиск квадратов (квадрат не может быть больше самой матрицы)
  begin
    k:=0;
    for h:=1 to (n-size+1) do // Смещение по столбцам матрицы
      for d:=1 to (n-size +1) do // Смещение по строкам матрицы
      begin
        p:=0;
        for j:=d to (size+d-1) do
          for i:=h to (size+h-1) do
            if (0 = Mas[i,j]) then Inc(p);
        if (p = Sqr(size)) then Inc(k)
      end;
    if k<>0 then
        Writeln(Size,'x',size,' - ',k)
  end;

 readln
end.
