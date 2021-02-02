object frmCadEpg: TfrmCadEpg
  Left = 0
  Top = 0
  Caption = 'Cadastro de Empregados'
  ClientHeight = 386
  ClientWidth = 465
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 49
    Caption = 'Nome'
    TabOrder = 0
    object edtNome: TEdit
      Left = 10
      Top = 16
      Width = 254
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 304
    Top = 8
    Width = 153
    Height = 49
    Caption = 'Inscri'#231#227'o'
    TabOrder = 1
    object edtIns: TMaskEdit
      Left = 10
      Top = 16
      Width = 133
      Height = 21
      TabOrder = 0
      Text = ''
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 72
    Width = 217
    Height = 49
    Caption = 'Data Admiss'#227'o'
    TabOrder = 2
    object edtDtaAdm: TDateTimePicker
      Left = 10
      Top = 18
      Width = 195
      Height = 21
      Date = 44227.000000000000000000
      Time = 0.048727048611908680
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 240
    Top = 72
    Width = 217
    Height = 49
    Caption = 'Salario Empregado'
    TabOrder = 3
    object edtSalEpg: TMaskEdit
      Left = 8
      Top = 18
      Width = 189
      Height = 21
      TabOrder = 0
      Text = ''
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 136
    Width = 449
    Height = 193
    Caption = 'Dependentes'
    TabOrder = 4
    object DBGrid1: TDBGrid
      Left = 10
      Top = 16
      Width = 429
      Height = 137
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 335
    Width = 465
    Height = 51
    Align = alBottom
    TabOrder = 5
    object Button1: TButton
      Left = 145
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 244
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
