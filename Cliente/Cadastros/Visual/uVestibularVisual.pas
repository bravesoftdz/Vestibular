unit uVestibularVisual;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPaiVisual, FMX.Objects, FMX.Controls.Presentation, FMX.Edit, uVestibular;

type
  TVestibularFrm = class(TPaiFrm)
    EdtData: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    FVestibular: TVestibular;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VestibularFrm: TVestibularFrm;

implementation

{$R *.fmx}

procedure TVestibularFrm.FormCreate(Sender: TObject);
begin
  FVestibular := TVestibular.Create(Self);
  FControle := FVestibular;
  inherited;
end;

end.
