object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 435
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 700
    Height = 374
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'MATEPGCTT'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMPES'
        Width = 178
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALCTT'
        Width = 104
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 374
    Width = 700
    Height = 61
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 592
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Inserir'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 496
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Editar'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 400
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
    end
  end
  object DataSource1: TDataSource
    Left = 416
    Top = 208
  end
end
