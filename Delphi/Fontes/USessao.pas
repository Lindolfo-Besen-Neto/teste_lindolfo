
{
UNIT USADA PARA CENTRALIZAR FUN��ES E PROCEDURES COMUNS A TODO SISTEMA
}


unit USessao;

interface

  // ESTABELECE CONEX�O COM O BANCO DE DADOS.
  function funcConexao: boolean;

implementation

uses uDmPrincipal;


function funcConexao: boolean;
begin
  with DmPrincipal.DBTeste do
  try
    if connected then
      Connected := false;
    connected := true;
    result := true;
  except
    result := false;
  end;
end;

end.
