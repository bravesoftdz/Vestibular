unit uUsuarioSingleton;

interface

uses
  uRESTDWPoolerDB, SysUtils, uUsuario;

type
  ExcecaoEsperada = class(Exception);
  TUsuarioSingleton = class
  private
    class var FUsuario: TUsuario;
    class var FID: Integer;
    class var FNome: String;
    class var FSenha: String;
    class var FEmail: String;
    class var FQuery: TRESTDWClientSQL;

    class var FInstance: TUsuarioSingleton;
    constructor CreatePrivate;
    class function PodeTrocarSenha(psSenhaAntiga, psSenhaNova,
      psSenhaComparacao: String): Boolean;
    class function PodeCriarUsuario(psSenha,
      psSenhaComparacao: String): Boolean; static;
    class function SenhasConferem(psSenha, psSenhaComparacao: String): Boolean; static;
    procedure Inserir(psEmail, psNome, psSenha: String);
    function Selecionar(psEmail, psSenha: string): TRESTDWClientSQL;
    procedure AlterarSenhaID(piID: integer; psSenhaNova: string);
  public
    function FazerLogin(psEmail, psSenha: String): Boolean;
    function CriarUsuario(psEmail, psNome, psSenha, psSenhaComparacao: String): Boolean;
    function AlterarSenha(psSenhaAntiga, psSenhaNova, psSenhaComparacao: String): Boolean;
    class procedure SetQuery(poQuery: TRESTDWClientSQL);

    class function GetInstance: TUsuarioSingleton;

    class property ID: Integer read FID;
    class property Nome: String read FNome;
    class property Senha: String read FSenha;
    class property Email: String read FEmail;
  end;

implementation

uses
  FMX.Dialogs, IdHashMessageDigest, DB, Firedac.Dapt;

constructor TUsuarioSingleton.CreatePrivate;
begin
  inherited Create;
  FUsuario := TUsuario.Create(nil);
end;

class function TUsuarioSingleton.GetInstance: TUsuarioSingleton;
begin
  if not Assigned(FInstance) then
    FInstance := TUsuarioSingleton.CreatePrivate;
  Result := FInstance;
end;

class procedure TUsuarioSingleton.SetQuery(poQuery: TRESTDWClientSQL);
begin
  FQuery := poQuery;
end;

{$REGION 'Validações'}
class function TUsuarioSingleton.SenhasConferem(psSenha, psSenhaComparacao: String): Boolean;
begin
  Result := psSenha = psSenhaComparacao;
  if not Result then
    ShowMessage('As senhas não conferem!');
end;

class function TUsuarioSingleton.PodeCriarUsuario(psSenha, psSenhaComparacao: String): Boolean;
begin
  if not FQuery.IsEmpty then
    raise ExcecaoEsperada.Create('Usuario já cadastrado!');

  Result := SenhasConferem(psSenha, psSenhaComparacao);
end;

class function TUsuarioSingleton.PodeTrocarSenha(psSenhaAntiga, psSenhaNova, psSenhaComparacao: String): Boolean;
begin
  if FID = 0 then
    raise ExcecaoEsperada.Create('Faça login antes de alterar a senha');

  if FSenha <> psSenhaAntiga then
    raise ExcecaoEsperada.Create('A senha antiga não confere!');

  Result := SenhasConferem(psSenhaNova, psSenhaComparacao);
end;
{$ENDREGION}

{$REGION 'Ações'}
function TUsuarioSingleton.CriarUsuario(psEmail, psNome, psSenha, psSenhaComparacao: String): Boolean;
begin
  FQuery := Selecionar(psEmail, EmptyStr);

  if not PodeCriarUsuario(psSenha, psSenhaComparacao) then
    Exit(False);

  Inserir(psEmail, psNome, psSenha);

  ShowMessage('Usuario cadastrado com sucesso!');
  Result := True;
end;

function TUsuarioSingleton.AlterarSenha(psSenhaAntiga, psSenhaNova, psSenhaComparacao: String): Boolean;
begin
  if not PodeTrocarSenha(psSenhaAntiga, psSenhaNova, psSenhaComparacao) then
    Exit(False);

  AlterarSenhaID(FID, psSenhaNova);
  FSenha := psSenhaNova;
  ShowMessage('Senha alterada com sucesso!');
  Result := True;
end;

function TUsuarioSingleton.FazerLogin(psEmail, psSenha: String): Boolean;
begin
  FQuery := Selecionar(psEmail, psSenha);

  if FQuery.IsEmpty then
    raise ExcecaoEsperada.Create('Usuario e/ou senha inválido(s)');

  FID := FQuery.FieldByName('IDUSUARIO').AsInteger;
  FNome := FQuery.FieldByName('NOME').AsString;
  FEmail := FQuery.FieldByName('EMAIL').AsString;
  FSenha := FQuery.FieldByName('SENHA').AsString;

  Result := True;
end;
{$ENDREGION}

procedure TUsuarioSingleton.AlterarSenhaID(piID: integer; psSenhaNova: string);
begin
  FUsuario.SQL.Text := Format('UPDATE USUARIO SET SENHA = %s WHERE IDUSUARIO = %d',
    [QuotedStr(psSenhaNova), piID]);
  FUsuario.ExecSQL;
end;

function TUsuarioSingleton.Selecionar(psEmail: string; psSenha: string): TRESTDWClientSQL;
var
  sSQL: string;
begin
  if FUsuario.Active then
    FUsuario.Close;

  sSQL := Format('SELECT * FROM USUARIO WHERE EMAIL = %s', [QuotedStr(psEmail)]);

  if psSenha.Length > 0 then
    sSQL := sSQL + Format(' AND SENHA = %s', [QuotedStr(psSenha)]);

  FUsuario.Open(sSQL);
  Result := FUsuario;
end;

procedure TUsuarioSingleton.Inserir(psEmail, psNome, psSenha: String);
begin
  FUsuario.Insert;
  FUsuario.FieldByName('IDUSUARIO').AsInteger := 0;
  FUsuario.FieldByName('NOME').AsString := psNome;
  FUsuario.FieldByName('SENHA').AsString := psSenha;
  FUsuario.FieldByName('EMAIL').AsString := psEmail;
  FUsuario.Post;
  FUsuario.ApplyUpdates;
end;


end.
