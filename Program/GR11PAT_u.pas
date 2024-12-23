unit GR11PAT_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Buttons, DB, ADODB, ComCtrls;

type
  TfrmWelkom = class(TForm)
    imgBackground: TImage;
    pnlLogo: TPanel;
    pnlOrganiseerder: TPanel;
    pnlAfrigter: TPanel;
    lblGebruiker: TLabel;
    bbnExit: TBitBtn;
    conDB: TADOConnection;
    tblSpanInfo: TADOTable;
    dsSpanInfo: TDataSource;
    tblWedstrydInfo: TADOTable;
    dsWedstrydInfo: TDataSource;
    BitBtn1: TBitBtn;
    pnlHelp: TPanel;
    redTeksleer: TRichEdit;
    bbnTerugUitSpanlys: TBitBtn;
    procedure pnlOrganiseerderClick(Sender: TObject);
    procedure pnlAfrigterClick(Sender: TObject);
    procedure bbnExitClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure bbnTerugUitSpanlysClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWelkom: TfrmWelkom;

implementation
uses
GR11PAT_u2 , GR11PAT_u3;

{$R *.dfm}


procedure TfrmWelkom.bbnExitClick(Sender: TObject);
begin
Application.MainForm.Close;
end;

procedure TfrmWelkom.bbnTerugUitSpanlysClick(Sender: TObject);
begin
pnlHelp.Visible:=false;  //maak die panel onsigbaar
end;

procedure TfrmWelkom.BitBtn1Click(Sender: TObject);
var
tfile:textfile;         //declare n textfile variable
sline:string;
begin
if FileExists('frmWelkom_Help.txt') then    //Kyk of die textfile gevind word
begin
  pnlHelp.Visible:=true;  //maak die panel sigbaar
  AssignFile(tfile,'frmWelkom_Help.txt');
  Reset(tfile);
  while not Eof(tfile) do
  begin
    Readln(tfile,sline);//lees die lyntjie van die teksleer in die veranderlike in
    redTeksleer.Lines.Add(sline);
  end;
end
else
begin
  ShowMessage('Die le�r wat u wil gebruik is nie gevind nie.'); //Boodskap wat die gebruiker inlig
  exit;
end;
end;

procedure TfrmWelkom.pnlAfrigterClick(Sender: TObject);
begin
frmWelkom.Hide;
frmAfrigter.Show;
end;

procedure TfrmWelkom.pnlOrganiseerderClick(Sender: TObject);
begin
frmWelkom.Hide;
frmOrganiseerder.Show;
end;

end.
