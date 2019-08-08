unit uVestibular;

interface

uses
  uPaiControle, uAtributosCustomizados;

type
  TVestibular = class(TControle)
  private
    FIdVestibular: Integer;
    FData: TDateTime;
  public
    property IdVestibular: Integer read FIdVestibular write FIdVestibular;
    property Data: TDateTime read FData write FData;
  end;

implementation

uses
  SysUtils;

{ TVestibular }

end.
