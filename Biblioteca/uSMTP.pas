unit uSMTP;

interface
uses IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase,Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,Dialogs,Forms,
  Vcl.Controls;

function EnviaEmail(Assunto:String;Destinatario:String;AnexoXML:String;Dados: TStringList):Boolean;
implementation

function EnviaEmail(Assunto:String;Destinatario:String;AnexoXML:String;Dados: TStringList):Boolean;
var
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
  sAnexo: string;
begin
  Screen.Cursor := crHourGlass;
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  IdSMTP := TIdSMTP.Create(Application);
  IdMessage := TIdMessage.Create(Application);

  with IdSSLIOHandlerSocket do
  begin
    with SSLOptions do
    begin
      mode:= sslmClient;
      Method:= sslvTLSv1_2
    end;
    host := 'smtp.office365.com';
    port:= 587;
  end;

  with  IdSMTP do
  begin
    IOHandler := IdSSLIOHandlerSocket;
    host := 'smtp.office365.com';
    port:= 587;
    AuthType := satDefault;
    username:= 'cadastroclientes10082004@outlook.com';
    Password:= 'luizr665';
    UseTLS:= utUseExplicitTLS;
  end;

  with IdMessage do
  begin
    from.Address := 'cadastroclientes10082004@outlook.com';
    from.Name :=  'CadastroClientes InfoSistemas - Luiz Ricardo';
    Recipients.Add;
    Recipients.Items[0].Address := Destinatario;
    Subject := Assunto;
    Body.Add('Olá, esta é uma mensagem Automática, favor não responder!');
    Body.Add('Novo cliente cadastrado!:');
    Body.Add('');
    Body.Add('*NOME: '+Dados[0]);
    Body.Add('*CPF: '+Dados[1]);
    Body.Add('*IDENTIDADE: '+Dados[2]);
    Body.Add('*TELEFONE: '+Dados[3]);
    Body.Add('*EMAIL: '+Dados[4]);
    Body.Add(' ENDEREÇO');
    Body.Add('   *CEP: '+Dados[5]);
    Body.Add('   *LOGRADOURO: '+Dados[6]);
    Body.Add('   *NUMERO: '+Dados[7]);
    Body.Add('   *COMPLEMENTO: '+Dados[8]);
    Body.Add('   *BAIRRO: '+Dados[9]);
    Body.Add('   *CIDADE: '+Dados[10]);
    Body.Add('   *ESTADO: '+Dados[11]);
    Body.Add('   *PAIS: '+Dados[12]);
    Body.Add('');
    Body.Add('');
    Body.Add('|-| Cadastro de Clientes - Luiz Ricardo da Silva |-|');

  end;

    sAnexo := AnexoXML;
    if FileExists(sAnexo) then
    begin
      TIdAttachmentFile.Create(IdMessage.MessageParts, sAnexo);
    end;

  try
     IdSMTP.Connect;
     IdSMTP.send(IdMessage);
     Screen.Cursor := crDefault;
     Application.MessageBox('Email Enviado!','Cadastro de Clientes Info');
  except
     on E: exception do
    showmessage('Ocorreu um erro ao tentar fazer o envio do e-mail. Mensagem de erro: '+e.Message);
  end;


end;
end.
