unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Grids, Queue, Vcl.Menus, Vcl.ExtCtrls;

const
   MaxTime = 10;
   MinTime = 0;
   NumConst = ['0'..'9'];

type
  strtemp = String[15];
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    EditBox: TGroupBox;
    Button1: TButton;
    ImageList: TImageList;
    sgResults: TStringGrid;
    sgProcessorStand: TStringGrid;
    Label7: TLabel;
    Label8: TLabel;
    sgShowTacts: TStringGrid;
    Menu: TMainMenu;
    N1: TMenuItem;
    MenuRun: TMenuItem;
    MenuClose: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    N2: TMenuItem;
    Num1: TMenuItem;
    Num2: TMenuItem;
    Num3: TMenuItem;
    Num4: TMenuItem;
    Num5: TMenuItem;
    Num6: TMenuItem;
    Num7: TMenuItem;
    Num8: TMenuItem;
    Num9: TMenuItem;
    Num10: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure MenuRunClick(Sender: TObject);
    procedure MenuCloseClick(Sender: TObject);
    procedure Num10Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowTacts;
    procedure DrawGraphics;
    { Public declarations }
  end;

var
  Form1: TForm1;
  Tacts: TTacts;
  Processes: TProcesses;
  PrevSender: TObject = NIL;
  iG: Integer = 0;

implementation

{$R *.dfm}

procedure TForm1.DrawGraphics();
var
  i : Integer;
begin
//  Image1.Canvas.MoveTo(0,Image1.ClientHeight);
//  Image1.Canvas.Pen.Color := clRed;
//  for i := 0 to 9 do
//    Image1.Canvas.LineTo( Image1.ClientHeight - Image1.ClientHeight * (StrToInt(sgResults.Cells[iG, i]) div 100),i * Image1.ClientWidth div 10);

end;

procedure TForm1.MenuRunClick(Sender: TObject);
begin
  Button1Click(Sender);
end;

procedure TForm1.Num10Click(Sender: TObject);
begin
  Form1.Height := 685;
  (Sender as TMenuItem).ImageIndex := 1;
  if PrevSender <> NIL then (PrevSender as TMenuItem).ImageIndex := -1;
  PrevSender := Sender;
end;

procedure TForm1.MenuCloseClick(Sender: TObject);
begin
  Form1.Close();
end;

procedure TForm1.ShowTacts;
var
   i, j, k: Integer;
   SgI, SgJ: Integer;
begin
   SgI := 0;
   sgShowTacts.ColCount := Length(Tacts) * (Length(Tacts[0][0]) + 1);
   sgShowTacts.RowCount := Length(Tacts[0]);
   for i := 0 to High(Tacts[0]) do
   begin
      SgJ := 0;
      for k := 0 to High(Tacts) do
      begin
         for j := 0 to High(Tacts[k][i]) do
         begin
            sgShowTacts.Cells[SgJ, SgI] := Tacts[k][i][j];
            Inc(SgJ);
         end;
         sgShowTacts.Cells[SgJ, SgI] :='|';//('|');
         Inc(SgJ);
      end;
      Inc(SgI);
   end;
end;

procedure WriteToFile();
var
  F: TextFile;
  i, Count, posArr: Integer;
  str: String;
  temp: strtemp;
  Arr: array of strtemp;
