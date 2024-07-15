object DmPrincipal: TDmPrincipal
  OldCreateOrder = True
  Height = 750
  Width = 1000
  object DBTeste: TFDConnection
    ConnectionName = 'DBTeste'
    Params.Strings = (
      'User_Name=lindolfo_user'
      'Password=lindolfo_pwd'
      'Server=CAFI-DEVELOPER\SQLEXPRESS'
      'Database=TESTE_LINDOLFO'
      'Encrypt=No'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 72
    Top = 56
  end
end
