unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus;

type
  TMainForm = class(TForm)
    MainOutPut: TRichEdit;
    Group: TGroupBox;
    Menu: TMainMenu;
    MyFIle: TMenuItem;
    Searching: TMenuItem;
    SearchTerm: TMenuItem;
    SearchSubTerm: TMenuItem;
    ChangeFile: TMenuItem;
    AddAnything: TMenuItem;
    AddPage: TMenuItem;
    AddTerm: TMenuItem;
    AddSubTerm: TMenuItem;
    SortAnything: TMenuItem;
    SortPage: TMenuItem;
    SortTerm: TMenuItem;
    SortSubTerm: TMenuItem;
    DeleteAnything: TMenuItem;
    DeletePage: TMenuItem;
    DeleteTerm: TMenuItem;
    DeleteSubTerm: TMenuItem;
    ListPage: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  n = 25; // ƒлина названий терминов и подтерминов

type
  TSubTermRef = ^TSubTerm;
  TTermRef = ^TTerm;
  TPageRef = ^TPage;

  TSubTerm = record
    Name: String[n];
    Ref: TSubTermRef;
  end;

  TTerm = record
    Name: String[n];
    SubTerm: TSubTermRef;
    Ref: TTermRef;
  end;

  TPage = record
    Num: Integer;
    Term: TTermRef;
    Ref: TPageRef;
  end;


var
  MainForm: TMainForm;

implementation

// Vorious
// 0 - по возрастанию термина, 1 - по убыванию термина, 2 - по возрастанию
// подтермина, 3 - по убыванию подтермина
procedure Sort(Page: TPageRef; Vorious: Integer);
var
  len, Wall, i: Integer;
  Head, PrevPage, TempPage: TPageRef;
begin
  len:= 0;
  PrevPage:= Page;
  TempPage:= Page;
  Head:= Page;
  // ќпределить длину термина - 0, 1, или подтермина - 2, 3
  case Vorious of
    0, 1:
      begin
        Head.Term:= Page.Term;
        while (Page.Term <> Nil) do
        begin
          Page.Term:= Page.Term.Ref;
          inc(len);
        end;
        Page.Term:= Head.Term;
      end;

    2, 3:
      begin
        Head.Term.SubTerm:= Page.Term.SubTerm;
        while (Page.Term.SubTerm <> Nil) do
        begin
          Page.Term.SubTerm:= Page.Term.SubTerm.Ref;
          inc(len);
        end;
        Page.Term.SubTerm:= Head.Term.SubTerm;
      end;
  end;

  for Wall := 0 to (len - 1) do
  begin
    for i := Wall to (len - 1) do
    begin
      case Vorious of
        0:
          if TempPage.Term.Name > Page.Ref.Term.Name then
            TempPage.Term:= Page.Term.Ref;
        1:
          if TempPage.Term.Name < Page.Ref.Term.Name then
            TempPage.Term:= Page.Term.Ref;
        2:
          if TempPage.Term.SubTerm.Name > Page.Ref.Term.SubTerm.Name then
            TempPage.Term.SubTerm:= Page.Term.SubTerm.Ref;
        3:
          if TempPage.Term.SubTerm.Name < Page.Ref.Term.SubTerm.Name then
            TempPage.Term.SubTerm:= Page.Term.SubTerm.Ref;
      end;
    end;

    case Vorious of
      0, 1:
        begin
          PrevPage.Term:= PrevPage.Term.Ref;
          TempPage.Term:= PrevPage.Term;
        end;
      2, 3:
        begin
          PrevPage.Term.SubTerm:= PrevPage.Term.SubTerm.Ref;
          TempPage.Term.SubTerm:= PrevPage.Term.SubTerm;
        end;
    end;
  end;

  Page.Term:= Head.Term;
  Page.Term.SubTerm:= Head.Term.SubTerm;
end;

// —оздание новой страницы с терминами и подтерминами
procedure EnterPage(Page: TPageRef);
var
  Temp: String[n];
  i: Integer;
  Head, TempPage, PrevPage, NewPage: TPageRef;
begin
  Head:= Page;
  Head.Term:= Page.Term;
  Head.Term.SubTerm:= Head.Term.SubTerm;
  TempPage:= Page;
  PrevPage:= Page;

  repeat
    Writeln('¬ведите номер страницы');
    Write('>> ');
    Readln(Temp);
  until (TryStrToInt(String(Temp), i));

  while (Page.Ref <> Nil) do
  begin
    Page:= Page.Ref;
    if i > Page.Num then
    begin
      PrevPage:= TempPage;
      TempPage:= Page;
    end;
  end;

  New(NewPage);
  NewPage.Num:= i;
  if (PrevPage = TempPage) then
    if (i > PrevPage.Num) then
      begin
        NewPage.Ref:= Nil;
        PrevPage.Ref:= NewPage;
      end
    else
      begin
        Head:= NewPage;
        Head.Ref:= PrevPage;
      end
  else
    begin
      PrevPage.Ref:= NewPage;
      NewPage.Ref:= TempPage;
    end;

  TempPage.Term:= NewPage.Term;
  repeat
    Writeln('¬ведите новый термин');
    Write('>> ');
    Readln(Temp);
    if (Temp <> '') then
    begin
      TempPage.Term.Name:= Temp;
      repeat
        Temp:= '';
        if (Temp <> '') then
        begin
          TempPage.Term.SubTerm.Name:= Temp;
          TempPage.Term.SubTerm:= TempPage.Term.SubTerm.Ref;
        end;
        Writeln('¬ведите новый подтермин');
        Write('>> ');
        Readln(Temp);
      until (Temp = '');
      TempPage.Term:= TempPage.Term.Ref;
    end;
  until (Temp = '');

  Page:= Head;
  Page.Term:= Head.Term;
  Page.Term.SubTerm:= Head.Term.SubTerm;
end;

{$R *.dfm}

end.
