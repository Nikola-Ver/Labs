program World_Of_Warships;

{$APPTYPE CONSOLE}

uses
  Windows;

const n = 12;


type TVvod = array [1..n] of string[n];
     TDop = array [1..n, 1..n] of integer;

var Pl_1_B, Pl_2_B: TVvod;
  x, y, s, d, Pop1, Pop1_P, Pop2, Pop2_P: Integer;
  Move:string[3];
  Matrix_Dop1, Matrix_Dop2: TDop;
  Max_Players: Char;


procedure Vvod(var Pl_1_B, Pl_2_B: TVvod);
 var Text1, Text2: textfile;
  j:integer;
begin
  AssignFile(Text1,'Text1.txt');
  AssignFile(Text2,'Text2.txt');
  Reset(Text1);
  Reset(Text2);

  for j:=1 to n do Readln(Text1, Pl_1_B[j]);
  for j:=1 to n do Readln(Text2, Pl_2_B[j]);

  CloseFile(Text1);
  CloseFile(Text2)
end;


procedure Move1(Move: string);
 var Error:integer;
begin
  case Move[1] of
    'A': x:=3;
    'B': x:=4;
    'C': x:=5;
    'D': x:=6;
    'E': x:=7;
    'F': x:=8;
    'G': x:=9;
    'H': x:=10;
    'I': x:=11;
    'J': x:=12;
    'a': x:=3;
    'b': x:=4;
    'c': x:=5;
    'd': x:=6;
    'e': x:=7;
    'f': x:=8;
    'g': x:=9;
    'h': x:=10;
    'i': x:=11;
    'j': x:=12
  end;

  Delete(Move,1,1);
  Val(Move, y, Error);
  case y of
    1: y:=3;
    2: y:=4;
    3: y:=5;
    4: y:=6;
    5: y:=7;
    6: y:=8;
    7: y:=9;
    8: y:=10;
    9: y:=11;
    10: y:=12
  end
end;



procedure clrscr;
 var hStdOut: HWND;
  ScreenBufInfo: TConsoleScreenBufferInfo;
  Coord1: TCoord;
  z: Integer;
begin
  hStdOut := GetStdHandle(STD_OUTPUT_HANDLE);
  GetConsoleScreenBufferInfo(hStdOut, ScreenBufInfo);
  for z := 1 to ScreenBufInfo.dwSize.Y do WriteLn;
  Coord1.X := 0;
  Coord1.Y := 0;
  SetConsoleCursorPosition(hStdOut, Coord1)
end;


procedure indexation(matrix:TVvod; var matrix_dop:Tdop);
 var b,dir,k,l,p,o:integer;
  stop:boolean;
begin
  b:=0;
  while (b < 10) do
  begin
    stop:=false;
    k:=3;
    l:=3;
    dir:=0;
    while (k<=n) and (stop=false) do
    begin
      l:=3;
      while (l<=n) and (stop=false) do
      begin
        if (matrix[k][l] = 'B' ) and (matrix_dop[k][l]=0)  then
            begin
              stop:=true;
              b:=b+1;
              matrix_dop[k][l]:=b;
              l:=l-1;
              k:=k-1
            end;
        l:=l+1
      end;
      k:=k+1
    end;

    if (matrix[k+1][l] = 'B') and (k+1<=n) then dir:=1;
    if (matrix[k][l+1] = 'B') and (l+1<=n) then dir:=2;

    p:=k;
    o:=l;
    while (matrix[p][o] = 'B') and (p<=n) and (o<=n) and (dir <> 0) do
    begin
      if dir=1 then
        begin
          matrix_dop[p][o]:=b;
          p:=p+1
        end;
      if dir=2 then
        begin
          matrix_dop[p][o]:=b;
          o:=o+1
        end
    end
  end
end;


procedure vystrel(var Mas:TVvod; x, y:integer);
 var i,j: integer;
begin
      for i:=3 to n do
          for j:=3 to n do
              if (x=i)and(y=j) then
                  if Mas[i][j] = 'S' then Mas[i][j]:='M'
                  else if Mas[i][j]='B' then Mas[i][j]:='D'
end;


procedure death(var Mas:TVvod; var Index:TDop);
 var id,i,j:integer;
 flag:Boolean;
begin
  for id:=1 to 10 do
      begin
        flag:=TRUE;
        for i:=3 to n do
            for j:=3 to n do
                if (Index[i][j]=id)and(Mas[i][j]<>'D') then Flag:=FALSE;
        if flag then
            for i:=3 to n do
                for j:=3 to n  do
                    if (Index[i][j]=id) then Mas[i][j]:='K'
      end
