object MainForm: TMainForm
  Left = 540
  Top = 228
  ClientHeight = 720
  ClientWidth = 956
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Group: TGroupBox
    Left = 0
    Top = 0
    Width = 956
    Height = 720
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 685
    object MainOutPut: TRichEdit
      AlignWithMargins = True
      Left = 5
      Top = 60
      Width = 946
      Height = 655
      Align = alClient
      Alignment = taCenter
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      Zoom = 100
      ExplicitLeft = 7
      ExplicitTop = 69
      ExplicitHeight = 646
    end
    object ListPage: TComboBox
      AlignWithMargins = True
      Left = 5
      Top = 21
      Width = 946
      Height = 33
      Align = alTop
      BiDiMode = bdLeftToRight
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1090#1088#1072#1085#1080#1094#1091
      ExplicitTop = 30
    end
  end
  object Menu: TMainMenu
    Left = 456
    object MyFIle: TMenuItem
      Caption = #1060#1072#1081#1083
      object Searching: TMenuItem
        Caption = #1055#1086#1080#1089#1082
        object SearchTerm: TMenuItem
          Caption = #1058#1077#1088#1084#1080#1085#1072' '#1087#1086' '#1087#1086#1076#1090#1077#1088#1084#1080#1085#1091
          ShortCut = 16454
        end
        object SearchSubTerm: TMenuItem
          Caption = #1055#1086#1076#1090#1077#1088#1084#1080#1085#1086#1074' '#1087#1086' '#1090#1077#1088#1084#1080#1085#1091
          ShortCut = 24646
        end
      end
    end
    object ChangeFile: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      object AddAnything: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        object AddPage: TMenuItem
          Caption = #1057#1090#1088#1072#1085#1080#1094#1091
          ShortCut = 16433
        end
        object AddTerm: TMenuItem
          Caption = #1058#1077#1088#1084#1080#1085
          ShortCut = 16434
        end
        object AddSubTerm: TMenuItem
          Caption = #1055#1086#1076#1090#1077#1088#1084#1080#1085
          ShortCut = 16435
        end
      end
      object SortAnything: TMenuItem
        Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
        object SortPage: TMenuItem
          Caption = #1057#1090#1088#1072#1085#1080#1094#1099
          ShortCut = 8241
        end
        object SortTerm: TMenuItem
          Caption = #1058#1077#1088#1084#1080#1085#1099
          ShortCut = 8242
        end
        object SortSubTerm: TMenuItem
          Caption = #1055#1086#1076#1090#1077#1088#1084#1080#1085#1099
          ShortCut = 8243
        end
      end
      object DeleteAnything: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        object DeletePage: TMenuItem
          Caption = #1057#1090#1088#1072#1085#1080#1094#1091
          ShortCut = 32817
        end
        object DeleteTerm: TMenuItem
          Caption = #1058#1077#1088#1084#1080#1085
          ShortCut = 32818
        end
        object DeleteSubTerm: TMenuItem
          Caption = #1055#1086#1076#1090#1077#1088#1084#1080#1085
          ShortCut = 32819
        end
      end
    end
  end
end
