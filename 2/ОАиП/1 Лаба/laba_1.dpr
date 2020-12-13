program laba_1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const n = 1000;

type Spisok = record
  p1: Integer;
  p2: String[15];
  p3: Boolean
end;
  TMas = array [1..n] of Spisok;

{—Œ«ƒ¿Õ»≈ —œ»— ¿}   {Œ“À¿∆≈ÕŒ}
procedure vvod(var Arr: TMas);
 var i: Integer;
begin
  Randomize;
  for i:= 1 to n do
  begin
    Arr[i].p1:= Random(201);
    Arr[i].p2:= 'my_test_' + IntToStr(i);
    Arr[i].p3:= False
  end
end;

{—Œ–“»–Œ¬ ¿ Ã¿——»¬¿(œŒ —“–Œ ¿Ã »À» ◊»—À¿Ã)}   {Œ“À¿∆≈ÕŒ}
procedure Shell(var A: TMas; z: Integer; Flag: boolean);
 var i, step, j, temp_num:Integer;
  temp: Spisok;
  temp_word: String;
begin
  if Flag then
    begin
      step:=z div 2;
      while (step > 0) do
      begin
        for i:= step+1 to z do
        begin
          j:=i;
          temp:=A[i];
          temp_word:=A[i].p2;
          while ((j > step) and (temp_word < A[j-step].p2)) do
          begin
            A[j]:=A[j-step];
            j:=j-step;
          end;
          A[j]:=temp
        end;
        step:=step div 2
      end
    end
  else
    begin
      step:=z div 2;
      while (step > 0) do
      begin
        for i:= step+1 to z do
        begin
          j:=i;
          temp:=A[i];
          temp_num:=A[i].p1;
          while ((j > step) and (temp_num < A[j-step].p1)) do
           begin
             A[j]:=A[j-step];
             j:=j-step
           end;
          A[j]:=temp
        end;
        step:=step div 2
      end
    end
end;

{¬€¬Œƒ —Œ–“»–Œ¬¿ÕÕ€’ » Õ≈ —Œ–“»–Œ¬¿ÕÕ€’ Ã¿——»¬Œ¬ ¬ ¡ÀŒ ÕŒ“}   {Œ“À¿∆≈ÕŒ}
procedure vivod(var Arr: TMas; Flag1, Flag2: Boolean);
 var i:Integer;
  Text: TextFile;
