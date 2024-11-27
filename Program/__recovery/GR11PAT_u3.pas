unit GR11PAT_u3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls, Buttons, ComCtrls;

type
  TfrmAfrigter = class(TForm)
    imgBackground: TImage;
    pnlLogo: TPanel;
    bbnExit: TBitBtn;
    pnlVerander: TPanel;
    pnlWysPrestasie: TPanel;
    pnlPrestasie: TPanel;
    cmbNaam: TComboBox;
    lblKiesSpan: TLabel;
    edtWagwoord: TEdit;
    redPrestasies: TRichEdit;
    pnlSpanlys: TPanel;
    btnStoorVeranderinge: TButton;
    sbtnStoor: TButton;
    edtAfrigter: TEdit;
    bbnTerugUitSpanlys: TBitBtn;
    bbnTerugUitSpanprestasie: TBitBtn;
    redSpanlys: TRichEdit;
    lblVulNameIn: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAfrigter: TfrmAfrigter;

implementation

{$R *.dfm}

end.
