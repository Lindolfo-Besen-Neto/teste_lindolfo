Início do teste> 10/07/2024

PROEJETO DESENVOLVIDO EM DELPHI XE8.

Objetivo:

Visualização de dados de gestão de vendas com comissão por vendedor.


Banco de Dados:

Nome> MS SQLSERVER
Versão>
	SQL Server Management Studio					20.0.70.0
	SMO (SQL Server Management Objects)				17.100.30.0+d2e3ee2ef118314e85d3e8913acb6f6398c35ee2
	Microsoft T-SQL Parser						17.2.0.1+5acb7bccd5994766af519cfde20711a61b70cd9f.5acb7bccd5994766af519cfde20711a61b70cd9f
	Ferramentas de Cliente do Microsoft Analysis Services		20.0.3.0
	Microsoft Data SqlClient (MDS)					5.1.4
	Microsoft SQL Server Data-Tier Application Framework (DacFX)	162.2.111.2+1a4d708fee9d82fe4e01e02f3962d1e83d374807.1a4d708fee9d82fe4e01e02f3962d1e83d374807
	Microsoft .NET Framework					4.0.30319.42000
	Sistema Operacional						10.0.19045

Criar um novo banco de dados:

Nome > TESTE_LINDOLFO
Usuário>
	Criar um usuario no banco de dados vinculado ao sa:
	Nome>  lindolfo_user
	Senha> lindolfo_pwd
	Autênticação> Autenticação SQL Server
	Impor politica de senha> desmarcar
	Funções> marcar sysadmin
	Mapeamento de usuário> Selecionar o banco TESTE_LINDOLFO e marcar DB_OWNER
RESTAURAR > Restaure o backup que esta na pasta Banco de Dados com o nome <TESTE_LINDOLFO_2024-07-15.bkp>

SISTEMA:

Delphi XE8 com FastReport

PROJETO Baixar o projeto que esta dentro do repositorio Delphi para a pasta C:\Trabalho\Lindolfo\Delphi

Abrir o projeto TESTE_LINDOLFO.

Abrir o datamodulo <uDmPrincipal>.

Alterar os parametros de conexão do FDconnection (DBTeste):
User_Name=lindolfo_user
Password=lindolfo_pwd
Server=CAFI-DEVELOPER\SQLEXPRESS (SUBSTITUA AQUI PELO NOME DE SEU SERVIDOR\INSTÂNCIA)
Database=TESTE_LINDOLFO
Encrypt=No
DriverID=MSSQL

COMPILAR

Os arquivo compilados estão na pasta DEBUG e RELEASE do projeto.


