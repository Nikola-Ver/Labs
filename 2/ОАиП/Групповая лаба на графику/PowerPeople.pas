unit PowerPeople;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Vcl.MPlayer, Vcl.Imaging.pngimage;

type
  TMainForm = class(TForm)
    tmr1: TTimer;
    MediaPlayer1: TMediaPlayer;
    procedure tmr1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

TProperty = record
  X: Integer;
  Y: Integer;
  Len: Integer;
  Degree: Integer;
end;

THuman = record
  Head: TProperty;
  Body: TProperty;

  LeftForearm : TProperty;
  LeftShoulder: TProperty;
  LeftHip: TProperty;
  LeftShin: TProperty;

  RightForearm : TProperty;
  RightShoulder: TProperty;
  RightHip: TProperty;
  RightShin: TProperty;
end;

var
  MainForm: TMainForm;
  Barbell: TPoint;
  BarbellHeight: Integer;
  Human: THuman;
  OldWidth, OldHeight: Integer;
  Level: Integer = 0;
  Scenario: Integer = 0; // ƒействие нулевое (приветствие), действие второе (разминка) и т.д.
  MoveSky: Integer = 0;
  DirectionSky: Boolean = False;

implementation

{$R *.dfm}

function Coeff(Sender: TObject): Real; // —жатие и раст€гивание
begin
  with Sender as TForm do
    begin
      if  Width / OldWidth > Height / OldHeight then
        Result:= Height / OldHeight
      else
        Result:= Width / OldWidth;
    end;
end;

procedure DrawLine(Sender: TObject; Part: TProperty; var X1, Y1: Integer);
var
  Deg: Real;
begin
  with (Sender as TForm) do
    with Part do
      begin
        Deg:= Degree * Pi / 180;
        X1:= X + Round(Len * Cos(Deg) * Coeff(Sender));
        Y1:= Y - Round(Len * Sin(Deg) * Coeff(Sender));

        Canvas.MoveTo(X,Y);
        Canvas.LineTo(X1,Y1);
      end;
end;

procedure Background(Sender: TObject);
var
  dx: Integer;
begin
  with (Sender as TForm).Canvas do
  begin
    Brush.Color:= $00408000;
    Pen.Color:= $00408000;
    Rectangle(0, Round((Sender as TForm).Height / 2 * Coeff(MainForm)),
              (Sender as TForm).Width,(Sender as TForm).Height);

    Brush.Color:= clGradientActiveCaption;
    Pen.Color:= clGradientActiveCaption;
    Rectangle(0, 0, (Sender as TForm).Width,
              Round((Sender as TForm).Height / 2 * Coeff(MainForm)));

    if (200 * Coeff(MainForm)) < (Sender as TForm).Height/2*Coeff(MainForm) then
      begin
        Brush.Color:= ClYellow;
        Pen.Color:= ClYellow;
        Ellipse(Round(5 * Coeff(Sender)),Round(5 * Coeff(Sender)),
                Round(200 * Coeff(MainForm)),Round(200 * Coeff(MainForm)));
      end;
      
    if (165 * Coeff(MainForm)) < (Sender as TForm).Height/2*Coeff(MainForm) then
      begin
        dx:= 400 + MoveSky div 15;
        repeat
          Brush.Color:= ClWhite;
          Pen.Color:= ClWhite;
          Ellipse(Round(dx * Coeff(Sender)),Round(50 * Coeff(Sender)),
                Round((dx+150) * Coeff(MainForm)),Round(150 * Coeff(MainForm)));
          Ellipse(Round((dx+50) * Coeff(Sender)),Round(35 * Coeff(Sender)),
                Round((dx+250) * Coeff(MainForm)),Round(165 * Coeff(MainForm)));
          Ellipse(Round((dx+150) * Coeff(Sender)),Round(50 * Coeff(Sender)),
                Round((dx+300) * Coeff(MainForm)),Round(150 * Coeff(MainForm)));
          dx:= dx + 400;
        until (dx > 6000);
        if (MoveSky >= 300) or (DirectionSky) then
          begin
            Dec(MoveSky);
            DirectionSky:= True;
            if MoveSky <= -90 then
              DirectionSky:= False;
          end
        else
          Inc(MoveSky);
      end;

      dx:= 100;
      repeat
        Brush.Color:= ClBackground;
        Pen.Color:= ClBackground;
        Rectangle(Round(dx * Coeff(Sender)),Round(600 * Coeff(Sender)),
                 Round((dx+40) * Coeff(MainForm)),Round(350 * Coeff(MainForm)));

        Brush.Color:= clGreen;
        Pen.Color:= clGreen;
        Ellipse(Round((dx-95) * Coeff(Sender)),Round(450 * Coeff(Sender)),
                Round((dx+135) * Coeff(MainForm)),Round(270 * Coeff(MainForm)));
        if dx < 1300 then
          dx:= dx + 1300
        else
          dx:= dx + 900;
      until (dx > 12000);

    Brush.Color:= ClHighlight;
    Pen.Color:= ClHighlight;

    Rectangle(0,Round(1700 * Coeff(Sender)),
            (Sender as TForm).Width,(Sender as TForm).Height);
  end;
