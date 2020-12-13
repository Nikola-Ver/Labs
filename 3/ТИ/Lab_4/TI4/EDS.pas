Unit EDS;

Interface

Uses
  SysUtils,
  Math;

//�������� ����� �� ��������
Function IsPrime(const num:integer):boolean;

//���������� ������� ������ ��� ����� num1*num2 (��� ��������� - ������� �����)
Function Eiler(const num1:integer; const num2:integer):integer;

//���������� ����������� ������ �������� ���� �����
Function GCD(num1,num2:integer):integer;

//������� ���������� ����� num � ������� degree �� ������ module
Function FastPowByMod(num,degree,module:integer):integer;

//����������� �������� �������
Function Euclid(const num1:integer;const num2:integer):integer;

//������������ ���-������
Function MakeHash(const fileName:string;const p:integer;const q:integer):integer;

//������������ ���
Procedure CreateEDS(const fileName:string;const h:integer;const r:integer;
                    const fi:integer;const d:integer;var e:integer;var S:integer);

//�������� ���
Procedure CheckEDS(const fileName:string;const p:integer;const q:integer;
                   const e:integer;var hash1:integer;var hash2:integer);

Implementation

//�������� ����� �� ��������
Function IsPrime(const num:integer):boolean;
var
  i:integer;
  border:integer;
  flag:boolean;
begin
  border := trunc(sqrt(num));
  flag := true;
  for i := 2 to border do
  begin
    if (num mod i = 0) then
    begin
      flag := false;
      break;
    end;
  end;
  result := flag;
end;

//���������� ������� ������ ��� ����� num1*num2 (��� ��������� - ������� �����)
Function Eiler(const num1:integer; const num2:integer):integer;
begin
  result := (num1 - 1) * (num2 - 1);
end;

//���������� ����������� ������ �������� ���� �����
Function GCD(num1,num2:integer):integer;
begin
  while num1 <> num2 do
  begin
    if num1 > num2 then
      num1 := num1 - num2
    else
      num2 := num2 - num1;
  end;
  result := num1;
end;

//������� ���������� ����� num � ������� degree �� ������ module
Function FastPowByMod(num,degree,module:integer): integer;
var
  z1,a1:integer;
  x:integer;
begin
  a1 := num;
  z1 := degree;
  x := 1;
  while (z1 <> 0) do
  begin
    while (z1 mod 2 = 0) do
    begin
      z1 := z1 div 2;
      a1 := (a1 * a1) mod module;
    end;
    z1 := z1 - 1;
    x := (x * a1) mod module;
  end;
  result := x;
end;

//����������� �������� �������
Function Euclid(const num1:integer;const num2:integer):integer;
var
  d0:integer;
  d1:integer;
  d2:integer;
  x0:integer;
  x1:integer;
  x2:integer;
  y0:integer;
  y1:integer;
  y2:integer;
  q:integer;
begin
  d0 := num1;
  d1 := num2;
  x0 := 1;
  x1 := 0;
  y0 := 0;
  y1 := 1;
  while (d1 > 1) do
  begin
    q := d0 div d1;
    d2 := d0 mod d1;
    x2 := x0 - (q * x1);
    y2 := y0 - (q * y1);
    d0 := d1;
    d1 := d2;
    x0 := x1;
    x1 := x2;
    y0 := y1;
    y1 := y2;
  end;
  if (y1 < 0) then
    y1 := y1 + num1;
  result := y1;
end;

//������������ ���-������
Function MakeHash(const fileName:string;const p:integer;const q:integer):integer;
const
  H0 = 100;
var
  OpenedFile:TextFile;
  text:string;
  temp:string;
  i:integer;
  H:integer;
  number:integer;
  module:integer;
  degree:integer;
begin
  AssignFile(OpenedFile, fileName);
  if (FileExists(fileName)) then
  begin
    Reset(OpenedFile);
    text := '';
    temp := '';
    
    while not(EOF(OpenedFile)) do
    begin
      Readln(OpenedFile, temp);
      text := text + temp;
    end;
    
    CloseFile(OpenedFile);

    H := H0;
    degree := 2;
    for i:= 1 to length(text) do
    begin
      number := H + ord(text[i]);
      module := p * q;
      H := FastPowByMod(number, degree, module);
    end;
    result := H;
  end
  else
    result := -1;
end;


//������������ ���
Procedure CreateEDS(const fileName:string;const h:integer;const r:integer;
                    const fi:integer;const d:integer;var e:integer;var S:integer);
var
  OpenedFile:TextFile;
  temp:string;
begin
  AssignFile(OpenedFile, fileName);
  if (FileExists(fileName)) then
  begin
    e := Euclid(fi, d);
    S := FastPowByMod(h, d, r);
    temp := ',' + IntToStr(S);
    Append(OpenedFile);
    Write(OpenedFile, temp);
    CloseFile(OpenedFile);
  end;
end;


//�������� ���
Procedure CheckEDS(const fileName:string;const p:integer;const q:integer;
                   const e:integer;var hash1:integer;var hash2:integer);
const
  buffer = '___.txt';
var
  OpenedFile:TextFile;
  TempFile:TextFile;
  text:string;
  temp:string;
  index:integer;
  i:integer;
  S:integer;
  r:integer;
begin
  AssignFile(OpenedFile, fileName);
  if (FileExists(fileName)) then
  begin
    Reset(OpenedFile);
    text := '';
    while not(EOF(OpenedFile)) do
    begin
      Readln(OpenedFile, temp);
      text := text + temp;
      if not(EOF(OpenedFile)) then
        text := text + #13 + #10;
    end;
    CloseFile(OpenedFile);

    //������� ����������� ������
    index := 0;
    for i := length(text) downto 1 do
    begin
      if (text[i] = ',') then
      begin
        index := i;
        break;
      end;
    end;

    //���������� hash1
    temp := Copy(text, 1, index - 1);
    AssignFile(TempFile, buffer);
    Rewrite(TempFile);
    Write(TempFile, temp);
    CloseFile(TempFile);
    hash1 := MakeHash(buffer, p, q);
    DeleteFile(buffer);

    //���������� hash2
    temp := Copy(text, index + 1, length(text) - index);
    S := StrToInt(temp);
    r := p * q;
    hash2 := FastPowByMod(S, e, r);
  end;
end;

End.
