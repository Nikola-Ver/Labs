program L17;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

const
  Sogl = ['б', 'в', 'г', 'д', 'ж', 'з', 'й', 'к', 'л', 'м', 'н', 'п', 'р', 'с', 'т', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'Ѕ', '¬', '√', 'ƒ', '∆', '«', '…', ' ', 'Ћ', 'ћ', 'Ќ', 'ѕ', '–', '—', '“', '‘', '’', '÷', '„', 'Ў', 'ў'];

type
  TSet = Set of AnsiChar;

var
  Stroka,SoglStr: AnsiString;
  M: TSet;
  i: Integer;
  Flag: Boolean = True;

begin
//  Write('¬ведите слова: ');
//  Readln(Stroka);
//  Writeln;
  Stroka:= 'кот,слон,бутылка,лампа,стол,ноутбук,цветок,аппроксимаци€.';
  SoglStr:= 'Ѕб¬в√гƒд∆ж«з…й кЋлћмЌнѕп–р—с“т‘ф’х÷ц„чЎшўщ';
  M:= [];

  for i := 1 to Length(Stroka) do
    if Stroka[i] in Sogl then
        Include(M,Stroka[i]);

  Write('—огласные буквы в словах: {');
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

  Writeln('»сходна€ последовательность: ',Stroka);

  Readln;
end.
