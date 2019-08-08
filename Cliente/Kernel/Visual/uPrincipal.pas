unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls;

type
  TPrincipalFrm = class(TForm)
    BtnNotaVestibular: TButton;
    BtnVestibular: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnNotaVestibularClick(Sender: TObject);
    procedure BtnVestibularClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrincipalFrm: TPrincipalFrm;

implementation

uses
  uNotaAlunoVisual, uVestibularVisual;

{$R *.fmx}

procedure TPrincipalFrm.BtnNotaVestibularClick(Sender: TObject);
begin
  NotaAlunoFrm := TNotaAlunoFrm.Create(Self);
  try
    NotaAlunoFrm.ShowModal;
  finally
    NotaAlunoFrm.Free;
  end;
end;

procedure TPrincipalFrm.BtnVestibularClick(Sender: TObject);
begin
  VestibularFrm := TVestibularFrm.Create(Self);
  try
    VestibularFrm.ShowModal;
  finally
    VestibularFrm.Free;
  end;
end;

procedure TPrincipalFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

end.
