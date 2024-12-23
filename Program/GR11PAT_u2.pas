unit GR11PAT_u2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, ComCtrls, Buttons, Spin, math, DBCtrls,
  Grids,DBGrids,dbm_Database;

type
  TfrmOrganiseerder = class(TForm)
    bbnTerug: TBitBtn;
    imgBackground: TImage;
    lblHoeveelheidspanne: TLabel;
    lblToernooi: TLabel;
    pnlLogo: TPanel;
    rgpFormaat: TRadioGroup;
    pnlGenereer: TPanel;
    memToernooi: TMemo;
    pnlWysUitslae: TPanel;
    pnlUitslae: TPanel;
    cmbSpanne: TComboBox;
    lblKiesWedstryd: TLabel;
    sedSpan2: TSpinEdit;
    sedSpan1: TSpinEdit;
    lblSpan1: TLabel;
    lblSpan2: TLabel;
    bbnToe: TBitBtn;
    btnStoor: TButton;
    btnGenereerVolgende: TButton;
    Label3: TLabel;
    edtOuderdomsgroep: TEdit;
    pnlToernooi: TPanel;
    dbgWedstrydInfo: TDBGrid;
    dbgSpanInfo: TDBGrid;
    btnOpdateer: TButton;
    btnVerwyder: TButton;
    btnOpdateer2: TButton;
    btnVerwyderRekords: TButton;
    btnOk: TButton;
    lblHoeveelSpanne: TLabel;
    btnStoorSpan: TButton;
    redSpanname: TRichEdit;
    bbnUit: TBitBtn;
    BitBtn1: TBitBtn;
    pnlOndersoekSpanne: TPanel;
    procedure pnlGenereerClick(Sender: TObject);
    procedure pnlWysUitslaeClick(Sender: TObject);
    procedure btnGenereerVolgendeClick(Sender: TObject);
    procedure bbnUitClick(Sender: TObject);
    procedure bbnTerugClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnStoorSpanClick(Sender: TObject);
    procedure btnOpdateer2Click(Sender: TObject);
    procedure btnVerwyderRekordsClick(Sender: TObject);
    procedure btnStoorClick(Sender: TObject);
    procedure btnOpdateerClick(Sender: TObject);
    procedure btnVerwyderClick(Sender: TObject);
    procedure bbnToeClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure pnlOndersoekSpanneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmOrganiseerder: TfrmOrganiseerder;
  arrSpanname:array[1..20] of string   ;
  arrSpanIDs:array[1..20] of integer   ;
  iSpanne, iSpanID, iToernooiFormaat
  {veranderlike wat die itemindex van rgpFormaat stoor}
  ,iRondte:integer;

  bDeleted:boolean;

implementation
uses
 GR11PAT_u ,GR11PAT_u3;

{$R *.dfm}

procedure TfrmOrganiseerder.bbnTerugClick(Sender: TObject);
begin
frmOrganiseerder.Hide;
frmWelkom.Show;
end;

procedure TfrmOrganiseerder.bbnToeClick(Sender: TObject);
begin
pnlUitslae.Hide;
end;

procedure TfrmOrganiseerder.bbnUitClick(Sender: TObject);
begin
Application.MainForm.Close;
end;

procedure TfrmOrganiseerder.BitBtn1Click(Sender: TObject);
begin
pnlToernooi.Hide;
end;

procedure TfrmOrganiseerder.btnGenereerVolgendeClick(Sender: TObject);
var
i:integer;
bfound, bIngevul:boolean;
sWenner:string;
begin

bingevul:=true;
frmWelkom.tblWedstrydInfo.First;
while not frmWelkom.tblWedstrydInfo.Eof do //Loop wat toets of al die tellings ingevul is
begin
if frmWelkom.tblWedstrydInfo['Score']=null then
begin
 bingevul:=false;
 ShowMessage('Vul asseblief al wedstryde se tellings in');
 exit;
end;
frmWelkom.tblWedstrydInfo.Next;
end;

