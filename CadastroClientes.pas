unit CadastroClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, Datasnap.DBClient, FireDAC.Stan.StorageJSON, FireDAC.Stan.Intf,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.JSON, System.JSON, IdHTTP,DBXJSONReflect,
  rest.Client,XMLDoc, XMLIntf, IdExplicitTLSClientServerBase, IdMessageClient,IdSMTPBase, IdSMTP,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, IdMessage,
  System.ImageList, Vcl.ImgList, MaskUtils, WinInet, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, MIDASLIB, Vcl.ToolWin, Vcl.ActnCtrls ;

type
  TFCadastroClientes = class(TForm)
    PageControl1: TPageControl;
    TabPageCadastro: TTabSheet;
    gpbDadosCliente: TGroupBox;
    lblNome: TLabel;
    lblIdentidade: TLabel;
    lblCPF: TLabel;
    lblTelefone: TLabel;
    lblEmail: TLabel;
    edtNomeRazaoSocial: TEdit;
    edtIdentidade: TEdit;
    edtEmail: TEdit;
    gpbEndereco: TGroupBox;
    lblCEP: TLabel;
    lblLogradouro: TLabel;
    lblBairro: TLabel;
    lblNumero: TLabel;
    lblComplemento: TLabel;
    lab: TLabel;
    lblCidade: TLabel;
    lblUf: TLabel;
    lblPais: TLabel;
    edtLogradouro: TEdit;
    edtBairro: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtPais: TEdit;
    TabPagePrincipal: TTabSheet;
    GridClientes: TDBGrid;
    DsClientes: TDataSource;
    CDSClientes: TClientDataSet;
    CDSClientesID: TIntegerField;
    CDSClientesIDENTIDADE: TStringField;
    CDSClientesCPF: TStringField;
    CDSClientesTELEFONE: TStringField;
    CDSClientesCEP: TStringField;
    CDSClientesNUMERO: TIntegerField;
    CDSClientesUF: TStringField;
    CDSClientesPAIS: TStringField;
    CDSClientesNOME_RAZAO_SOCIAL: TStringField;
    CDSClientesEMAIL: TStringField;
    CDSClientesLOGRADOURO: TStringField;
    CDSClientesCIDADE: TStringField;
    CDSClientesCOMPLEMENTO: TStringField;
    CDSClientesBAIRRO: TStringField;
    edtCPF: TMaskEdit;
    edtTelefone: TMaskEdit;
    edtCEP: TMaskEdit;
    atmCadastro: TActionManager;
    actInserir: TAction;
    ActExcluir: TAction;
    ActionToolBar1: TActionToolBar;
    ActionToolBar2: TActionToolBar;
    actSalvar: TAction;
    actCancelar: TAction;

    procedure edtCPFKeyPress(Sender: TObject; var Key: Char);
    procedure EditCEPKeyPress(Sender: TObject; var Key: Char);
    procedure edtTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeRazaoSocialKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnsalvarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);

    procedure BtnAlteraClick(Sender: TObject);
    procedure GridClientesDblClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actInserirExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure edtIdentidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtLogradouroKeyPress(Sender: TObject; var Key: Char);
    procedure edtBairroKeyPress(Sender: TObject; var Key: Char);
  private
    procedure DoSalvar;
    procedure DoInserir;
    Procedure DoExcluir;
    procedure DoEditar;
    procedure PreencheDadosEmail;
    procedure ToHome;
    procedure ToRegister;
    procedure PreencheCampos;
    Procedure LimpaEndereco;
    function GeraXml:string;
  public
    { Public declarations }
    function ValidaAntesDeSalvar:boolean;
  end;
  var
    Dados:TstringList;
    Insere,Altera: Boolean;

var
  FCadastroClientes: TFCadastroClientes;

implementation

  uses UBiblioteca, uSMTP;

{$R *.dfm}

