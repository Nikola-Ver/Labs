﻿Unit Main;

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EDS, Vcl.Menus, Vcl.ExtCtrls, Vcl.Imaging.GIFImg;

Type
  TfmMain = class(TForm)
    edNumP: TEdit;
    lbNumP: TLabel;
    mmText: TMemo;
    edNumQ: TEdit;
    lbNumQ: TLabel;
    edNumD: TEdit;
    lbNumD: TLabel;
    edNumE: TEdit;
    lbNumE: TLabel;
    lbHash: TLabel;
    edEDS: TEdit;
    lbEDS: TLabel;
    edHash: TEdit;
    odOpenFile: TOpenDialog;
    edFileName: TEdit;
    MainMenu: TMainMenu;
    OpenFile: TMenuItem;
    N2: TMenuItem;
    Hash: TMenuItem;
    N4: TMenuItem;
    MakeEDS: TMenuItem;
    N6: TMenuItem;
    bCheckEDS: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure edNumPKeyPress(Sender: TObject; var Key: Char);
    procedure edNumQKeyPress(Sender: TObject; var Key: Char);
    procedure edNumDKeyPress(Sender: TObject; var Key: Char);
    procedure edNumEKeyPress(Sender: TObject; var Key: Char);
    procedure OpenFileClick(Sender: TObject);
    procedure MakeEDSClick(Sender: TObject);
    procedure HashClick(Sender: TObject);
    procedure bCheckEDSClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Var
  fmMain: TfmMain;

Implementation

{$R *.dfm}

procedure TfmMain.OpenFileClick(Sender: TObject);
var
  temp:string;
  OpenedFile:TextFile;
begin
  if odOpenFile.Execute then
  begin
    mmText.Lines.Clear;
    AssignFile(OpenedFile,odOpenFile.Filename);
    edFileName.Text := odOpenFile.Filename;
    Reset(OpenedFile);
    while not(EOF(OpenedFile)) do
    begin
      Readln(OpenedFile,temp);
      mmText.Lines.Add(temp);
    end;
    CloseFile(OpenedFile);
  end;
end;

procedure TfmMain.edNumPKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then
    Key:=#0;
end;

procedure TfmMain.edNumQKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then
    Key:=#0;
end;

procedure TfmMain.HashClick(Sender: TObject);
var
  p:integer;
  q:integer;
  h:integer;
  fileName:string;
begin
  if (edNumP.Text<>'') and (edNumQ.Text<>'') and (edFileName.Text<>'') then
  begin
    p := StrToInt(edNumP.Text);
    q := StrToInt(edNumQ.Text);
    fileName := edFileName.Text;
    if (IsPrime(p)) and (IsPrime(q)) then
    begin
      h := MakeHash(fileName, p, q);
      if (h <> -1) then
        edHash.Text := IntToStr(h)
      else
        edHash.Text := 'Ошибка!';
    end
    else ShowMessage('Введены неверные данные!');
  end
  else ShowMessage('Ошибка!');
end;

procedure TfmMain.MakeEDSClick(Sender: TObject);
var
  p:integer;
  q:integer;
  h:integer;
  d:integer;
  e:integer;
  r:integer;
  fi:integer;
  S:integer;
  temp:string;
  OpenedFile:TextFile;
begin
  if (edNumP.Text<>'') and (edNumQ.Text<>'') and (edFileName.Text<>'')
      and (edNumD.Text<>'') and (edHash.Text<>'') then
  begin
    p := StrToInt(edNumP.Text);
    q := StrToInt(edNumQ.Text);
    h := StrToInt(edHash.Text);
    d := StrToInt(edNumD.Text);

    r := p * q;
    fi := Eiler(p, q);
    if (IsPrime(p)) and (IsPrime(q) and (GCD(d, p-1) = 1) and (GCD(d, q - 1) = 1)
        and (fi > d) and (d > 1)) then
    begin
      S := 0;
      e := 0;
      CreateEDS(edFileName.Text, h, r, fi, d, e, S);
      edEDS.Text := IntToStr(S);
      edNumE.Text := IntToStr(e);

      mmText.Lines.Clear;
      AssignFile(OpenedFile, edFileName.Text);
      Reset(OpenedFile);
      while not(EOF(OpenedFile)) do
      begin
        Readln(OpenedFile,temp);
        mmText.Lines.Add(temp);
      end;
      CloseFile(OpenedFile);
    end
    else ShowMessage('Введены неверные данные!');
  end
  else ShowMessage('Ошибка!');
end;

procedure TfmMain.edNumDKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then
    Key:=#0;
end;

procedure TfmMain.edNumEKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then
    Key:=#0;
end;

procedure TfmMain.bCheckEDSClick(Sender: TObject);
var
  p:integer;
  q:integer;
  fi:integer;
  hash1:integer;
  hash2:integer;
  e:integer;
begin
  if (edNumP.Text<>'') and (edNumQ.Text<>'') and (edFileName.Text<>'')
      and (edNumE.Text<>'') then
  begin
    p := StrToInt(edNumP.Text);
    q := StrToInt(edNumQ.Text);
    e := StrToInt(edNumE.Text);
    fi := Eiler(p, q);

    if ((IsPrime(p)) and (IsPrime(q)) and (GCD(e, fi) = 1)
        and (fi > e) and (e > 1)) then
    begin
      hash1 := 0;
      hash2 := 0;
      CheckEDS(edFileName.Text, p, q, e, hash1, hash2);
      if (hash1 = hash2) then
        ShowMessage('Подпись действительна: ' + IntToStr(hash1))
      else
        ShowMessage('Оригинальная подпись: ' + IntToStr(hash1) + '. Ваша подпись не действительна: ' + IntToStr(hash2));
    end;
  end;
end;

End.