end;

procedure DrawBarbell(Sender: TObject);
begin
  with Barbell do
    with (Sender as TForm).Canvas do
    begin
      (Sender as TForm).Canvas.Brush.Color:= ClBlue;
      Ellipse(X - Round(130 * Coeff(Sender)),Y - Round(20 * Coeff(Sender)),
                X - Round(120 * Coeff(Sender)),Y + Round(20 * Coeff(Sender)));
      (Sender as TForm).Canvas.Brush.Color:= ClGreen;
      Ellipse(X - Round(120 * Coeff(Sender)),Y - Round(30 * Coeff(Sender)),
                X - Round(110 * Coeff(Sender)),Y + Round(30 * Coeff(Sender)));
      (Sender as TForm).Canvas.Brush.Color:= clOlive;
      Ellipse(X - Round(110 * Coeff(Sender)),Y - Round(40 * Coeff(Sender)),
                X - Round(100 * Coeff(Sender)),Y + Round(40 * Coeff(Sender)));
      (Sender as TForm).Canvas.Brush.Color:= clMaroon;
      Ellipse(X - Round(100 * Coeff(Sender)),Y - Round(45 * Coeff(Sender)),
                X - Round(90 * Coeff(Sender)),Y + Round(45 * Coeff(Sender)));

      MoveTo(X - Round(90 * Coeff(Sender)),Y);
      LineTo(X + Round(130 * Coeff(Sender)),Y);

      (Sender as TForm).Canvas.Brush.Color:= ClBlue;
      Ellipse(X + Round(130 * Coeff(Sender)),Y - Round(20 * Coeff(Sender)),
                X + Round(120 * Coeff(Sender)),Y + Round(20 * Coeff(Sender)));
      (Sender as TForm).Canvas.Brush.Color:= ClGreen;
      Ellipse(X + Round(120 * Coeff(Sender)),Y - Round(30 * Coeff(Sender)),
                X + Round(110 * Coeff(Sender)),Y + Round(30 * Coeff(Sender)));
      (Sender as TForm).Canvas.Brush.Color:= clOlive;
      Ellipse(X + Round(110 * Coeff(Sender)),Y - Round(40 * Coeff(Sender)),
                X + Round(100 * Coeff(Sender)),Y + Round(40 * Coeff(Sender)));
      (Sender as TForm).Canvas.Brush.Color:= clMaroon;
      Ellipse(X + Round(100 * Coeff(Sender)),Y - Round(45 * Coeff(Sender)),
                X + Round(90 * Coeff(Sender)),Y + Round(45 * Coeff(Sender)));
      (Sender as TForm).Canvas.Brush.Color:= ClWhite;
    end;
end;

procedure LeftArmBarbell(Sender: TObject; X1,Y1: Integer);
begin
  with Human do
    with (Sender as TForm).Canvas do
    begin
      LeftShoulder.X:= X1;
      LeftShoulder.Y:= Y1;
      DrawLine(Sender,LeftShoulder,LeftForearm.X,LeftForearm.Y);
      DrawLine(Sender,LeftForearm,X1,Y1);
    end;
