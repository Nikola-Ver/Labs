program L24;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TMas = Array of AnsiString;

procedure SearchWord(Str: AnsiString);
var
  Current, First: TMas;
  d,i,j,LenFirst, Quan: Integer;
  Flag, Availability: Boolean;
begin
  d:= 0;
  repeat
    Flag:= True;
    i:= 1;
    while (Str[i] in ['�'..'�']) do
    begin
      if Flag then
        Inc(d);
      SetLength(First,d);
      First[d - 1]:= First[d - 1] + Str[i];
      Inc(i);
      Flag:= False;
    end;
    if ((Str[i] <> '.') and (Str[i] <> '!') and (Str[i] <> '?')) then
      begin
        Delete(Str,1,i);
        i:= 1;
      end;
  until ((Str[i] = '.') or (Str[i] = '!') or (Str[i] = '?'));

  LenFirst:= d;
  Delete(Str,1,i);
  repeat
    d:= 0;
    SetLength(Current,d);
    repeat
      Flag:= True;
      i:= 1;
      while (Str[i] in ['�'..'�']) do
      begin
        if Flag then
          Inc(d);
        SetLength(Current,d);
        Current[d - 1]:= Current[d - 1] + Str[i];
        Inc(i);
        Flag:= False;
      end;
      if ((Str[i] <> '.') and (Str[i] <> '!') and (Str[i] <> '?')) then
        begin
          Delete(Str,1,i);
          i:= 1;
        end;
    until ((Str[i] = '.') or (Str[i] = '!') or (Str[i] = '?'));
    Delete(Str,1,i);

    i:= LenFirst;
    while (i > 0) do
    begin
      Availability:= False;
      j:= 0;
      while ((j <= d - 1) and not (Availability)) do
      begin
        if (First[i - 1] = Current[j]) then
          Availability:= True;
        Inc(j);
      end;
      Dec(i);
      if not Availability then
        if LenFirst = i + 1 then
          begin
            Dec(LenFirst);
            SetLength(First,LenFirst);
          end
        else
          begin
            Dec(LenFirst);
            for Quan:= i to LenFirst - 1 do
              First[Quan]:= First[Quan + 1];
            SetLength(First,LenFirst);
          end;
    end;
  until (Length(Str) = 0);

  d:= 0;
  i:= LenFirst - 1;
  SetLength(Current,d);

  Inc(d);
  SetLength(Current,d);
  Current[d - 1]:= First[i];

  while (i >= 0) do
  begin
    Availability:= False;
    for j := 0 to d - 1 do
      if Current[j] = First[i] then
        Availability:= True;

    if not Availability then
      begin
        Inc(d);
        SetLength(Current,d);
        Current[d - 1]:= First[i];
      end;

    Dec(i);
  end;

  Flag:= True;
  Write('������ ���� �������, ���� � ������ �����������: ');
  for i:= 0 to d - 1 do
  begin
    if Flag then
      begin
        Flag:= False;
        Write('"' + Current[i] + '"');
      end
    else
      Write(', ' + '"' + Current[i] + '"');
  end;
  Write('.');
end;

var
  Text: TextFile;
  StrText, Temp: AnsiString;
begin
  Assign(Text,'Text.ReallyBestFormat');
  Reset(Text);
  while not eof(Text) do
  begin
    Readln(Text, Temp);
    StrText:= StrText + Temp;
  end;
  CloseFile(Text);

  Write('��� ������ ������ ��������� + : ');
  Readln(Temp);
  Writeln;
  if Temp = '+' then
    begin
      Writeln(StrText);
      Writeln;
    end;

  SearchWord(StrText);

  Readln;
end.
