object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 307
  Width = 628
  object Conecta: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\Delphi\iBens\database\DB.IDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=WIN1252'
      'MonitorBy=Custom'
      'DriverID=FB')
    Left = 136
    Top = 104
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 376
    Top = 104
  end
  object FDMoniCustomClientLink1: TFDMoniCustomClientLink
    Left = 224
    Top = 200
  end
end