begin
  if Flag1 then
    if Flag2 then AssignFile(Text, 'Sort Sl.txt')
    else AssignFile(Text, 'Sort Num.txt')
  else
    if Flag2 then AssignFile(Text, 'Ne Sort Sl.txt')
    else AssignFile(Text, 'Ne Sort Num.txt');
  Rewrite(Text);

  for i:=1 to n do Writeln(Text, Arr[i].p1, #32,Arr[i].p2, #32, Arr[i].p3);

  CloseFile(text)
end;

{¡ÀŒ◊Õ€… œŒ»— }   {Œ“À¿∆≈ÕŒ}
procedure Search_Block(Slovo: String; var Srv: Integer; z: Integer; var Arr: TMas; Flag_Wrod: Boolean);
 var Early, Step, Num: Integer;
  Flag: Boolean;
  Text: TextFile;
begin
  if Flag_Wrod then
    begin
      Flag:= True;
      Step:= Trunc(Sqrt(z));
      Early:= 1;

      while (( Early <= z ) and ( Flag )) do
      begin
        if Slovo = Arr[Early].p2 then
          begin
            Arr[Early].p3:= True;
            Writeln('-------------------------------------------------');
            Writeln('|Result     (Search Block)| ', Arr[Early].p1:3, #32, Arr[Early].p2:11, #32, Arr[Early].p3,'|');
            Flag:= False
          end
        else
          Arr[Early].p3:= True;

        if Early + Step > z then Step:= Trunc(Sqrt(Step));

        if Flag then
          if Slovo >= Arr[Early + Step].p2 then
            begin
              Arr[Early + Step].p3:= True;
              Early:= Early + Step
            end
          else
            begin
              Arr[Early + Step].p3:= True;
              if Step = 1 then Flag:= False;
              Step:= Trunc(Sqrt(Step))
            end
      end;
      AssignFile(Text, 'Search Block Sl.txt');
    end
  else
  if (Length(Slovo) > 0) and (TryStrToInt(Slovo, Num)) then
    begin
      Num:= StrToInt(Slovo);
      Flag:= True;
      Step:= Trunc(Sqrt(z));
      Early:= 1;

      while (( Early <= z ) and ( Flag )) do
      begin
        if Num = Arr[Early].p1 then
          begin
            Arr[Early].p3:= True;
            Writeln('------------------------------------------------');
            Writeln('Result     (Search Block)| ', Arr[Early].p1:3, #32, Arr[Early].p2:11, #32, Arr[Early].p3,'|');
            Flag:= False
          end
        else
          Arr[Early].p3:= True;

        if Early + Step > z then Step:= Trunc(Sqrt(Step));

        if Flag then
          if (Num >= Arr[Early + Step].p1) and ( Flag ) then
            begin
              Arr[Early + Step].p3:= True;
              Early:= Early + Step
            end
          else
            begin
              Arr[Early + Step].p3:= True;
              if Step = 1 then Flag:= False;
              Step:= Trunc(Sqrt(Step))
            end
      end;

      Step:= 1;
      while (( Early - Step > 0 ) and ( Num = Arr[Early - Step].p1)) do
      begin
        Arr[Early - Step].p3:= True;
        Writeln('                         | ', Arr[Early - Step].p1:3, #32, Arr[Early - Step].p2:11, #32, Arr[Early - Step].p3,'|');
        Inc(Step)
      end;

      if (( Early - Step > 0 ) and ( Num <> Arr[Early - Step].p1)) then Arr[Early - Step].p3:= True;

      Step:= 1;
      while ((Early + Step < z + 1) and ( Num = Arr[Early + Step].p1 )) do
      begin
        Arr[Early + Step].p3:= True;
        Writeln('                         | ', Arr[Early + Step].p1:3, #32, Arr[Early + Step].p2:11, #32, Arr[Early + Step].p3,'|');
        Inc(Step)
      end;

      if (( Early + Step > 0 ) and ( Num <> Arr[Early + Step].p1)) then Arr[Early + Step].p3:= True;

      AssignFile(Text, 'Search Block Num.txt')
    end;

    if (Length(Slovo) > 0) and ((TryStrToInt(Slovo, Num) or ( Flag_Wrod ))) then
      begin
        Rewrite(Text);
        for Step:=1 to z do
        begin
          if Arr[Step].p3 then Inc(Srv);
          Writeln(Text, Arr[Step].p1, #32,Arr[Step].p2, #32, Arr[Step].p3);
        end;
        CloseFile(text)
      end;
    for Step:= 1 to z do Arr[Step].p3:= False
end;

{œŒ»—  ƒ»’Œ“ŒÃ»≈…}   {Œ“À¿∆≈ÕŒ}
procedure Search_Dichotomy(Slovo: String; var Srv:Integer; z: Integer; var Arr: TMas; Flag_Wrod: Boolean);
 var Right, Left, Run, Num, Step: Integer;
  Flag, Vivod: Boolean;
  Text: TextFile;
begin
  Vivod:= False;
  Flag:= True;
  Right:= z + 1;
  Left:= 1;
  Run:= (Right + Left) div 2;
  if Flag_Wrod then
    begin
      repeat
        if (Run = z) or (Run = 1) or (Abs(Left - Right) = 1) then Flag:= False;
        if (Arr[Run].p2 = Slovo) then
          begin
            Arr[Run].p3:= True;
            Flag:= False;
            Vivod:= True;
            Writeln('|-------------------------+---------------------|');
            Writeln('|Result (Search Dichotomy)| ', Arr[Run].p1:3, #32, Arr[Run].p2:11, #32, Arr[Run].p3,'|');
            Writeln('-------------------------------------------------')
          end
        else
          Arr[Run].p3:= True;

        if Flag then
          if (Slovo < Arr[Run].p2) then
            begin
              Arr[Run].p3:= True;
              Right:= Run
            end
          else
            begin
              Arr[Run].p3:= True;
              Left:= Run
            end;
        Run:= (Right + Left) div 2;
      until ( Flag = False ) or ( Slovo = Arr[Run].p2 ) and ( Vivod );
      AssignFile(Text, 'Search Dichotomy Sl.txt')
    end
  else
    if (Length(Slovo) > 0) and (TryStrToInt(Slovo, Num)) then
      begin
        Num:= StrToInt(Slovo);
        repeat
          if (Run = z) or (Run = 1) or (Abs(Left - Right) = 1) then Flag:= False;
          if Arr[Run].p1 = Num then
            begin
              Arr[Run].p3:= True;
              Flag:= False;
              Vivod:= True;
              Writeln('-------------------------+---------------------|');
              Writeln('Result (Search Dichotomy)| ', Arr[Run].p1:3, #32, Arr[Run].p2:11, #32, Arr[Run].p3,'|');
            end
          else
            Arr[Run].p3:= True;

          if Flag then
            if (Num < Arr[Run].p1) then
              begin
                Arr[Run].p3:= True;
                Right:= Run
              end
            else
              begin
                Arr[Run].p3:= True;
                Left:= Run
              end;
          Run:= (Right + Left) div 2;
        until ( Flag = False ) or ( Num = Arr[Run].p1 ) and ( Vivod );

        Step:= 1;
        while (( Run - Step > 0 ) and ( Num = Arr[Run - Step].p1 )) do
        begin
          Arr[Run - Step].p3:= True;
          Writeln('                         | ', Arr[Run - Step].p1:3, #32, Arr[Run - Step].p2:11, #32, Arr[Run - Step].p3,'|');
          Inc(Step)
        end;

        if (( Run - Step > 0 ) and ( Num <> Arr[Run - Step].p1 )) then Arr[Run - Step].p3:= True;

        Step:= 1;
        while (( Run + Step < z + 1 ) and ( Num = Arr[Run + Step].p1 )) do
        begin
          Arr[Run + Step].p3:= True;
          Writeln('                         | ', Arr[Run + Step].p1:3, #32, Arr[Run + Step].p2:11, #32, Arr[Run + Step].p3,'|');
          Inc(Step)
        end;

        if (( Run + Step > 0 ) and ( Num <> Arr[Run + Step].p1 )) then Arr[Run + Step].p3:= True;

        if ((Num <> Arr[Run + Step].p1) and (Num = Arr[Run + Step - 1].p1)) then
          Writeln('------------------------------------------------');
        AssignFile(Text, 'Search Dichotomy Num.txt')
      end;

    if (Length(Slovo) > 0) and ((TryStrToInt(Slovo, Num) or ( Flag_Wrod ))) then
      begin
        Rewrite(Text);
        for Step:=1 to z do
        begin
          if Arr[Step].p3 then Inc(Srv);
          Writeln(Text, Arr[Step].p1, #32,Arr[Step].p2, #32, Arr[Step].p3)
        end;
        CloseFile(text)
      end;
    for Step:=1 to z do Arr[Step].p3:= False
end;

 var Mas: TMas;
  Sort, Word: Boolean;
  Slovo: String[15];
  Srav_Dichotomy, Srav_Block: Integer;
begin
  Srav_Dichotomy:=0;
  Srav_Block:=0;
  Sort:= False;
  Word:= True;

  vvod(Mas);
  vivod(Mas, Sort, Word);

  Sort:= True;
  Shell(Mas, n, Word);
  vivod(Mas, Sort, Word);

  Write('Search: ');
  Readln(Slovo);
  Search_Block(Slovo, Srav_Block, n, Mas, Word);
  Search_Dichotomy(Slovo, Srav_Dichotomy, n, Mas, Word);
  Writeln;
  Writeln('Block: ', Srav_Block,'  Dichotomy: ', Srav_Dichotomy);
  Writeln;
  Writeln;
  Writeln;

  Srav_Dichotomy:=0;
  Srav_Block:=0;
  Sort:= False;
  Word:= False;

  vivod(Mas, Sort, Word);

  Sort:= True;
  Shell(Mas, n, Word);
  vivod(Mas, Sort, Word);

  Write('Search: ');
  Readln(Slovo);
  Search_Block(Slovo, Srav_Block, n, Mas, Word);
  Search_Dichotomy(Slovo, Srav_Dichotomy, n, Mas, Word);
  Writeln;
  Writeln('Block: ', Srav_Block,'  Dichotomy: ', Srav_Dichotomy);

  Readln
end.
