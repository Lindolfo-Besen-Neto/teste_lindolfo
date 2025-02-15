unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TF_Principal = class(TForm)
    mnMenu: TMainMenu;
    N1: TMenuItem;
    mnRelatorios: TMenuItem;
    mnRel_GestaoVendas: TMenuItem;
    procedure mnRel_GestaoVendasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Principal: TF_Principal;

implementation

{$R *.dfm}

uses URel_GestaoVendas, USessao;

procedure TF_Principal.FormShow(Sender: TObject);
begin
  // FUN��O USADA PARA FAZER A CONEX�O COM O BANCO DE DADOS
  try
  if not funcConexao then
    showmessage('Problema de conex�o.');
  finally
  end;
end;

procedure TF_Principal.mnRel_GestaoVendasClick(Sender: TObject);
begin
  // CONECTANDO ANTES DE ENTRAR NA TELA.
  try
  if funcConexao then
  begin
    // CHAMANDO A TELA DO RELAT�RIO DE VENDAS
    if F_Rel_GestaoVendas = Nil then
      Application.CreateForm(TF_Rel_GestaoVendas, F_Rel_GestaoVendas);
    F_Rel_GestaoVendas.Show;
  end
  else
    showmessage('Problema de conex�o.');

  finally
  end;
end;

end.
