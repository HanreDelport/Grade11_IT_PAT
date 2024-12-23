unit GR11PAT_u3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls, Buttons, ComCtrls, Grids, DBGrids;

type
  TfrmAfrigter = class(TForm)
    z: TImage;
    pnlLogo: TPanel;
    bbnUit: TBitBtn;
    pnlWysPrestasie: TPanel;
    pnlPrestasie: TPanel;
    cmbNaam: TComboBox;
    lblKiesSpan: TLabel;
    edtWagwoord: TEdit;
    sbtnStoor: TButton;
    edtAfrigter: TEdit;
    bbnTerugUitSpanprestasie: TBitBtn;
    bbn: TBitBtn;
    dbgWedstryde: TDBGrid;
    procedure bbnUitClick(Sender: TObject);
    procedure bbnClick(Sender: TObject);
    procedure pnlWysPrestasieClick(Sender: TObject);
    procedure pnlVeranderClick(Sender: TObject);
    procedure sbtnStoorClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure bbnTerugUitSpanlysClick(Sender: TObject);
    procedure bbnTerugUitSpanprestasieClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAfrigter: TfrmAfrigter;

implementation
uses
 GR11PAT_u , GR11PAT_u2 , dbm_Database;

{$R *.dfm}

procedure TfrmAfrigter.bbnClick(Sender: TObject);
begin
frmAfrigter.Hide;
frmWelkom.Show;
end;

procedure TfrmAfrigter.bbnTerugUitSpanlysClick(Sender: TObject);
begin
//pnlHelp.Visible:=false;  //maak die panel onsigbaar
end;

procedure TfrmAfrigter.bbnTerugUitSpanprestasieClick(Sender: TObject);
begin
pnlPrestasie.Visible:=false;
end;

procedure TfrmAfrigter.bbnUitClick(Sender: TObject);
begin
Application.MainForm.Close;      //Maak die hele program toe
end;

procedure TfrmAfrigter.BitBtn1Click(Sender: TObject);
var
tfile:textfile;         //declare n textfile variable
sline:string;

begin
{if FileExists('frmAfrigter_Help.txt') then    //Kyk of die textfile gevind word
begin
  //pnlHelp.Visible:=true;  //maak die panel sigbaar
  AssignFile(tfile,'frmAfrigter_Help.txt');
  Reset(tfile);
  while not Eof(tfile) do
  begin
    Readln(tfile,sline);//lees die lyntjie van die teksleer in die veranderlike in
    //redTeksleer.Lines.Add(sline);
  end;
end
else
begin
  ShowMessage('Die le�r wat u wil gebruik is nie gevind nie.'); //Boodskap wat die gebruiker inlig
  exit;
end;  }

end;

procedure TfrmAfrigter.pnlVeranderClick(Sender: TObject);
var
I:integer;
begin
pnlPrestasie.Visible:=true;

for i := 1 to dbm_Database.DataModule1.tblSpanInfo.RecordCount do
begin
 cmbNaam.Items.Add(dbm_Database.DataModule1.tblSpanInfo['Span Naam']);  //Add die span se naam by die combobox
end;


end;

procedure TfrmAfrigter.pnlWysPrestasieClick(Sender: TObject);
var
i:integer;
begin
frmWelkom.tblSpanInfo.Open;   //maak die tabel oop
frmWelkom.tblSpanInfo.First;
if frmWelkom.tblSpanInfo['Span Naam']=null then  //As daar nog nie spanne in die tabel gelaai is nie
begin
  ShowMessage('Die organiseerder moet eers spanne byvoeg en die toernooi genereer voordat u na u span se inligting kan kyk');
  exit;
end;

pnlPrestasie.Visible:=true;
frmWelkom.tblSpanInfo.first;
for i := 1 to frmWelkom.tblSpanInfo.RecordCount do  //for-loop om al die spanname vanaf die databasis tabel in die combobox te lees
 begin
 cmbNaam.Items.Add(frmWelkom.tblSpanInfo['Span Naam']);
 frmWelkom.tblSpanInfo.next;
 end;

end;

procedure TfrmAfrigter.sbtnStoorClick(Sender: TObject);
var
bFound, bValidInput:boolean;
ispanID, i:integer;
begin
cmbNaam.Enabled:=false; //disable combobox sodat gebruiker nie veranderinge kan maak tydens verwerking nie
bValidinput:=true;
bFound:=false;
frmWelkom.tblSpanInfo.First;

if (edtWagwoord.Text='') or (edtAfrigter.Text='') then  //toets of die edit bokse leeg is
begin
  ShowMessage('Vul asseblief die wagwoord EN afrigter se naam in'); //Boodskap lig die gebruiker in
  bValidInput:=false;
end;
if bValidInput=false then
Exit;

while not frmWelkom.tblSpanInfo.Eof do
begin
  if cmbNaam.Items[cmbNaam.ItemIndex] = frmWelkom.tblspaninfo['Span Naam'] then //As die combobox se item wat gekies is gelyk is aan die span naam in die tabel
  begin
   if (edtWagwoord.Text =frmWelkom.tblspaninfo['Span password']) and  (edtAfrigter.Text=frmWelkom.tblSpanInfo['Afrigter']) then
    begin
      bFound:=true;
      iSpanID:=strToInt(frmWelkom.tblspaninfo['Span ID']);//stoor die span id in n veranderlike wat later in verwrkng gebruik sal word
      frmWelkom.tblSpanInfo.Edit;
      ShowMessage('U is suksesvol ingeteken as afrigter van '+frmWelkom.tblspaninfo['Span Naam']);
    end ;
  end;
frmWelkom.tblSpanInfo.Next;
end;

if bFound=false then   //veranderlike wat toets of die wagwword korrek is
begin
ShowMessage('Die wagwoord of afrigter se naam is verkeerd');
exit;
end;


dbgWedstryde.Columns[0].Width:=70;   //stel die breedte van al diekollomme in die databasis "grid"
dbgWedstryde.Columns[1].Width:=70;
dbgWedstryde.Columns[2].Width:=70;
dbgWedstryde.Columns[3].Width:=70;
dbgWedstryde.Columns[4].Width:=70;

dbgWedstryde.DataSource:=frmWelkom.dsWedstrydInfo;


{frmWelkom.tblWedstrydInfo.Filtered:=false;
frmWelkom.tblWedstrydInfo.Filter:='Span ID 1 = 1 ';
//frmWelkom.tblWedstrydInfo.Filter:='Span ID 2 = '+ QuotedStr(sSpanID);
frmWelkom.tblWedstrydInfo.Filtered:=true;}

dbgWedstryde.Visible:=true;
end;







end.
