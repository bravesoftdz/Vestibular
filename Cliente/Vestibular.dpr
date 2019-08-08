program Vestibular;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLigacao in 'Kernel\Outros\uLigacao.pas',
  uPaiControle in 'Kernel\Controle\uPaiControle.pas',
  uConexaoBanco in 'Kernel\Outros\uConexaoBanco.pas',
  uConstrutorSQL in 'Kernel\Outros\uConstrutorSQL.pas',
  uAtributosCustomizados in 'Kernel\Outros\uAtributosCustomizados.pas',
  uPaiVisual in 'Kernel\Visual\uPaiVisual.pas' {PaiFrm},
  uUsuario in 'Cadastros\Modelo\uUsuario.pas',
  uUsuarioVisual in 'Cadastros\Visual\uUsuarioVisual.pas' {UsuarioFrm},
  uUsuarioSingleton in 'Kernel\Outros\uUsuarioSingleton.pas',
  uLogin in 'Kernel\Visual\uLogin.pas' {FrmLogin},
  uCidade in 'Cadastros\Modelo\uCidade.pas',
  uEstado in 'Cadastros\Modelo\uEstado.pas',
  uPrincipal in 'Kernel\Visual\uPrincipal.pas' {PrincipalFrm},
  uNotaAlunoVisual in 'Cadastros\Visual\uNotaAlunoVisual.pas' {NotaVestibularFrm},
  uNotaAluno in 'Cadastros\Modelo\uNotaAluno.pas',
  uVestibular in 'Cadastros\Modelo\uVestibular.pas',
  uVestibularVisual in 'Cadastros\Visual\uVestibularVisual.pas' {VestibularFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TVestibularFrm, VestibularFrm);
  Application.Run;
  FreeMemory(TConexaoBanco.Conexao);
  FreeMemory(TConexaoBanco.GetInstance);
end.
