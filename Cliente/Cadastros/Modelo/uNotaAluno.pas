unit uNotaAluno;

interface

uses
  uPaiControle, uVestibular, uAtributosCustomizados;

type
  TNotaAluno = class(TControle)
  private
    FIdNotaAluno: Integer;
    FIdUsuario: Integer;
    FIdVestibular: Integer;
    FVestibular: TVestibular;
    function GetVestibular: TVestibular;
  public
    destructor Destroy; override;
    property IdNotaAluno: Integer read FIdNotaAluno write FIdNotaAluno;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property IdVestibular: Integer read FIdVestibular write FIdVestibular;
    property Vestibular: TVestibular read GetVestibular;
  end;

implementation

uses
  SysUtils;

{ TNotaAluno }

destructor TNotaAluno.Destroy;
begin
  if FVestibular <> nil then
    FreeAndNil(FVestibular);

  inherited;
end;

function TNotaAluno.GetVestibular: TVestibular;
begin
  if FVestibular = nil then
    FVestibular := TVestibular.Create(FIdVestibular)
  else
    FVestibular.PesquisarPorCodigo(FVestibular.IdVestibular, FIdVestibular);

  Result := FVestibular;
end;

end.