end;

procedure RightArmBarbell(Sender: TObject; X1,Y1: Integer);
begin
  with Human do
    with (Sender as TForm).Canvas do
    begin
      RightShoulder.X:= X1;
      RightShoulder.Y:= Y1;
      DrawLine(Sender,RightShoulder,RightForearm.X,RightForearm.Y);
      DrawLine(Sender,RightForearm,X1,Y1);
    end;
end;

procedure LeftLegBarbell(Sender: TObject;  X1,Y1: Integer);
begin
  with Human do
    with (Sender as TForm).Canvas do
    begin
      LeftHip.X:= X1;
      LeftHip.Y:= Y1;
      DrawLine(Sender,LeftHip,LeftShin.X,LeftShin.Y);
      DrawLine(Sender,LeftShin,X1,Y1);
    end;
end;

procedure RightLegBarbell(Sender: TObject; X1,Y1: Integer);
begin
  with Human do
    with (Sender as TForm).Canvas do
    begin
      RightHip.X:= X1;
      RightHip.Y:= Y1;
      DrawLine(Sender,RightHip,RightShin.X,RightShin.Y);
      DrawLine(Sender,RightShin,X1,Y1);
    end;
end;

procedure LiftBarbellPeople(Sender: TObject; X0,Y0: Integer);
var
  X1,Y1: Integer;
begin
  with Human do
    with (Sender as TForm).Canvas do
    begin
      Brush.Color:= ClCream;
      Pen.Color:= ClBlack;

      X1:= Round(X0 * Coeff(Sender));
      Y1:= Round(Y0 * Coeff(Sender));

      Ellipse(X1, Y1, Round((Head.Len * Coeff(Sender))) + X1,
              Round((Head.Len * Coeff(Sender))) + Y1);

      Body.X:= (Round((Head.Len * Coeff(Sender))) + 2 * X1) div 2;
      Body.Y:= Round((Head.Len * Coeff(Sender))) + Y1;

      DrawLine(Sender,Body,X1,Y1);

      LeftLegBarbell(Sender,X1,Y1);
      RightLegBarbell(Sender,X1,Y1);

      X1:= Round(Body.X + 15 * Cos(Body.Degree * Pi / 180) * Coeff(Sender));
      Y1:= Round(Body.Y - 15 * Sin(Body.Degree * Pi / 180) * Coeff(Sender));
      LeftArmBarbell(Sender,X1,Y1);
      RightArmBarbell(Sender,X1,Y1);

      Barbell.X:= Round((Head.X + Head.Len div 2) * Coeff(Sender));
      Barbell.Y:= Round(BarbellHeight * Coeff(Sender));
      DrawBarbell(Sender);
    end;
end;

