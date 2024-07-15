object F_Principal: TF_Principal
  Left = 0
  Top = 0
  Caption = 'Sistema Teste - Lindolfo Besen Neto'
  ClientHeight = 697
  ClientWidth = 1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mnMenu
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object mnMenu: TMainMenu
    Left = 624
    Top = 352
    object N1: TMenuItem
      Caption = 'Sistema LBN'
      object mnRelatorios: TMenuItem
        Caption = 'Relat'#243'rios'
        object mnRel_GestaoVendas: TMenuItem
          Caption = 'Gest'#227'o de Vendas'
          OnClick = mnRel_GestaoVendasClick
        end
      end
    end
  end
end
