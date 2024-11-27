unit dbm_Database;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataModule1 = class(TDataModule)
    conDB: TADOConnection;
    tblSpanInfo: TADOTable;
    dsSpanInfo: TDataSource;
    tblWedstrydInfo: TADOTable;
    dsWedstrydInfo: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
