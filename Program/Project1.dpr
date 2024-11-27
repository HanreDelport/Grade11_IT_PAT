program Project1;

uses
  Forms,
  GR11PAT_u in 'GR11PAT_u.pas' {frmWelkom},
  GR11PAT_u2 in 'GR11PAT_u2.pas' {frmOrganiseerder},
  GR11PAT_u3 in 'GR11PAT_u3.pas' {frmAfrigter},

  dbm_Database in 'dbm_Database.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelkom, frmWelkom);
  Application.CreateForm(TfrmOrganiseerder, frmOrganiseerder);
  Application.CreateForm(TfrmAfrigter, frmAfrigter);
 // Application.CreateForm(TfrmDatabase, frmDatabase);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
