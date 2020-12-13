program Lab2;

{$APPTYPE CONSOLE}

type
  TListRef = ^TList;

  TList = Record
    Name: String[30];
    Num: String[7];
    Next: TListRef;
  end;

var
  List, Head: TListRef;
  temp: String;
  num: Integer;
  First: Boolean = True;

procedure swapList(parentElem: TListRef);
var
  grandSonElem, childElem: TListRef;
begin
  childElem := parentElem^.Next;
  grandSonElem := childElem^.Next;

  parentElem^.Next := grandSonElem;
  childElem^.Next := grandSonElem^.Next;
  grandSonElem^.Next := childElem;
end;


procedure sortBubble;
var
  listLength    : Integer;
  i, j          : Integer;
  temp, predElem: TListRef;
  swapNeed      : Boolean;
begin
  listLength := 0;
  temp := Head;
  while temp <> nil do
  begin
    temp := temp^.Next;
    inc(listLength)
  end;
  dec(listLength);

  for i := 0 to listLength - 1 do
  begin
    predElem := Head;
    temp := predElem^.Next;
    for j := 0 to listLength - i - 2 do
    begin
      swapNeed := temp^.Name > predElem^.Name;

      if swapNeed then
        swapList(predElem);

      predElem := predElem^.Next;
      temp := predElem^.Next;
    end;
  end;
end;

procedure Search(i: Integer);
 var
  Name: String[30];
  Num: String[7];
  tempList: TListRef;
begin
  Writeln;
  tempList:= Head.Next;
  case i of
    1:
      begin
        Write('������� �������: ');
        Readln(Name);
        Writeln('��������� ������: ');

        repeat
          if (tempList.Name = Name) then
            Writeln(tempList.Name, ' ', tempList.Num);
          tempList:= tempList.Next
        until (tempList = Nil);
      end;
    2:
      begin
        Write('������� �����: ');
        Readln(Num);
        Writeln('��������� ������: ');

        repeat
          if (tempList.Num = Num) then
            Writeln(tempList.Name, ' ', tempList.Num);
          tempList:= tempList.Next
        until (tempList = Nil);
      end;
  end;

end;

begin
  New(Head);
  New(Head.Next);
  List:= Head.Next;
  repeat
    if not First then List:= List.Next;
    Write('>> ������� �������: ');
    Readln(List.Name);
    Write('>> ������� �����: ');
    Readln(List.Num);
    Write('>> ����� ��������� ������ �������� "stop": ');
    Readln(temp);
    First:= False;
    New(List.Next);
  until (temp = 'stop');
  List.Next:= Nil;

  sortBubble();

  Writeln;
  Writeln('>> ������: ');
  Writeln('1: �� �������');
  Writeln('2: �� ������');
  Write('>> ');

  Readln(Num);
  Search(Num);

  Readln;
end.
