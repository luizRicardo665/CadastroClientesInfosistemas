object FCadastroClientes: TFCadastroClientes
  Left = 0
  Top = 0
  Caption = 'Cadastro de Clientes'
  ClientHeight = 342
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 797
    Height = 342
    ActivePage = TabPageCadastro
    Align = alClient
    TabOrder = 0
    object TabPageCadastro: TTabSheet
      Caption = 'Cadastro'
      object gpbDadosCliente: TGroupBox
        Left = 0
        Top = 29
        Width = 789
        Height = 133
        Align = alTop
        Caption = 'Dados do Cliente'
        TabOrder = 0
        ExplicitTop = 23
        object lblNome: TLabel
          Left = 17
          Top = 15
          Width = 103
          Height = 13
          Caption = 'Nome / Raz'#227'o Social*'
        end
        object lblIdentidade: TLabel
          Left = 383
          Top = 17
          Width = 83
          Height = 13
          Caption = 'Identidade (RG)*'
        end
        object lblCPF: TLabel
          Left = 503
          Top = 17
          Width = 25
          Height = 13
          Caption = 'CPF*'
        end
        object lblTelefone: TLabel
          Left = 647
          Top = 17
          Width = 48
          Height = 13
          Caption = 'Telefone*'
        end
        object lblEmail: TLabel
          Left = 17
          Top = 65
          Width = 30
          Height = 13
          Caption = 'Email*'
        end
        object edtNomeRazaoSocial: TEdit
          Left = 16
          Top = 34
          Width = 361
          Height = 21
          MaxLength = 210
          TabOrder = 0
          OnKeyPress = edtNomeRazaoSocialKeyPress
        end
        object edtIdentidade: TEdit
          Left = 385
          Top = 34
          Width = 114
          Height = 21
          MaxLength = 10
          TabOrder = 1
          OnKeyPress = edtIdentidadeKeyPress
        end
        object edtEmail: TEdit
          Left = 16
          Top = 84
          Width = 361
          Height = 21
          MaxLength = 210
          TabOrder = 4
        end
        object edtCPF: TMaskEdit
          Left = 505
          Top = 34
          Width = 132
          Height = 21
          EditMask = '###.###.###-##;0;_'
          MaxLength = 14
          TabOrder = 2
          Text = ''
        end
        object edtTelefone: TMaskEdit
          Left = 643
          Top = 36
          Width = 125
          Height = 21
          EditMask = '(##)#########;0;_'
          MaxLength = 13
          TabOrder = 3
          Text = ''
        end
      end
      object gpbEndereco: TGroupBox
        Left = 0
        Top = 162
        Width = 789
        Height = 152
        Align = alClient
        Caption = 'Endere'#231'o'
        TabOrder = 1
        ExplicitTop = 156
        ExplicitHeight = 158
        object lblCEP: TLabel
          Left = 16
          Top = 24
          Width = 25
          Height = 13
          Caption = 'CEP*'
        end
        object lblLogradouro: TLabel
          Left = 151
          Top = 24
          Width = 61
          Height = 13
          Caption = 'Logradouro*'
        end
        object lblBairro: TLabel
          Left = 647
          Top = 24
          Width = 34
          Height = 13
          Caption = 'Bairro*'
        end
        object lblNumero: TLabel
          Left = 503
          Top = 21
          Width = 43
          Height = 13
          Caption = 'N'#250'mero*'
        end
        object lblComplemento: TLabel
          Left = 16
          Top = 77
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object lab: TLabel
          Left = 528
          Top = 95
          Width = 146
          Height = 16
          Caption = '* Campos Obrigatorios'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblCidade: TLabel
          Left = 151
          Top = 77
          Width = 39
          Height = 13
          Caption = 'Cidade*'
        end
        object lblUf: TLabel
          Left = 327
          Top = 77
          Width = 19
          Height = 13
          Caption = 'UF*'
        end
        object lblPais: TLabel
          Left = 407
          Top = 76
          Width = 25
          Height = 13
          Caption = 'Pa'#237's*'
        end
        object edtLogradouro: TEdit
          Left = 151
          Top = 40
          Width = 346
          Height = 21
          MaxLength = 210
          TabOrder = 1
          OnKeyPress = edtLogradouroKeyPress
        end
        object edtBairro: TEdit
          Left = 647
          Top = 40
          Width = 138
          Height = 21
          MaxLength = 210
          TabOrder = 3
          OnKeyPress = edtBairroKeyPress
        end
        object edtNumero: TEdit
          Left = 503
          Top = 40
          Width = 138
          Height = 21
          TabOrder = 2
          OnKeyPress = edtNumeroKeyPress
        end
        object edtComplemento: TEdit
          Left = 16
          Top = 95
          Width = 129
          Height = 21
          MaxLength = 210
          TabOrder = 4
        end
        object edtCidade: TEdit
          Left = 151
          Top = 95
          Width = 170
          Height = 21
          TabOrder = 5
        end
        object edtUF: TEdit
          Left = 327
          Top = 95
          Width = 74
          Height = 21
          TabOrder = 6
        end
        object edtPais: TEdit
          Left = 407
          Top = 95
          Width = 90
          Height = 21
          TabOrder = 7
        end
        object edtCEP: TMaskEdit
          Left = 16
          Top = 40
          Width = 129
          Height = 21
          EditMask = '#####-###;0;_'
          MaxLength = 9
          TabOrder = 0
          Text = ''
          OnExit = edtCEPExit
        end
      end
      object ActionToolBar1: TActionToolBar
        Left = 0
        Top = 0
        Width = 789
        Height = 29
        ActionManager = atmCadastro
        BiDiMode = bdRightToLeft
        Caption = 'ActionToolBar1'
        Color = clMenuBar
        ColorMap.DisabledFontColor = 7171437
        ColorMap.HighlightColor = clWhite
        ColorMap.BtnSelectedFont = clBlack
        ColorMap.UnusedColor = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Orientation = boRightToLeft
        ParentBiDiMode = False
        ParentFont = False
        Spacing = 0
      end
    end
    object TabPagePrincipal: TTabSheet
      Caption = 'Principal'
      ImageIndex = 1
      object GridClientes: TDBGrid
        Left = 0
        Top = 26
        Width = 789
        Height = 288
        Align = alClient
        DataSource = DsClientes
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = GridClientesDblClick
      end
      object ActionToolBar2: TActionToolBar
        Left = 0
        Top = 0
        Width = 789
        Height = 26
        ActionManager = atmCadastro
        BiDiMode = bdRightToLeft
        Caption = 'ActionToolBar2'
        Color = clMenuBar
        ColorMap.DisabledFontColor = 7171437
        ColorMap.HighlightColor = clWhite
        ColorMap.BtnSelectedFont = clBlack
        ColorMap.UnusedColor = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Orientation = boRightToLeft
        ParentBiDiMode = False
        ParentFont = False
        Spacing = 0
      end
    end
  end
  object DsClientes: TDataSource
    DataSet = CDSClientes
    Left = 628
    Top = 273
  end
  object CDSClientes: TClientDataSet
    PersistDataPacket.Data = {
      850100009619E0BD01000000180000000E000000000003000000850102494404
      000100000000000A4944454E5449444144450100490000000100055749445448
      0200020014000343504601004900000001000557494454480200020014000854
      454C45464F4E4501004900000001000557494454480200020014000343455001
      00490000000100055749445448020002001400064E554D45524F040001000000
      0000025546010049000000010005574944544802000200140004504149530100
      490000000100055749445448020002001400114E4F4D455F52415A414F5F534F
      4349414C010049000000010005574944544802000200D20005454D41494C0100
      49000000010005574944544802000200D2000A4C4F475241444F55524F010049
      000000010005574944544802000200D200064349444144450100490000000100
      0557494454480200020014000B434F4D504C454D454E544F0100490000000100
      05574944544802000200D2000642414952524F01004900000001000557494454
      4802000200D2000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 620
    Top = 128
    object CDSClientesID: TIntegerField
      DisplayLabel = 'Identificador'
      DisplayWidth = 5
      FieldName = 'ID'
    end
    object CDSClientesIDENTIDADE: TStringField
      DisplayLabel = 'Identidade'
      FieldName = 'IDENTIDADE'
      Visible = False
    end
    object CDSClientesCPF: TStringField
      DisplayWidth = 15
      FieldName = 'CPF'
    end
    object CDSClientesTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 15
      FieldName = 'TELEFONE'
    end
    object CDSClientesCEP: TStringField
      DisplayWidth = 15
      FieldName = 'CEP'
    end
    object CDSClientesNUMERO: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
      Visible = False
    end
    object CDSClientesUF: TStringField
      DisplayLabel = 'Uf'
      DisplayWidth = 5
      FieldName = 'UF'
    end
    object CDSClientesPAIS: TStringField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'PAIS'
    end
    object CDSClientesNOME_RAZAO_SOCIAL: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME_RAZAO_SOCIAL'
      Size = 210
    end
    object CDSClientesEMAIL: TStringField
      DisplayLabel = 'E-Mail'
      FieldName = 'EMAIL'
      Size = 210
    end
    object CDSClientesLOGRADOURO: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'LOGRADOURO'
      Size = 210
    end
    object CDSClientesCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
    end
    object CDSClientesCOMPLEMENTO: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'COMPLEMENTO'
      Size = 210
    end
    object CDSClientesBAIRRO: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Size = 210
    end
  end
  object atmCadastro: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = actInserir
            Caption = '&Inserir'
            ImageIndex = 0
          end
          item
            Action = ActExcluir
            Caption = '&Excluir'
          end>
      end
      item
        Items = <
          item
            Action = actInserir
            Caption = '&Inserir'
            ImageIndex = 0
          end
          item
            Action = ActExcluir
            Caption = '&Excluir'
          end>
        ActionBar = ActionToolBar2
      end
      item
        Items = <
          item
            Action = actSalvar
          end
          item
            Action = actCancelar
            Caption = '&Cancelar'
          end>
        ActionBar = ActionToolBar1
      end>
    Left = 492
    Top = 141
    StyleName = 'Platform Default'
    object actInserir: TAction
      Category = 'Principal'
      AutoCheck = True
      Caption = 'Inserir'
      ImageIndex = 0
      OnExecute = actInserirExecute
    end
    object ActExcluir: TAction
      Category = 'Principal'
      Caption = 'Excluir'
      OnExecute = ActExcluirExecute
    end
    object actSalvar: TAction
      Caption = 'Salvar'
      OnExecute = actSalvarExecute
    end
    object actCancelar: TAction
      Caption = 'Cancelar'
      OnExecute = actCancelarExecute
    end
  end
end
