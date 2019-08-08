unit uNotaAlunoVisual;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPaiVisual, FMX.Objects, FMX.Controls.Presentation, FMX.Edit, uNotaAluno;

type
  TNotaAlunoFrm = class(TPaiFrm)
    EdtIdUsuario: TEdit;
    EdtIdVestibular: TEdit;
    EdtNota: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    FNotaAluno: TNotaAluno;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NotaAlunoFrm: TNotaAlunoFrm;

implementation

{$R *.fmx}

procedure TNotaAlunoFrm.FormCreate(Sender: TObject);
begin
  FNotaAluno := TNotaAluno.Create(Self);
  FControle := FNotaAluno;
  inherited;
end;

end.
