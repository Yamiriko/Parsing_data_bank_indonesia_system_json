object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Get Data Bank Di Seluruh Indinesia'
  ClientHeight = 296
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    623
    296)
  PixelsPerInch = 96
  TextHeight = 18
  object StringGrid1: TStringGrid
    Left = 16
    Top = 8
    Width = 599
    Height = 221
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 235
    Width = 599
    Height = 36
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Refresh Data'
    TabOrder = 1
    OnClick = Button1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 277
    Width = 623
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Pesan Sistem : Standby'
        Width = 50
      end>
  end
end
