program L17;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

const
  Sogl = ['�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�'];

type
  TSet = Set of AnsiChar;

var
  Stroka,SoglStr: AnsiString;
  M: TSet;
  i: Integer;
  Flag: Boolean = True;

begin
//  Write('������� �����: ');
//  Readln(Stroka);
//  Writeln;
  Stroka:= '���,����,�������,�����,����,�������,������,�������������.';
  SoglStr:= '������������������������������������������';
  M:= [];

  for i := 1 to Length(Stroka) do
    if Stroka[i] in Sogl then
        Include(M,Stroka[i]);

  Write('��������� ����� � ������: {');
  for i := 1 to 42 do
    begin
      if SoglStr[i] in M then
        if Flag then
          begin
            Write(SoglStr[i]);
            Flag:= False;
          end
        else
          Write(',' + SoglStr[i]);
    end;
  Writeln('}');
  Writeln;

  Writeln('�������� ������������������: ',Stroka);

  Readln;
end.
