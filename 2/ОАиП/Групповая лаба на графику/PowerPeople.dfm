object MainForm: TMainForm
  Left = 428
  Top = 88
  Caption = 'MainForm'
  ClientHeight = 681
  ClientWidth = 1464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MediaPlayer1: TMediaPlayer
    Left = 88
    Top = 24
    Width = 253
    Height = 30
    AutoOpen = True
    DoubleBuffered = True
    FileName = 'C:\Users\'#1053#1072#1076#1077#1078#1076#1072'\Downloads\oomph-ich-will-deine-seele.mp3'
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 12
    OnTimer = tmr1Timer
    Left = 24
    Top = 24
  end
end
