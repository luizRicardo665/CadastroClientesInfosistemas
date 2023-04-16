program CadastroClientesInfo;

uses
  Vcl.Forms,
  CadastroClientes in 'CadastroClientes.pas' {FCadastroClientes},
  UBiblioteca in 'Biblioteca\UBiblioteca.pas',
  uSMTP in 'Biblioteca\uSMTP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFCadastroClientes, FCadastroClientes);
  Application.Run;
end.
