unit UBiblioteca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, Datasnap.DBClient,Vcl.ExtCtrls,System.JSON, IdHTTP,rest.Client,IdSSLOpenSSL;

  Function ValidaCPF(CPF:String):Boolean;
  Function ValidaEMail(EMailIn: string):Boolean;
  Function ValidaCep(CEP:String):boolean;
  function BuscarCEPNoViaCEP(CEP: string): TStringlist;
  function LimpaCampo(Form :TForm) :Boolean;
  procedure RetiraCaracterEspecial;

implementation
uses Sysutils;
procedure RetiraCaracterEspecial;
var
  Key: char;
Begin

end;

Function ValidaEMail(EMailIn: string):Boolean;
begin
 EMailIn := Trim(UpperCase(EMailIn));
 if Pos('@', EMailIn) > 1 then
 begin
   Delete(EMailIn, 1, pos('@', EMailIn));
   Result := (Length(EMailIn) > 0) and (Pos('.', EMailIn) > 2);
 end
 else
   Result := False;
end;

function LimpaCampo(Form :TForm) :Boolean;
var I: Integer;
begin
  for i := 0 to Form.ComponentCount-1 do
    begin
      if(Form.Components[i] is TEdit)then
       TEdit(Form.Components[i]).Clear;
      if(Form.Components[i] is TMaskEdit) then
       TMaskEdit(Form.Components[i]).clear;
    end;
    LimpaCampo := True;
end;

Function ValidaCep(CEP:String):boolean;
const
  INVALID_CHARACTER = -1;
begin
  Result := True;
  if CEP.Trim.Length <> 8 then
  begin
    ShowMessage('CEP Invalido')  ;
    Abort;
  end;
  if StrToIntDef(CEP, INVALID_CHARACTER) = INVALID_CHARACTER then
  begin
    ShowMessage('CEP Inválido');
    Abort;
  end;
end;

function BuscarCEPNoViaCEP(CEP: string): TStringlist;
var
  data: TJSONObject;
  RESTClient1: TRESTClient;
  RESTRequest1: TRESTRequest;
  RESTResponse1: TRESTResponse;
  Endereco: TStringList;
begin
 Screen.Cursor := crHourGlass;
  RESTClient1 := TRESTClient.Create(nil);
  RESTRequest1 := TRESTRequest.Create(nil);
  RESTResponse1 := TRESTResponse.Create(nil);
  RESTRequest1.Client := RESTClient1;
  RESTRequest1.Response := RESTResponse1;
  RESTClient1.BaseURL := 'https://viacep.com.br/ws/' + CEP + '/json';
  RESTRequest1.Execute;
  data := RESTResponse1.JSONValue as TJSONObject;
  try

    Endereco := TStringList.Create;
    if Assigned(data) then
    begin
        try
          Endereco.Add(data.Values['uf'].Value);
        except
         on Exception do
           Endereco.Add('');
        end;
        try
          Endereco.Add(data.Values['localidade'].Value);
        except
         on Exception do
           Endereco.Add('');
        end;
        try
          Endereco.Add('Brasil').ToString;
        except
          on Exception do
          Endereco.add('');
        end;
    end;

  finally
    screen.Cursor := crDefault;
    FreeAndNil(data);
  end;
  Result := Endereco;
end;

function ValidaCPF(CPF: String): Boolean;
var
  vCpf: array[0..10] of Integer;
  I, vSum, vRest: Integer;
begin
  Result := False;
  if Length(CPF) <> 11 then
    Exit;

  for I := 1 to 11 do
  begin
    if not TryStrToInt(CPF[I], vCpf[I-1]) then
      Exit;
  end;

  vSum := 0;
  for I := 0 to 8 do
  begin
    vSum := vSum + vCpf[I] * (10 - I);
  end;
  vRest := 11 - (vSum mod 11);
  if (vRest = 10) or (vRest = 11) then
    vRest := 0;
  if vRest <> vCpf[9] then
    Exit;

  vSum := 0;
  for I := 0 to 9 do
  begin
    vSum := vSum + vCpf[I] * (11 - I);
  end;
  vRest := 11 - (vSum mod 11);
  if (vRest = 10) or (vRest = 11) then
    vRest := 0;
  if vRest <> vCpf[10] then
    Exit;

  Result := True;
end;

end.
