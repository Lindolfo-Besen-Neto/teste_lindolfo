program TESTE_LINDOLFO;

uses
  Vcl.Forms,
  UPrincipal in 'Fontes\UPrincipal.pas' {F_Principal},
  uDmPrincipal in 'Fontes\DM\uDmPrincipal.pas' {DmPrincipal: TDataModule},
  URel_GestaoVendas in 'Fontes\URel_GestaoVendas.pas' {F_Rel_GestaoVendas},
  USessao in 'Fontes\USessao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Principal, F_Principal);
  Application.CreateForm(TDmPrincipal, DmPrincipal);
  Application.Run;
end.
