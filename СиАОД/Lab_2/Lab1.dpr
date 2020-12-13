program Lab1;

{$APPTYPE CONSOLE}

type
  TExpressionRef = ^TExpression;

  TExpression = Record
    Power: Integer;
    Coeff: Real;
    Next: TExpressionRef;
  end;

function Equality(p,q: TExpressionRef): String;
 var
  Flag: Boolean;
begin
  repeat
    if (p.Power = q.Power) and (p.Coeff = q.Coeff) then
      Flag:= True
    else
      Flag:= False;

    if (((p.Next = Nil) and (q.Next <> Nil)) or
        ((p.Next <> Nil) and (q.Next = Nil))) then
      Flag:= False;

    p:= p.Next;
    q:= q.Next;
  until (not Flag or ((p = Nil) and (q = Nil)));

  if Flag then Result:= '>> Многочлены равны'
  else Result:= '>> Многочлены не равны';
end;

function Meaning(p: TExpressionRef; x: Integer): Real;
 var
  temp: Real;
begin
  repeat
    if (p.Power > 0) then
      Result:= Result + exp(ln(x)*p.Power) * p.Coeff
    else
      begin
        p.Power:= -p.Power;
        temp:= 1/exp(ln(x)*p.Power);
        Result:= Result + temp * p.Coeff;
      end;
    p:= p.Next;
  until (p = Nil);
end;

procedure Add(var p, q, r: TExpressionRef);
 var
  pHead, qHead, rHead, temp: TExpressionRef;
  Flag, First: Boolean;
begin
  rHead:= r;
  qHead:= q;

  New(pHead);
  p:= pHead;
  First:= True;

  repeat
    if not First then p:= p.Next;

    p.Power:= q.Power;
    Flag:= False;

    repeat
      if (q.Power = r.Power) then
      begin
        p.Coeff:= q.Coeff + r.Coeff;
        Flag:= True;
      end
      else
        p.Coeff:= q.Coeff;
      r:= r.Next;
    until ((r = Nil) or (Flag));

    r:= rHead;
    q:= q.Next;

    New(p.Next);
    temp:= p;
    First:= False;
  until (q = Nil);

  p.Next:= Nil;
  p:= pHead;
  q:= qHead;
  r:= rHead;

  repeat
    Flag:= False;
    repeat
      if p.Power = r.Power then Flag:= True;
      temp:= p;
      p:= p.Next;
    until ((p = Nil) or (Flag));

    if not Flag then
    begin
      p:= temp;
      New(p.Next);
      p:= p.Next;
      p.Power:= r.Power;
      p.Coeff:= r.Coeff;
      p.Next:= Nil;
    end;

    r:= r.Next;
    p:= pHead;
    q:= qHead;
  until (r = Nil);
end;

var
  p, q, r, pHead, qHead, rHead: TExpressionRef;
  Str: String;
  temp: Integer;
  Flag: Boolean;

begin
  New(pHead);
  New(qHead);
  New(rHead);
  p:= pHead;
  q:= qHead;
  r:= rHead;

  Flag:= False;
  repeat
    if Flag then p:= p.Next;
    Write('>> Введите степень p многочлена: ');
    Readln(p.Power);
    Write('>> Введите коэффициент многочлена: ');
    Readln(p.Coeff);
    Write('>> Чтобы прекратить ввод, введите "stop": ');
    Readln(Str);
    New(p.Next);
    Flag:= True;
  until (Str = 'stop');
  p.Next:= Nil;
  Writeln;

  Flag:= False;
  repeat
    if Flag then q:= q.Next;
    Write('>> Введите степень q многочлена: ');
    Readln(q.Power);
    Write('>> Введите коэффициент многочлена: ');
    Readln(q.Coeff);
    Write('>> Чтобы прекратить ввод, введите "stop": ');
    Readln(Str);
    New(q.Next);
    Flag:= True;
  until (Str = 'stop');
  q.Next:= Nil;
  Writeln;

  Flag:= False;
  repeat
    if Flag then r:= r.Next;
    Write('>> Введите степень r многочлена: ');
    Readln(r.Power);
    Write('>> Введите коэффициент многочлена: ');
    Readln(r.Coeff);
    Write('>> Чтобы прекратить ввод, введите "stop": ');
    Readln(Str);
    New(r.Next);
    Flag:= True;
  until (Str = 'stop');
  r.Next:= Nil;
  Writeln;

  Writeln(Equality(pHead, qHead));
  Writeln;
  Write('>> Введите x: ');
  Readln(temp);
  Writeln('При x = ', temp, ' многочлен p = ', Meaning(pHead,temp));
  Writeln;

  Add(pHead, qHead, rHead);
  p:= pHead;

  Writeln('Сумма многочленов q и r:');
  repeat
    Writeln('Степень = ', p.Power, ' Коэффициент = ', p.Coeff);
    p:= p.Next;
  until (p = Nil);

  Readln;
end.