procedure ChangeControlPointsBarbell();
begin
  with Human do
  begin
    case Scenario of
      0:
        begin 
          Dec(LeftShoulder.Degree);
          Dec(LeftForearm.Degree,2);
          Inc(RightShoulder.Degree);
          Inc(RightForearm.Degree,2);

          if LeftForearm.Degree <= 80 then Inc(Scenario);
        end;

      1:
        begin 
          Inc(LeftShoulder.Degree);
          Inc(LeftForearm.Degree,2);
          Dec(RightShoulder.Degree);
          Dec(RightForearm.Degree,2);
          
          if LeftForearm.Degree >= 270 then Inc(Scenario);
        end; 

      2:
        begin 
          Dec(LeftShoulder.Degree);
          Dec(LeftForearm.Degree,2);
          Inc(RightShoulder.Degree);
          Inc(RightForearm.Degree,2);

          if LeftForearm.Degree <= 80 then Inc(Scenario);
        end;

      3:
        begin 
          Inc(LeftShoulder.Degree);
          Inc(LeftForearm.Degree,2);
          Dec(RightShoulder.Degree);
          Dec(RightForearm.Degree,2);
          
          if LeftForearm.Degree >= 270 then Inc(Scenario);
        end; 

      4:
        begin
          Inc(Head.Y);
          Dec(LeftHip.Degree);
          Inc(RightHip.Degree);
          
          if LeftShoulder.Degree > 185 then
            begin
              Dec(LeftShoulder.Degree);
              Dec(LeftForearm.Degree);
              Inc(RightShoulder.Degree);
              Inc(RightForearm.Degree);
            end;

          if LeftHip.Degree <= 160 then Inc(Scenario);
        end;

      5:
        begin
          Dec(Head.Y);
          Inc(LeftHip.Degree);
          Dec(RightHip.Degree);
          
          if LeftShoulder.Degree <= 230 then
            begin
              Inc(LeftShoulder.Degree);
              Inc(LeftForearm.Degree);
              Dec(RightShoulder.Degree);
              Dec(RightForearm.Degree);
            end;

          if LeftHip.Degree >= 230 then Inc(Scenario);
        end;

      6:
        begin
          Inc(Head.Y);
          Dec(LeftHip.Degree);
          Inc(RightHip.Degree);
          
          if LeftShoulder.Degree > 185 then
            begin
              Dec(LeftShoulder.Degree);
              Dec(LeftForearm.Degree);
              Inc(RightShoulder.Degree);
              Inc(RightForearm.Degree);
            end;

          if LeftHip.Degree <= 160 then Inc(Scenario);
        end;

      7:
        begin
          Dec(Head.Y);
          Inc(LeftHip.Degree);
          Dec(RightHip.Degree);
          
          if LeftShoulder.Degree <= 230 then
            begin
              Inc(LeftShoulder.Degree);
              Dec(RightShoulder.Degree);
            end;

          if LeftHip.Degree >= 230 then Inc(Scenario);
        end;

      8:
        begin
          Dec(LeftForearm.Degree,2);
          Inc(RightForearm.Degree,2);

          if LeftForearm.Degree <= 80 then Inc(Scenario);
        end;

      9:
        begin
          Inc(LeftForearm.Degree,2);
          Dec(RightForearm.Degree,2);

          if LeftForearm.Degree >= 270  then Inc(Scenario);
        end;

      10:
        begin
          Inc(Head.Y);
          Dec(LeftHip.Degree);
          Inc(RightHip.Degree);

          if LeftHip.Degree <= 165 then Inc(Scenario);
        end;

      11:
        begin
          if Level mod 4 = 0 then
            begin
              Dec(Head.Y);
              Inc(LeftHip.Degree);
              Dec(RightHip.Degree);
              Dec(BarbellHeight);
            end;

          Inc(Level);
          if LeftHip.Degree >= 230 then
            begin
              Level:= 0;
              Inc(Scenario);
            end;
        end;

      12:
        begin
          if Level mod 2 = 0 then
            begin
              Inc(Head.Y,2);
              Dec(LeftHip.Degree,2);
              Inc(RightHip.Degree,2);
              Inc(BarbellHeight);

              Dec(LeftShoulder.Degree);
              Inc(RightShoulder.Degree);
            end;

          Inc(Level);
          if LeftShoulder.Degree <= 190 then
            begin
              Inc(Scenario);
              Level:= 0;
            end;
        end;

      13:
        begin
          if Level mod 4 = 0 then
            if LeftShoulder.Degree >= 160 then
              begin
                Dec(Head.Y);
                Inc(LeftHip.Degree);
                Dec(RightHip.Degree);
                Dec(BarbellHeight,2);
                Dec(LeftShoulder.Degree);
                Inc(RightShoulder.Degree);
              end
            else
              Inc(Scenario);

          Inc(Level);
        end;

      14:
        begin
          if Level mod 4 = 0 then
            begin
              Dec(LeftForearm.Len,3);
              Dec(RightForearm .Len,3);
              Dec(BarbellHeight,3);
              if RightForearm.Len < -15 then
                begin
                  Dec(RightForearm.Len);
                  Dec(LeftForearm.Len);
                end;
              if LeftHip.Degree <= 230 then
                begin
                  Dec(BarbellHeight);
                  Dec(Head.Y);
                  Inc(LeftHip.Degree);
                  Dec(RightHip.Degree);
                end;
              if LeftForearm.Len <= -60 then
              begin
                Inc(Scenario);
                LeftForearm.Len:= 60;
                LeftForearm.Degree:= 90;
                RightForearm.Len:= 60;
                RightForearm.Degree:= 90;
              end;
            end;

          Inc(Level);
        end;

      15:
        begin
          Dec(Body.Degree,3);
          Inc(Head.X,3);
          Inc(Head.Y,4);
          if (Level mod 2 = 0) then
            Inc(BarbellHeight,7);
          Dec(LeftHip.Degree,3);
          Dec(RightHip.Degree,3);
          Inc(RightShin.Degree,3);

          Inc(Level);
          if Body.Degree <= 180 then
            begin
              Inc(Scenario);
              Level:= 0;
            end;
        end;

      16:
        begin
          Inc(Level);
          if Level = 250 then Inc(Scenario);
        end;
    end;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  OldHeight:= 720;
  OldWidth:= 1480;

  Canvas.Pen.Width:= 1;
  with Human do
  begin
    Head.Len:= 75;
    Body.Len:= 100;
    Body.Degree:= 270;

    LeftShoulder.Len:= 60;
    LeftShoulder.Degree:= 230;
    RightShoulder.Len:= 60;
    RightShoulder.Degree:= 310;

    LeftForearm.Len:= 60;
    LeftForearm.Degree:= 270;
    RightForearm.Len:= 60;
    RightForearm.Degree:= 270;

    LeftHip.Len:= 60;
    LeftHip.Degree:= 230;
    RightHip.Degree:= 310;
    RightHip.Len:= 60;

    LeftShin.Len:= 60;
    LeftShin.Degree:= 270;
    RightShin.Len:= 60;
    RightShin.Degree:= 270;

    Head.X:= 550;
    Head.Y:= 350;
    BarbellHeight:= (Head.Y + Body.Len + LeftShin.Len + LeftHip.Len + 40);
    tmr1.Enabled:= True;
  end;