end;


function amount_of_ships(matrix:TVvod;matrix_dop:TDop):integer;
var i,j,k,res:integer;
ucten:boolean;
begin
  res:=10;
  for i:=1 to 10 do
  begin
    ucten:=false;
    for j:=3 to n do
    begin
      for k:=3 to n do
      begin
        if (matrix[j][k]='K') and (matrix_dop[j][k]=i) and (ucten=false) then
          begin
            res:=res-1;
            ucten:=true
          end
      end
    end
  end;
  result:=res
end;


procedure Translate(Mas:TVvod);
 var i, j:integer;
begin
  for i:=3 to n do
    for j:=3 to n do
      if Mas[i, j] = 'B' then Mas[i, j]:='S';
  for i:=1 to n-1 do
        begin
          for j:=1 to n do Write(Mas[i, j]:3);
          writeln;
        end;
      Write(Mas[n,1]:2);
      Write(Mas[n,2],'   ');
      for j:=3 to n do Write(Mas[n,j]:3);
      Writeln;
      Writeln

end;


procedure Popados(Mas: TVvod; var Pop: Integer);
 var i, j:Integer;
begin
  Pop:=0;
  for i:=3 to n do
    for j:=3 to n do
      if (Mas[i, j] = 'D') or (Mas[i, j] = 'K') then Pop:=Pop+1
end;


begin
  Writeln('Are you going to play together? (+ or -)');
  Readln(Max_Players);
  Vvod(Pl_1_B, Pl_2_B);

  indexation(Pl_1_B, Matrix_Dop1);
  indexation(Pl_2_B, Matrix_Dop2);
  Pop1:=0;
  Pop2:=0;
  if (Max_Players = '+') then
    begin
      repeat
        repeat
          Writeln('     Enemy Fleet (Player 2)');
          Writeln;
          Translate(Pl_2_B);
          Writeln;
          Pop1_P:=Pop1;
          Writeln('     My Fleet (Player 1)');
          Writeln;
          for s:=1 to n-1 do
            begin
              for d:=1 to n do Write(Pl_1_B[s, d]:3);
              writeln
            end;
          Write(Pl_1_B[n,1]:2);
          Write(Pl_1_b[n,2],'   ');
          for d:=3 to n do Write(Pl_1_B[n,d]:3);
          Writeln;
          Writeln;
          Write('Enter the step: ');
          Readln(Move);
          Writeln;
          Move1(Move);
          Vystrel(Pl_2_B, y, x);
          Death(Pl_2_B, Matrix_Dop2);
          Popados(Pl_2_B, Pop1);
          if amount_of_ships(Pl_2_B, Matrix_dop2) = 0 then Pop1_P:= Pop1
        until (Pop1 = Pop1_P);
        clrscr;

        begin
          if amount_of_ships(Pl_2_B, Matrix_dop2) <> 0 then
          begin
            repeat
              Writeln('     Enemy Fleet (Player 1)');
              Writeln;
              Translate(Pl_1_B);
              Writeln;
              Pop2_P:=Pop2;
              Writeln('     My Fleet (Player 2)');
              Writeln;
              for s:=1 to n-1 do
              begin
                for d:=1 to n do Write(Pl_2_B[s, d]:3);
                writeln
              end;
              Write(Pl_2_B[n,1]:2);
              Write(Pl_2_b[n,2],'   ');
              for d:=3 to n do Write(Pl_2_B[n,d]:3);
              Writeln;
              Writeln;
              Write('Enter the step: ');
              Readln(Move);
              Writeln;
              Move1(Move);
              Vystrel(Pl_1_B, y, x);
              Death(Pl_1_B, Matrix_Dop2);
              Popados(Pl_1_B, Pop2);
              if amount_of_ships(Pl_1_B, Matrix_dop1) = 0 then Pop2_P:= Pop2
            until (Pop2 = Pop2_P);
              clrscr;
            end
          end
      until (amount_of_ships(Pl_1_B, Matrix_dop1) = 0) or ((amount_of_ships(Pl_2_B, Matrix_Dop2)) = 0);
    end
  else
    begin

    end;

  if amount_of_ships(Pl_1_B, Matrix_dop1) = 0 then Writeln('Player 2 WINNER!')
  else Writeln('Player 1 WINNER!');

  readln
end.

