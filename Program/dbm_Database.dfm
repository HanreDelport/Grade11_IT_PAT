object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 213
  Width = 445
  object conDB: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\Hanre Delport\I' +
      'T PAT GR11\Program\Toernooi_DB.mdb;Mode=ReadWrite;Persist Securi' +
      'ty Info=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 64
    Top = 56
  end
  object tblSpanInfo: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'tblSpanInfo'
    Left = 192
    Top = 72
  end
  object dsSpanInfo: TDataSource
    DataSet = tblSpanInfo
    Left = 272
    Top = 64
  end
  object tblWedstrydInfo: TADOTable
    Active = True
    Connection = conDB
    CursorType = ctStatic
    TableName = 'tblWedstrydInfo'
    Left = 192
    Top = 8
  end
  object dsWedstrydInfo: TDataSource
    DataSet = tblWedstrydInfo
    Left = 304
    Top = 16
  end
end