bfound:=false;
inc(iRondte);
frmWelkom.tblSpanInfo.Open;
frmWelkom.tblWedstrydInfo.Open;

for i := 1 to iSpanne do
  begin
    arrSpanname[i]:='';//Maak die hele skikking skoon sodat nuwe data bygevoeg kan word
    arrSpanIDs[i]:=0;
  end;

bfound:=false;
frmWelkom.tblWedstrydInfo.First;
while bfound=false do
begin
  if frmWelkom.tblWedstrydInfo['Voltooi']='False' then
  begin
   bFound:=true ;//Sodat die volgende while loop kan begin van die laaste rekkord af
  end
  else
  begin
  frmWelkom.tblWedstrydInfo.Next;
  end;
end;

bfound:=false;

i:=1;
while not frmWelkom.tblWedstrydInfo.Eof do
begin
if not (frmWelkom.tblWedstrydInfo['Wenner']=inttostr(0)) then//as die twee spanne nie gelyk op gespeel het nie
 begin
  arrSpanIDs[i]:= frmWelkom.tblWedstrydInfo['Wenner']; //Voeg die wenner se ID by die skoon skikking
  frmWelkom.tblSpanInfo.First;
  while not frmWelkom.tblSpanInfo.eof do
  begin
    if arrSpanIDs[i]=frmWelkom.tblSpanInfo['Span ID'] then
    begin
      bfound:=true;
      arrSpanname[i]:=frmWelkom.tblSpanInfo['Span Naam'];//Voeg die span wat gewen het se naam by n tweede skikking
    end;
    frmWelkom.tblSpanInfo.Next;
  end;

  if bfound=false then
  begin
    ShowMessage('Die span ID is nie gevind nie');
    exit;
  end;
 Inc(i);
 frmWelkom.tblWedstrydInfo.Edit;
 frmWelkom.tblWedstrydInfo['Voltooi']:='True';
 frmWelkom.tblWedstrydInfo.Post;
 frmWelkom.tblWedstrydInfo.Next;
 end
 else
 if frmWelkom.tblWedstrydInfo['Wenner']=inttostr(0) then     //As die spanne se tellings gelyk is:
 begin
  bfound:=false;
  arrSpanIDs[i]:= frmWelkom.tblWedstrydInfo['Span ID 1'];
  arrSpanIDs[i+1]:=frmWelkom.tblWedstrydInfo['Span ID 2']; //Beide spanne word by skikkinggevoeg aangesien altwee spanne deur dring
  frmWelkom.tblSpanInfo.First;
  while not(frmWelkom.tblSpanInfo.eof) and (bfound=false) do
  begin
    if arrSpanIDs[i]=frmWelkom.tblSpanInfo['Span ID'] then
    begin
      arrSpanname[i]:=frmWelkom.tblSpanInfo['Span Naam'];
      bFound:=true;
    end;
  frmWelkom.tblSpanInfo.Next;
  //Inc(i);
  end;
  bfound:=false;
  frmWelkom.tblSpanInfo.First;
  while not(frmWelkom.tblSpanInfo.eof) and (bfound=false) do
  begin
    if arrSpanIDs[i+1]=frmWelkom.tblSpanInfo['Span ID'] then
    begin
      arrSpanname[i+1]:=frmWelkom.tblSpanInfo['Span Naam'];
      bfound:=true;
    end;
    frmWelkom.tblSpanInfo.Next;
  //Inc(i,1);//die teller moet met twee vermeerder word aangesien daar twee items by die skikkings gevoeg is
  end;
 frmWelkom.tblWedstrydInfo.Edit;
 frmWelkom.tblWedstrydInfo['Voltooi']:='True';
 frmWelkom.tblWedstrydInfo.post;
 frmWelkom.tblWedstrydInfo.Next;
 Inc(i,2);
 end;
end;
iSpanne:=i-1;

