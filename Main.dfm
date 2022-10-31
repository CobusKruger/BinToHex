object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Bin To Hex'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 24
    Height = 13
    Caption = 'Bin'#234'r'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 42
    Height = 13
    Caption = 'Desimaal'
  end
  object lblDesimaal: TLabel
    Left = 120
    Top = 56
    Width = 52
    Height = 13
    Caption = 'lblDesimaal'
  end
  object Label4: TLabel
    Left = 24
    Top = 96
    Width = 66
    Height = 13
    Caption = 'Hexadesimaal'
  end
  object lblHexadesimaal: TLabel
    Left = 120
    Top = 96
    Width = 76
    Height = 13
    Caption = 'lblHexadesimaal'
  end
  object edtBinary: TEdit
    Left = 120
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '1011'
  end
  object Button1: TButton
    Left = 24
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Convert'
    TabOrder = 1
    OnClick = Button1Click
  end
end
