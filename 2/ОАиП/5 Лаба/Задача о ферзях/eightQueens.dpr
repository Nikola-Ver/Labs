﻿program eightQueens;

{$APPTYPE CONSOLE}

const
  boardSize = 8;

type
  TBoard = array [1 .. boardSize] of integer;

var
  Count: integer;

function isQueenReasonable(var board: TBoard; currentQueen, y: integer): Boolean;
var
    i: integer;
begin
  i := 1;
  while (i < currentQueen) and (y <> board[i]) and
    (currentQueen - i <> abs(y - board[i])) do // Тангенс должен быть разным
    inc(i);
  if i = currentQueen then
    result:= True
  else
    result:= False;
end;

procedure writeBoard(var board: TBoard);
var
    i, j: Integer;
    f   : textfile;
begin
  Assign(f, 'queens.txt');
  Append(f);
  writeln(f,Count:2);
  for i := 1 to boardSize do
    begin
      for j := 1 to boardSize do
        begin
          if (board[i] = j) then
            write(f, 'x':5)
          else
            write(f, '0':5)
        end;
      writeln(f);
    end;
  writeln(f);
  CloseFile(f);
end;

procedure Backtracking(currentQueen: integer; board: TBoard);
var
  y: integer;
begin
  for y := 1 to boardSize do
    if isQueenReasonable(board, currentQueen, y) then
      begin
        board[currentQueen] := y;
        if currentQueen = boardSize then
          begin
            writeBoard(board);
            inc(Count);
          end;
        Backtracking(currentQueen + 1, board);
      end;
end;

var
  board: TBoard;

begin
    Count := 1;
    writeln('Расстановки ', boardSize + 1, ' ферзей:');
    Backtracking(1, board);
    Dec(Count);
    writeln('Всего ', Count, ' расстановок');
    readln;
end.