begin
  Count := 1;
  AssignFile(F,'input.txt');
  ReWrite(F);
  Writeln(F, '3');
  Writeln(F, '3');
  posArr := 0;
  str := Form1.Edit1.Text;
  for i := 1 to Length(str) do
    if str[i] = ',' then Inc(Count);
  Writeln(F, IntToStr(Count));
  SetLength(Arr, Count);
  temp := '';
  for i := 1 to Length(str) do
    if str[i] in NumConst then temp := temp + str[i]
    else
    if (str[i] = ',') or (i = Length(str)) then
    begin
      Arr[posArr] := temp + ' ';
      Inc(posArr);
      temp := '';
    end;
    Arr[posArr] := temp;
  for i := 0 to Count - 1 do Write(F, Arr[i]);
  Writeln(F);

  Count := 1;
  posArr := 0;
  str := Form1.Edit2.Text;
  for i := 1 to Length(str) do
    if str[i] = ',' then Inc(Count);
  Writeln(F, IntToStr(Count));
  SetLength(Arr, Count);
  temp := '';
  for i := 1 to Length(str) do
    if str[i] in NumConst then temp := temp + str[i]
    else
    if (str[i] = ',') or (i = Length(str)) then
    begin
      Arr[posArr] := temp + ' ';
      Inc(posArr);
      temp := '';
    end;
    Arr[posArr] := temp;
  for i := 0 to Count - 1 do Write(F, Arr[i]);
  Writeln(F);


  Count := 1;
  posArr := 0;
  str := Form1.Edit3.Text;
  for i := 1 to Length(str) do
    if str[i] = ',' then Inc(Count);
  Writeln(F, IntToStr(Count));
  SetLength(Arr, Count);
  temp := '';
  for i := 1 to Length(str) do
    if str[i] in NumConst then temp := temp + str[i]
    else
    if (str[i] = ',') or (i = Length(str)) then
    begin
      Arr[posArr] := temp + ' ';
      Inc(posArr);
      temp := '';
    end;
    Arr[posArr] := temp;
  for i := 0 to Count - 1 do Write(F, Arr[i]);
  Writeln(F);
  Writeln(F, '1');

  Count := 1;
  posArr := 0;
  str := Form1.Edit4.Text;
  for i := 1 to Length(str) do
    if str[i] = ',' then Inc(Count);
  Writeln(F, IntToStr(Count));
  SetLength(Arr, Count);
  temp := '';
  for i := 1 to Length(str) do
    if str[i] in NumConst then temp := temp + str[i]
    else
    if (str[i] = ',') or (i = Length(str)) then
    begin
      Arr[posArr] := temp + ' ';
      Inc(posArr);
      temp := '';
    end;
    Arr[posArr] := temp;
  for i := 0 to Count - 1 do Write(F, Arr[i]);
  Writeln(F);
  Writeln(F, '2');

  Count := 1;
  posArr := 0;
  str := Form1.Edit5.Text;
  for i := 1 to Length(str) do
    if str[i] = ',' then Inc(Count);
  Writeln(F, IntToStr(Count));
  SetLength(Arr, Count);
  temp := '';
  for i := 1 to Length(str) do
    if str[i] in NumConst then temp := temp + str[i]
    else
    if (str[i] = ',') or (i = Length(str)) then
    begin
      Arr[posArr] := temp + ' ';
      Inc(posArr);
      temp := '';
    end;
    Arr[posArr] := temp;
  for i := 0 to Count - 1 do Write(F, Arr[i]);
  Writeln(F);

  Count := 1;
  posArr := 0;
  str := Form1.Edit6.Text;
  for i := 1 to Length(str) do
    if str[i] = ',' then Inc(Count);
  Writeln(F, IntToStr(Count));
  SetLength(Arr, Count);
  temp := '';
  for i := 1 to Length(str) do
    if str[i] in NumConst then temp := temp + str[i]
    else
    if (str[i] = ',') or (i = Length(str)) then
    begin
      Arr[posArr] := temp + ' ';
      Inc(posArr);
      temp := '';
    end;
    Arr[posArr] := temp;
  for i := 0 to Count - 1 do Write(F, Arr[i]);
  Writeln(F);
  CloseFile(F);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   TactNum: Integer;
   i, j, TotalTime: Integer;
   Efficiency: Real;
begin
   WriteToFile();
   Queue.FileName := 'input.txt';
   FillProcesses(Processes);
   if Length(Processes) > 0 then
   begin
      for i := 0 to 9 do
         for j := 0 to 10 do
         begin
            Queue.tmTact := i + 1;
            Queue.tmWrite := j + 1;
            FillProcesses(Processes);
            TactNum := BetterFillTacts(Processes, Tacts);
            Efficiency := Trunc(Queue.GetTotalTime(Processes)
               / (TactNum * Queue.tmTact) * 100);
            if not ((j = 0) and (i = 0)) then
              begin
                sgResults.Cells[j, i] := FloatToSTr(Efficiency);
                TotalTime := Queue.GetTotalTime(Processes);
                sgProcessorStand.Cells[j, i] := IntToStr(Queue.tmTact *
                   TactNum - TotalTime);
              end
            else
              begin
                sgResults.Cells[j, i] := '100';
                sgProcessorStand.Cells[j, i] := '0';
              end;
         end;
      ShowTacts();
   end;
   DrawGraphics();
end;

end.