procedure TFCadastroClientes.edtBairroKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['A'..'Z','a'..'z','0'..'9',' ',#8]) then
 abort;
end;

procedure TFCadastroClientes.edtCEPExit(Sender: TObject);
var
  CEP: string;
  Endereco:Tstringlist;
begin
  CEP:= edtCEP.Text;
  ValidaCep(CEP);
  try
    Endereco:= BuscarCEPNoViaCEP(CEP);
  except
  end;
  if endereco.Count > 0 then
  begin
    edtUF.Text:= Endereco[0] ;
    edtCidade.Text:= Endereco[1];
    edtLogradouro.Text := Endereco[2];
    edtBairro.Text := Endereco[3];
    edtComplemento.Text := Endereco[4];
    edtPais.Text:= Endereco[5];
  end;
end;

procedure TFCadastroClientes.EditCEPKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
  key := #0;
end;

procedure TFCadastroClientes.edtIdentidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (Key in ['A'..'Z','a'..'z','0'..'9',' ',#8]) then
 abort;
end;

procedure TFCadastroClientes.edtLogradouroKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['A'..'Z','a'..'z','0'..'9',' ',#8]) then
  abort;
end;

procedure TFCadastroClientes.edtCPFKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
  key := #0;
end;

procedure TFCadastroClientes.edtNomeRazaoSocialKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (Key in ['A'..'Z','a'..'z','0'..'9',' ',#8]) then
 abort;
end;

procedure TFCadastroClientes.edtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
 if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
  key := #0;
end;


procedure TFCadastroClientes.edtTelefoneKeyPress(Sender: TObject;
  var Key: Char);
begin
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
  key := #0;
end;

procedure TFCadastroClientes.FormCreate(Sender: TObject);
begin
  TabPageCadastro.TabVisible:= false;
end;

function TFCadastroClientes.GeraXml;
var
  XMLDocument: TXMLDocument;
  Tabela, Registro, Endereco: IXMLNode;
  i: integer;
  BasePath, str: string;

begin
  BasePath := ExtractFilePath(Application.ExeName) + '\XML\';
  XMLDocument := TXMLDocument.Create(Self);
  try
    XMLDocument.Active := true;
    Tabela := XMLDocument.AddChild('cliente');

    Registro := Tabela;
    Registro.ChildValues['nome'] := CDSClientesNOME_RAZAO_SOCIAL.AsString;
    Registro.ChildValues['identidade'] := CDSClientesIDENTIDADE.AsString;
    Registro.ChildValues['cpf'] := CDSClientesCPF.AsString;
    Registro.ChildValues['telefone'] := CDSClientesTELEFONE.AsString;
    Registro.ChildValues['email'] := CDSClientesEMAIL.AsString;

    Endereco := Registro.AddChild('endereco');
    Endereco.ChildValues['cep'] := CDSClientesCEP.AsString;
    Endereco.ChildValues['lougradouro'] := CDSClientesLOGRADOURO.AsString;
    Endereco.ChildValues['numero'] := CDSClientesNUMERO.AsInteger;
    Endereco.ChildValues['complemento'] := CDSClientesCOMPLEMENTO.AsString;
    Endereco.ChildValues['bairro'] := CDSClientesBAIRRO.AsString;
    Endereco.ChildValues['cidade'] := CDSClientesCIDADE.AsString;
    Endereco.ChildValues['estado'] := CDSClientesUF.AsString;
    Endereco.ChildValues['pais'] := CDSClientesPAIS.AsString;

    if not DirectoryExists(BasePath)then
    begin
      if not CreateDir(BasePath) then
      begin
        ForceDirectories(BasePath);
      end;
    end;

    XMLDocument.SaveToFile(BasePath +
      CDSClientesNOME_RAZAO_SOCIAL.AsString + '.xml');

    result := ExtractFilePath(Application.ExeName) + '\XML\' +
      CDSClientesNOME_RAZAO_SOCIAL.AsString + '.xml';
  finally
    XMLDocument.Free;
  end;

end;



procedure TFCadastroClientes.GridClientesDblClick(Sender: TObject);
begin
  if GridClientes.Fields[0].Text = '' then
  begin
    ShowMessage('Não a Registro para Alterar/Visualizar');
    exit;
  end;
    DoEditar;
end;

procedure TFCadastroClientes.LimpaEndereco;
begin
  edtLogradouro.Text := '';
  edtComplemento.Text := '';
  edtBairro.Text := '';
  edtCidade.Text := '';
  edtUF.Text := '';
  edtCep.Text := '';
end;

procedure TFCadastroClientes.PreencheCampos;
begin

  edtNomeRazaoSocial.Text := CDSClientesNOME_RAZAO_SOCIAL.AsString;
  edtCpf.Text := CDSClientesCPF.AsString;
  edtIdentidade.Text := CDSClientesIDENTIDADE.AsString;
  edtTelefone.Text :=CDSClientesTELEFONE.AsString;
  edtEmail.Text := CDSClientesEMAIL.AsString;
  edtCep.Text := CDSClientesCEP.AsString;
  edtLogradouro.Text := CDSClientesLOGRADOURO.AsString;
  edtNumero.Text := IntToStr(CDSClientesNUMERO.AsInteger);
  edtComplemento.Text := CDSClientesCOMPLEMENTO.AsString;
  edtBairro.Text := CDSClientesBAIRRO.AsString;
  edtCidade.Text := CDSClientesCIDADE.AsString;
  edtUF.Text := CDSClientesUF.AsString;
  edtPais.Text := CDSClientesPAIS.AsString;
end;

procedure TFCadastroClientes.PreencheDadosEmail;
begin

  Dados := TStringList.Create;
  Dados.Add(edtNomeRazaoSocial.Text);
  Dados.Add(edtCpf.Text);
  Dados.Add(edtIdentidade.Text);
  Dados.Add(edtTelefone.Text);
  Dados.Add(edtEmail.Text);
  Dados.Add(edtCep.Text);
  Dados.Add(edtLogradouro.Text);
  Dados.Add(edtNumero.Text);
  Dados.Add(edtComplemento.Text);
  Dados.Add(edtBairro.Text);
  Dados.Add(edtCidade.Text);
  Dados.Add(edtUF.Text);
  Dados.Add(edtPais.Text);
end;

procedure TFCadastroClientes.BtnAlteraClick(Sender: TObject);
begin
 dosalvar;
end;

procedure TFCadastroClientes.BtnCancelarClick(Sender: TObject);
begin
  tohome;

end;

procedure TFCadastroClientes.btnInserirClick(Sender: TObject);
begin
  DoInserir;
end;

procedure TFCadastroClientes.btnsalvarClick(Sender: TObject);
begin
 dosalvar;
end;

procedure TFCadastroClientes.DoEditar;
begin
  ActSalvar.Enabled:= true;
  ToRegister;
  PreencheCampos;
  actSalvar.Visible := true;
  Insere := False;
  Altera := true;
end;

procedure TFCadastroClientes.DoExcluir;
begin
 if not CDSClientes.IsEmpty then
 if MessageDlg('Deseja excluir o registro?', mtConfirmation, mbYesNo, 0) = mrYes then
 begin
    CDSClientes.Delete;
    abort;
 end
  else
    ShowMessage('Não Existem Dados Para serem Excluídos!');
end;

procedure TFCadastroClientes.DoInserir;
begin
  actsalvar.Enabled:= true;
  actsalvar.Visible:= true;
  ToRegister;
  LimpaCampo(FCadastroClientes);
  actSalvar.Visible := true;

  Insere := true;
  Altera := False;
end;

procedure TFCadastroClientes.DoSalvar;
var
  ID: integer;
  Assunto, sDestinatario, CaminhoXML : String;
  i: dword;
begin
  ID := 0;
  Assunto := '';
   if ValidaAntesDeSalvar = false then
   begin
     Application.MessageBox('Preencha os campos Obrigatórios!','Atenção',mb_ok+MB_ICONINFORMATION) ;
     abort;
   end;

    if (Length(edtTelefone.Text) < 8) and (edtTelefone.Text <> '(  )     -    ')
    then
     begin
     ShowMessage
      ('O Número de Telefone inválido' +
      ' Digite um Número Válido!');
     edtTelefone.Clear;
     edtTelefone.SetFocus;
    end;

    if not (ValidaCPF(edtCPF.Text)) then
    begin
     application.MessageBox('CPF Invalido!','Atenção',MB_OK+MB_ICONINFORMATION);
     abort
    end
    else
    if ValidaEMail(edtEmail.Text) = false then
    begin
      application.MessageBox('Email Invalido!','Atenção',MB_OK+MB_ICONINFORMATION);
      abort;
    end
    else

    if Insere then
    BEGIN
      CDSClientes.Last;
      ID := CDSClientesID.AsInteger + 1;
      CDSClientes.Append;
    END
    else if Altera then
    BEGIN
      CDSClientes.Edit;
      ID := CDSClientesID.AsInteger;
    END;

    CDSClientesID.AsInteger := ID;
    CDSClientesNOME_RAZAO_SOCIAL.AsString := edtNomeRazaoSocial.Text;
    CDSClientesCPF.AsString := (edtCpf.Text);
    CDSClientesIDENTIDADE.AsString := edtIdentidade.Text;
    CDSClientesTELEFONE.AsString := (edtTelefone.Text);
    CDSClientesEMAIL.AsString := edtEmail.Text;
    CDSClientesCEP.AsString := (edtCEP.Text);
    CDSClientesLOGRADOURO.AsString := edtLogradouro.Text;
    CDSClientesNUMERO.AsInteger := StrToInt(edtNumero.Text);
    CDSClientesCOMPLEMENTO.AsString := edtComplemento.Text;
    CDSClientesBAIRRO.AsString := edtBairro.Text;
    CDSClientesCIDADE.AsString := edtCidade.Text;
    CDSClientesUF.AsString := edtUF.Text;
    CDSClientesPAIS.AsString := edtPais.Text;
    CaminhoXML := GeraXML;

    if Application.MessageBox
      ('Deseja Enviar Um Email Com os Dados Do Cliente Cadastrado?',
      'Pergunta do Sistema', mb_yesno + mb_iconquestion) = id_yes then
    begin
      if InternetGetConnectedState(@i, 0) then
      begin
        InputQuery('Por Favor, Informe o Destinatário', 'Destinatário',
          sDestinatario);
        PreencheDadosEmail;
        Assunto := 'Dados Cadastrais Do Cliente : "' +
          CDSClientesNOME_RAZAO_SOCIAL.AsString + '"';

        EnviaEmail(Assunto, sDestinatario, CaminhoXML, Dados);
      end
      Else
        ShowMessage
          ('Infelizmente Não é Possível Enviar o Email Porquê Você Não Está Conectado'
          + ' à Internet.')
    end;

    CDSClientes.Post;
    ToHome;
end;

procedure TFCadastroClientes.ToHome;
begin
  if not((CDSClientes.State = dsInsert) or (CDSClientes.State = dsEdit)) then
  begin
    TabPagePrincipal.TabVisible := true;
    TabPageCadastro.TabVisible := False;
    PageControl1.TabIndex := 0;
  end;
end;

procedure TFCadastroClientes.ToRegister;
begin
  PageControl1.TabIndex := 0;
  TabPagePrincipal.TabVisible := False;
  TabPageCadastro.TabVisible := true;
end;

function TFCadastroClientes.ValidaAntesDeSalvar: boolean;
begin
  result:= true;
  begin
    if edtNomeRazaoSocial.Text = '' then
      exit(false) ;
    if edtIdentidade.Text = '' then
      exit(false);
    if edtCPF.Text = '' then
      exit(false)  ;
    if edtTelefone.Text = '' then
      exit(false);
    if edtEmail.Text = '' then
      exit(false);
    if edtCep.Text = '' then
      exit(false);
    if edtLogradouro.Text = '' then
      exit(false);
    if edtNumero.Text = '' then
      exit(false) ;
    if edtBairro.Text = '' then
      exit(false) ;
    if edtCidade.Text = '' then
      exit(false);
    if edtUF.Text = '' then
      exit(false);
    if edtPais.Text = '' then
      exit(false);
  end;

end;

procedure TFCadastroClientes.actCancelarExecute(Sender: TObject);
begin
  ToHome;
end;

procedure TFCadastroClientes.ActExcluirExecute(Sender: TObject);
begin
  DoExcluir;
end;

procedure TFCadastroClientes.actInserirExecute(Sender: TObject);
begin
  DoInserir;
end;

procedure TFCadastroClientes.actSalvarExecute(Sender: TObject);
begin
   DoSalvar;
end;
end.
