program laba7_1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const sogl = ['B','b','C','c','D','d','F','f','G','g','H','h','J','j','K','k','L','l','M','m','N','n','P','p','Q','q','R','r','S','s','T','t','V','v','W','w','X','x','Z','z'];


var s, s0, s1, s2, temp, temp_work, last_word: string;
    i, k: integer;

begin
  {Ввод данных}
  repeat
    Readln(S);
    if Length(s) = 0 then Writeln('. . . You have not entered anything, try again . . .');
    Writeln
  until (Length(s) > 0);

  {ПРИМЕР 1}

  s:=Trim(s);
  s0:=s;
  last_word:=s;
  i:=Length(s);

  while (s[i] <> #32) and (i > 0) do Dec(i);

  Delete(last_word,1,i);
  i:=1;

  while (Length(s0) > 0) do
    begin
      temp_work:=s0;

      {Поиск пробела}
      while (s0[i] <> #32) and (s0[i] <> #0) do Inc(i);

      Delete(temp_work,i,Length(s0));
      Delete(s0,1,Length(temp_work));

      k:=1;
      i:=1;

      {Проверка на удвоенные согласные и являются ли эти буквы согласными}
      while (Length(temp_work) > k) do
        begin
          if (temp_work[k] = temp_work[k+1]) and (temp_work[k] in sogl) then
            begin
              i:=2;
              k:=Length(temp_work)
            end;
          Inc(k)
        end;

      if (temp_work <> last_word) and (i = 2)  then s1:=s1+temp_work + #32;

      s0:=Trim(s0);
      i:=1
    end;

  {ПРИМЕР 2}

  s0:=s;

  while (Length(s0) > 0) do
    begin
      temp_work:=s0;

      {Поиск пробела}
      while (s0[i] <> #32) and (s0[i] <> #0) do Inc(i);

      Delete(temp_work,i,Length(s0));
      Delete(s0,1,Length(temp_work));
      s0:=Trim(s0);

      if last_word <> temp_work then
        begin
          temp:= temp_work[Length(temp_work)];
          i:=1;

          {Удаление всех предыдущих вхождений последней буквы}
          while i <= Length(temp_work)-1 do
          begin
            if (temp = temp_work[i]) then
              begin
                Delete(temp_work,i,1);
                Dec(i)
              end;
            Inc(i)
          end
        end
      else Delete(temp_work,1,Length(temp_work));

      if Length(temp_work) > 0 then s2:=s2+temp_work+#32;
      i:=1
    end;

  if Length(s1) > 0 then Writeln('<<P.1>>: ',s1)
  else Writeln('Nothing found for <<P.1>>');

  Writeln;

  if Length(s2) > 0 then Writeln('<<P.2>>: ',s2)
  else Writeln('Nothing found for <<P.2>>');

  readln
end.