if iToernooiFormaat=0 then
begin
if iSpanne=1 then
begin
memToernooi.Lines.Add(#13+#13+'DIE WENNER IS: '+UpperCase(arrspanname[1]));
sWenner:=arrspanname[1];
pnlUitslae.Hide;
exit;
end;
memToernooi.Lines.Add(#13+#13+#13+'Rondte '+IntToStr(irondte)+' :'+#13);
i:=1;
  while  i<=ispanne do
  begin
    if arrSpanname[i+1]='' then
    memToernooi.Lines.Add(arrspanname[i]+' word deur gelaat na die volgende ronde')
    else
    memToernooi.Lines.Add(arrspanname[i]+'('+Inttostr(arrspanids[i]) +') VS ('+arrspanname[i+1]+inttostr(arrspanids[i+1])+')');
    frmWelkom.tblWedstrydInfo.Append;
    frmWelkom.tblWedstrydInfo['Wedstryd ID']:=arrSpanname[i]+'('+ inttostr(arrSpanIDs[i])+')'+'VS'+arrSpanname[i+1]+'('+inttostr(arrSpanIDs[i+1])+')';
    frmWelkom.tblWedstrydInfo['Span ID 1']:=arrSpanIDs[i];
    frmWelkom.tblWedstrydInfo['Span ID 2']:=arrSpanIDs[i+1];
    frmWelkom.tblWedstrydInfo['Voltooi']:='False';
    Inc(i,2);
  end;
end;

pnlUitslae.Hide;
end;

procedure TfrmOrganiseerder.btnOkClick(Sender: TObject);
var
I,j, ipos:integer;
sNaam, sOuderdomsgroep, sWagwoord, sDatum,sDatumFinal, sLyn:string;
bFlag, bValid:boolean;
cKode:char;
begin

if redSpanname.Lines.Count>20 then
begin
  ShowMessage('Die maksimum getal spanne wat mag deelneem is 20');
  exit;
end
else
begin
bFlag:=false;//initialiseer die boolean veranderlike
 for i := 0 to redSpanname.Lines.Count do //For-loop wat deur die hele rich edit gaan "hardloop"
 begin
  snaam:=redSpanname.Lines[i];
   for j := 1 to Length(sNaam) do //For loop wat deur die spannaam gaan "hardloop" en toets vir nommers
   begin
    if  (sNaam[j] in ['0'..'9'] ) or (snaam='')then  //indien n nommer gevind word gaan die volgende gebeur
    begin
     ShowMessage('Maak seker dat daar geen nommers of oop lyntjies is nie');
     bFlag:=true ;//maak die boolean veranderlike true om lateraan die verwerking te stop
     Exit;//Gaan uit die for-loop
    end;
   end;
 end;
end;

 if bFlag=true then
 Exit; //Stop met verdere verwerking indien die invoerwaarde verkeerd is




 bFlag:=false;
 if edtOuderdomsgroep.Text='' then
 begin
   ShowMessage('Vul asseblief die ouderdomsgroep van al die spanne in');
   bFlag:=true;
 end;
 if bflag=true then
 exit;

 for i := 1 to Length(edtOuderdomsgroep.Text) do
  begin
   if Not (edtOuderdomsgroep.Text[i] in ['O','/','0'..'9','A'..'C']) then
    begin
     bflag:=true;
    end;
  end;
  if bFlag=true then
  begin
  ShowMessage('U moet die ouderdomsgroep in die regte formaat intik');
  Exit
  end
  else
  begin
  sOuderdomsgroep:=edtOuderdomsgroep.Text;
  edtOuderdomsgroep.Enabled:=false;
  end;

ispanne:=redSpanname.Lines.Count-1;
for i := 1 to ispanne do
begin
 arrSpanname[i]:=redSpanname.Lines[i];
 if arrSpanname[i]='' then
 begin
   ShowMessage('Maak seker dat daar geen oop lyntjies in die teks boksie is nie.');
   exit;
 end;
end;
redSpanname.Enabled:=false;

i:=1;
frmWelkom.tblSpanInfo.Open;
frmWelkom.tblSpanInfo.First;
ShowMessage('U moet die span afrigters se name reg spel, sodat die afrigter later met sy naam en wagwoord kan inteken');
for j := 1 to iSpanne do  
begin
 frmWelkom.tblSpanInfo.Append;  //Stel die tabel sodat daar nuwe rekords bygevoeg kan word
 frmWelkom.tblSpanInfo['Span ID']:=j;
 frmWelkom.tblSpanInfo['Span Naam']:=arrSpanname[j];
 frmWelkom.tblSpanInfo['Ouderdomsgroep']:=sOuderdomsgroep;
 frmWelkom.tblSpanInfo['Afrigter']:=InputBox('Afrigter','Tik die afrigter van '+arrSpanname[j]+' se naam in','');
 bValid:=false;
 while bvalid=false do
 begin
 bvalid:=true;
 sdatum:=InputBox( 'Inskrywingsdatum','Tik die datum in die formaat: dd/mm/jjjj','');
 sDatumFinal:=sdatum;
    ipos:=Pos('/',sDatum);
    sLyn:=Copy(sDatum,1,ipos-1);
    if not (Length(slyn)=2) then
    bvalid:=false;

    Delete(sDatum,1,ipos);
    ipos:=Pos('/',sDatum);
    sLyn:=Copy(sDatum,1,ipos-1);
    if not (Length(slyn)=2) then
    bvalid:=false;

    Delete(sDatum,1,ipos);
    if not (Length(sDatum)=4) then
    bvalid:=false;

 if bvalid=true then
 begin
 frmWelkom.tblSpanInfo['Inskrywingsdatum']:=StrToDate(sDatumFinal);
 end
 else
 begin
 ShowMessage('U moet die datum in die regte formaat intik');
 bvalid:=false;
 end;
 end;
 swagwoord:='';
 for I := 1 to 4 do      //For loop om die span se wagwoord se eerste deelte genereer
  begin
   sWagwoord:=sWagwoord+(arrSpanname[j])[i];
  end;

 for I := 1 to 4 do      //For loop om die span se wagwoord se tweede deel te genereer
  begin
   sWagwoord:=sWagwoord+IntToStr(RandomRange(0,9)) ;
  end;
 frmWelkom.tblSpanInfo['Span password']:=sWagwoord;
 frmWelkom.tblSpanInfo.Post;
end;

dbgSpanInfo.DataSource:=frmWelkom.dsSpanInfo;
btnOk.Enabled:=false;
btnOpdateer2.Enabled:=true;
btnVerwyderRekords.Enabled:=true;




            

end;

procedure TfrmOrganiseerder.btnOpdateer2Click(Sender: TObject);
var
sVeld:string;
begin
 iSpanID:=StrToInt(InputBox('SpanID','Tik die span wie se inligting uwil verander se span ID in','')) ;
 sVeld:=InputBox('Veld','Watse veld wil u verander','');

 if (sVeld='Span ID') or (sveld='Ouderdomsgroep') or (sveld='Span password') then
 begin
   ShowMessage('Die '+LowerCase(sveld)+' kan nie verander word nie.');
 end;

 frmWelkom.tblSpanInfo.First;
 while not frmWelkom.tblSpanInfo.Eof do
 begin
   if frmWelkom.tblSpanInfo['Span ID']=iSpanID then
   begin
    if sVeld='Inskrywingsdatum' then
     begin
     frmWelkom.tblSpanInfo.Edit;
     frmWelkom.tblSpanInfo[sveld]:=strtodate(InputBox(sveld,'Tik die datum in die formaat: dd/mm/jjjj',datetostr(frmWelkom.tblSpanInfo[sveld])))  ;
     frmWelkom.tblSpanInfo.Post;
     end
    else
    begin
     frmWelkom.tblSpanInfo.Edit;
     frmWelkom.tblSpanInfo[sveld]:=InputBox(sveld,'Tik die verandering in',frmWelkom.tblSpanInfo[sveld]);
     frmWelkom.tblSpanInfo.Post;
    end;
   end;
   frmWelkom.tblSpanInfo.Next;
 end;

end;

procedure TfrmOrganiseerder.btnOpdateerClick(Sender: TObject);
var
sWedstrydID,sVeld:string;
sScore, sWenner:string;
i:integer;
bFound:boolean;
begin
 bFound:=false;
 sWedstrydID:=InputBox('Wedstryd ID','Tik die wedstryd wat se inligting u wil verander se ID in','');
 sVeld:=(InputBox('Veld','Watse veld wil u verander',''));

 if not ((sVeld='Score') or (sVeld='Wenner'))then
 begin
   ShowMessage('Die '+LowerCase(sveld)+' kan nie verander word nie.');
 end
 else
 if sVeld='Wenner' then
 begin
 ShowMessage('Tik eers die nuwe telling in');
 end;


 frmWelkom.tblWedstrydInfo.First;
 while not frmWelkom.tblWedstrydInfo.Eof do
 begin
   if frmWelkom.tblWedstrydInfo['Wedstryd ID']=sWedstrydID then
   begin
   bfound:=true;
     frmWelkom.tblWedstrydInfo.Edit;
     sScore:=(InputBox(sveld,'Tik die nuwe telling in',frmWelkom.tblWedstrydInfo['Score']))  ;
     frmWelkom.tblWedstrydinfo['Score']:=sscore;
     for I := 1 to Length(sScore) do
       begin
        if not (sScore[i] in ['0'..'9','/']) then
        begin
          ShowMessage('Tik asseblief die telling in die formaat: Span1Telling/Span2Telling');
          exit;
        end;
       end;
     sWenner:=InputBox('Wenner','Tik die wenner se span ID in','');
     frmWelkom.tblWedstrydInfo.Post;
   end;
   frmWelkom.tblWedstrydInfo.Next;
 end;

if bfound=false then
begin
  ShowMessage('Die wedstryd ID is nie gevind nie, maak seker van die spelling en spasies.');
end;
end;

procedure TfrmOrganiseerder.btnStoorClick(Sender: TObject);
var
bFound:boolean;
i:integer;
begin
bFound:=false;


{if sedSpan2.Value=sedSpan1.Value then
begin
  ShowMessage('Indien spanne gelyk op gespeel het, moet hul aanhou speel tot ekstra punte gemaak word/ die een span opgee.');
  exit;
end;  }

frmWelkom.tblWedstrydInfo.First;
frmWelkom.tblWedstrydInfo.edit;
while not frmWelkom.tblWedstrydInfo.Eof do
begin
  if cmbSpanne.Items[cmbSpanne.ItemIndex]=frmWelkom.tblWedstrydInfo['Wedstryd ID'] then //Toets of die item in combobox gelyk is aan die wedstryd ID in die databasis Tabel
  begin
    bfound:=true;
    frmWelkom.tblWedstrydInfo.Edit;   //sit die tabel in n fase waar die program aan die tabel kan verander
    frmWelkom.tblWedstrydInfo['Score']:=IntToStr(sedSpan1.Value)+'/'+IntToStr(sedSpan2.Value);
    frmWelkom.tblWedstrydInfo.Post;//plaas die veranderinge op die tabel
    if sedSpan1.Value > sedSpan2.Value then  //As die eerste span se telling groter is as die ander
    begin
     frmWelkom.tblWedstrydInfo.Edit;
     frmWelkom.tblWedstrydInfo['Wenner']:=inttostr(frmWelkom.tblWedstrydInfo['Span ID 1']);
     frmWelkom.tblWedstrydInfo.Post;
    end
    else
    if sedSpan1.Value < sedSpan2.Value then   //as die tweede span se telling groter is as 1ste een
    begin
     frmWelkom.tblWedstrydInfo.Edit;
     frmWelkom.tblWedstrydInfo['Wenner']:=inttostr(frmWelkom.tblWedstrydInfo['Span ID 2']);
     frmWelkom.tblWedstrydInfo.Post;
    end;
    if sedSpan1.Value = sedSpan2.Value then   //as altwee tellings dieselfde
    begin
     frmWelkom.tblWedstrydInfo.Edit;
     frmWelkom.tblWedstrydInfo['Wenner']:=inttostr(0);
     frmWelkom.tblWedstrydInfo.Post;
    end;
    if frmWelkom.tblWedstrydInfo['Span ID 1']=0 then//As die een span nie bestaan nie, aangesien die ander een deur gaan
    begin
    frmWelkom.tblWedstrydInfo.Edit;
    frmWelkom.tblWedstrydInfo['Wenner']:=inttostr(frmWelkom.tblWedstrydInfo['Span ID 2']) ;  //Dan is die span wat wel bestaan die wenner
    frmWelkom.tblWedstrydInfo.Post;
    end
    else
    if frmWelkom.tblWedstrydInfo['Span ID 2']=0 then
    begin
    frmWelkom.tblwedstrydinfo.edit;
    frmWelkom.tblWedstrydInfo['Wenner']:=inttostr(frmWelkom.tblWedstrydInfo['Span ID 1']);
    frmWelkom.tblWedstrydInfo.Post;
    end;

  end;
frmWelkom.tblWedstrydInfo.Next;
end;

if bfound=false then
begin
  ShowMessage('Die wedstryd ID is nie gevind nie, kies slegs n ID uit die boksie uit, moenie aan die IDs verander nie');
  exit;
end;
sedSpan1.Value:=0;  //stel altwee die spin edits weer op 0
sedSpan2.Value:=0;

end;

procedure TfrmOrganiseerder.btnStoorSpanClick(Sender: TObject);
var
I:integer;
begin

  if bDeleted=true then //As die gebruiker rekords verwyder het:
  begin
    for i := 1 to ispanne do
    begin
      arrSpanname[i]:='';//Maak die array heeltemal skoon sodat die nuwe data in die array gelaai kan word
    end;
    i:=1;
    frmWelkom.tblSpanInfo.First;
    while not frmWelkom.tblSpanInfo.Eof do
    begin
      arrSpanname[i]:=frmWelkom.tblSpanInfo['Span Naam'];
      arrSpanIDs[i]:=frmWelkom.tblSpanInfo['Span ID'];//Gebruik n tweede skikking om die span IDs te stoor
      frmWelkom.tblSpanInfo.Next;
      Inc(i);
    end;
  end
  else
  begin
   i:=1;
   frmWelkom.tblSpanInfo.First;
    while not frmWelkom.tblSpanInfo.Eof do
    begin
      arrSpanIDs[i]:=frmWelkom.tblSpanInfo['Span ID'];
      Inc(i);
      frmWelkom.tblSpanInfo.next;
    end;
  end;
  bdeleted:=false;//sodat die globale veranderlikenie ander verwerkings verkeerd laat loop nie (ek gebruik die veranderlike in n ander knoppie ook)
ispanne:=i-1;


memToernooi.Lines.Add('Rondte 1 :'+#13);
if iToernooiFormaat=0 then
begin
i:=1;
  while  i<=ispanne do   //terwyl die teller kleiner is as die hoeveelheid spanne wat nog deelneemS
  begin
    if arrSpanname[i+1]='' then  //as daar nie nog n span is vir die laaste span om teen te speel
    begin
    memToernooi.Lines.Add(arrspanname[i]+' word deur gelaat na die volgende rondte');
    frmWelkom.tblWedstrydInfo.Append;
    frmWelkom.tblWedstrydInfo['Wedstryd ID']:=arrSpanname[i]+'('+ inttostr(arrSpanIDs[i])+') VS Geen';
    frmWelkom.tblWedstrydInfo['Span ID 1']:=arrSpanIDs[i];
    frmWelkom.tblWedstrydInfo['Span ID 2']:=0;
    frmWelkom.tblWedstrydInfo['Voltooi']:='False';  //Die Voltooi veld toets later of die wedstryd al gespeel is of nie, sodat die program weet watter spanne nog deel van die toernooi is en watter uitgeval het
    Inc(i);
    end
    else
    begin
    frmWelkom.tblWedstrydInfo.Append;
    frmWelkom.tblWedstrydInfo['Wedstryd ID']:=arrSpanname[i]+'('+ inttostr(arrSpanIDs[i])+')'+' VS '+arrSpanname[i+1]+'('+inttostr(arrSpanIDs[i+1])+')';
    frmWelkom.tblWedstrydInfo['Span ID 1']:=arrSpanIDs[i];
    frmWelkom.tblWedstrydInfo['Span ID 2']:=arrSpanIDs[i+1];
    frmWelkom.tblWedstrydInfo['Voltooi']:='False';
    memToernooi.Lines.Add(frmWelkom.tblWedstrydInfo['Wedstryd ID']);
    Inc(i,2);
    end;
  end;
end;

iRondte:=1;//initialiseer die veranderlike

  pnlToernooi.Visible:=False;  //maak die panel onsigbaar
  pnlWysUitslae.Enabled:=true;
  pnlOndersoekSpanne.Visible:=true;
end;

procedure TfrmOrganiseerder.btnVerwyderClick(Sender: TObject);
var
sWedstrydID:string;
begin
bDeleted:=false;
sWedstrydID:=InputBox('Wedstryd ID','Tik die wedstryd wat u wil verwyder se ID in','');  //Gebruiker word gevra om die wedstryd id in te tik

 frmWelkom.tblWedstrydInfo.First;
 while not frmWelkom.tblWedstrydInfo.Eof do
 begin
   if frmWelkom.tblWedstrydInfo['Span ID']=sWedstrydID then
   begin
    frmWelkom.tblWedstrydInfo.Delete;
    bDeleted:=true;//stel die veranderlike as waar wanneer daar rekords verwyder word
    ShowMessage('Die rekord is suksesvol verwyder');
    exit;
   end;
 frmWelkom.tblWedstrydInfo.Next;
 end;

 if bdeleted=false then
 begin
  ShowMessage('Die Wedstryd ID wat u ingetik het is nie gevind nie, maak seker dat u reg gespel het');
 end;


end;

procedure TfrmOrganiseerder.btnVerwyderRekordsClick(Sender: TObject);
begin
iSpanID:=StrToInt(InputBox('SpanID','Tik die span wie u wil verwyder se span ID in','')) ;

 frmWelkom.tblSpanInfo.First;
 while not frmWelkom.tblSpanInfo.Eof do  //loop deur die tabel
 begin
   if frmWelkom.tblSpanInfo['Span ID']=iSpanID then
   begin
    frmWelkom.tblSpanInfo.Delete;
    bDeleted:=true;//stel die veranderlike as waar wanneer daar rekords verwyder word
    ShowMessage('Die span is suksesvol verwyder');
    exit;
   end;
 frmWelkom.tblSpanInfo.Next;
 end;


end;

procedure TfrmOrganiseerder.FormCreate(Sender: TObject);
begin
pnlOndersoekSpanne.Visible:=false;
pnlUitslae.Visible:=false;
bDeleted:=false;//Stel die boolean toets-veranderlike as vals

with GR11PAT_u.frmWelkom  do
begin
conDB.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\Hanre Delport\IT PAT GR11\Program\Toernooi_DB.mdb;Persist Security Info=False;Jet OLEDB:Database Password= $$$***###';
tblSpanInfo.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Toernooi_DB.mdb;Persist Security Info=False;Jet OLEDB:Database Password= $$$***###';
tblWedstrydInfo.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Toernooi_DB.mdb;Persist Security Info=False;Jet OLEDB:Database Password= $$$***###';
tblWedstrydInfo.Open;
tblSpanInfo.Open;
end;        //kode om die databasis met die delphi program te konnekteer


dbgWedstrydInfo.DataSource:=GR11PAT_u.frmWelkom.dsWedstrydInfo;
dbgSpanInfo.DataSource:=GR11PAT_u.frmWelkom.dsSpanInfo;//kode om die tabel te wys op die dbgrid


pnlToernooi.Visible:=false; //maak die "panel" onsigbaar
pnlUitslae.Visible:=false;
pnlWysUitslae.Enabled:=false;//"Disable" die "panel"-komponent sodat die gebruiker nie op dit kan kliek voordat 'n toernooi formaat gekies is nie

with GR11PAT_u.frmWelkom do
begin
 tblSpanInfo.First;
 while not  tblSpanInfo.Eof do
  begin
  tblSpanInfo.Delete;
  //tblSpanInfo.Next;
  end;


 tblWedstrydInfo.First;
 while not  tblWedstrydInfo.Eof do
  begin
  tblWedstrydInfo.Delete;
  //tblWedstrydInfo.Next;
  end;

end;

end;

procedure TfrmOrganiseerder.pnlGenereerClick(Sender: TObject);
var
sspannaam:string;
begin
if rgpFormaat.ItemIndex=0 then
begin
 iToernooiFormaat:=rgpFormaat.ItemIndex;
 pnlToernooi.Visible:=true;  //Maak die panel sigbaar
 rgpFormaat.Enabled:=false; //"Disable" radiogroup sodat die gebruiker nie later 'n ander toernooi format kan kies nie.
 rgpFormaat.Visible:=false;
 pnlGenereer.Visible:=false;
end
else
if rgpFormaat.ItemIndex=-1 then //as daar geen formaat gekies is nie
begin
ShowMessage('U moet asseblief ''n toernooi formaat kies');     //boodskap om die gebruiker in te lig
end;
if rgpFormaat.ItemIndex=1 then
ShowMessage('As gevolg van enkele tegniese probleme kan die program ongelukkig nie n toernooi in die formaat genereer nie');

btnStoor.Enabled:=false;
btnOpdateer2.Enabled:=false;
btnVerwyderRekords.Enabled:=false;
sedSpan2.MinValue:=0;
sedSpan2.MaxValue:=100;
sedSpan1.MinValue:=0;//stel min waarde wat die spin edit kan he
sedSpan1.MaxValue:=100;//stel die maksimum waarde wat die spin edit kan he

end;

procedure TfrmOrganiseerder.pnlOndersoekSpanneClick(Sender: TObject);
begin
pnlToernooi.Visible:=true;
lblHoeveelSpanne.Visible:=false ;
redSpanname.Visible:=false;
Label3.Visible:=false;
edtOuderdomsgroep.Visible:=false;
btnOk.Visible:=false;
btnVerwyderRekords.Visible:=false;
btnStoorSpan.Visible:=false;
end;

procedure TfrmOrganiseerder.pnlWysUitslaeClick(Sender: TObject);
var
i:integer;
begin
sedSpan1.MinValue:=0;
sedSpan2.MinValue:=0;
pnlUitslae.Visible:=true;
btnStoor.Enabled:=true;

for i := 1 to cmbSpanne.Items.Count do//verwyder al die wedstryd IDs voordat nuwes bygevoeg word
  begin
   cmbSpanne.Items.Delete(i);
  end;

frmWelkom.tblWedstrydInfo.first;//Voeg nuwe wedstryd IDs by
while not frmWelkom.tblWedstrydInfo.Eof do
begin
  cmbSpanne.Items.Add(frmWelkom.tblWedstrydInfo['Wedstryd ID']) ;
  frmWelkom.tblWedstrydInfo.Next;
end;

//showmessage('Indien spanne gelyk op gespeel het, moet hul aanhou speel tot ekstra punte gemaak word/ die een span opgee.');
dbgWedstrydInfo.Columns[0].Width:=130;   //stel die breedte van al diekollomme in die databasis "grid"
dbgWedstrydInfo.Columns[1].Width:=70;
dbgWedstrydInfo.Columns[2].Width:=70;
dbgWedstrydInfo.Columns[3].Width:=70;
dbgWedstrydInfo.Columns[4].Width:=70;
dbgWedstrydInfo.Columns[5].Width:=70;
dbgWedstrydInfo.DataSource:=frmWelkom.dsWedstrydInfo;






end;

end.