end;

procedure TMainForm.tmr1Timer(Sender: TObject);
begin
  ChangeControlPointsBarbell();
  DoubleBuffered:=True;
  Repaint;

  if Scenario = 17 then
    begin
      Scenario:= 0;
      FormShow(Sender);
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MediaPlayer1.Play;
  MediaPlayer1.Visible:= False;
end;

procedure TMainForm.FormPaint(Sender: TObject);
var
  temp: THuman;
  tempBarbellHeight: Integer;
begin
  Background(MainForm);
  with Human do
  begin
    LiftBarbellPeople(MainForm,Head.X,Head.Y);
    if Scenario < 15 then
      begin
        Head.X:= Head.X + 500;
        Head.Y:= Head.Y + 50;
        BarbellHeight:= BarbellHeight + 50;
        LiftBarbellPeople(MainForm,Head.X,Head.Y);
        BarbellHeight:= BarbellHeight - 50;
        Head.Y:= Head.Y - 50;
        Head.X:= Head.X - 500;
      end
    else
      begin
        temp:= Human;
        with Human do
        begin
          tempBarbellHeight:= BarbellHeight;
          BarbellHeight:= 375;
          Head.X:= 550;
          Head.Y:= 364;
          Body.Degree:= 270;
          LeftForearm.Degree:= 90;
          LeftShoulder.Degree:= 159;
          LeftHip.Degree:= 216;
          LeftShin.Degree:= 270;
          RightForearm.Degree:= 90;
          RightShoulder.Degree:= 381;
          RightHip.Degree:= 324;
          RightShin.Degree:= 270;
        end;
        Head.X:= Head.X + 500;
        Head.Y:= Head.Y + 50;
        BarbellHeight:= BarbellHeight + 50;
        LiftBarbellPeople(MainForm,Head.X,Head.Y);
        BarbellHeight:= BarbellHeight - 50;
        Head.Y:= Head.Y - 50;
        Head.X:= Head.X - 500;
        Human:= temp;
        BarbellHeight:= tempBarbellHeight;
      end;
  end;
end;

end.
