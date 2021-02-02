unit UContrato;

interface

uses
  SolvoDAO, SolvoAttributes;

type
  [Tabela('TBLCTT', 'CT')]
  TContrato = class(TSolvoDAO)
    private
    FMatriculaEmpregadoContrato: Integer;
    FCodigoPessoa: Integer;
    FTipoPessoa: String;
    FDataAdmissao: TDateTime;
    FSalarioContrato: Currency;

//    function getSalCtt(const sSalarioContratual: Currency): string;
    public
      constructor Create;
      destructor Destroy; override;
    published
      [Campo('MATEPGCTT'), PK, AutoInc, Display('Matricula')]
      property MatriculaEmpregadoContrato: Integer read FMatriculaEmpregadoContrato write FMatriculaEmpregadoContrato;
      [Campo('CODPES'), FK('CODPES')]
      property CodigoPessoa: Integer read FCodigoPessoa write FCodigoPessoa;
      [Campo('TIPPES'), FK('TIPPES'), Display('Tipo Pessoa')]
      property TipoPessoa: String read FTipoPessoa write FTipoPessoa;
      [Campo('DTAADMCTT'), Display('Data Admissão')]
      property DataAdmissao: TDateTime read FDataAdmissao write FDataAdmissao;
      [Campo('SALCTT'), Display('Salário'), FieldMask('R$ ,0.00;-R$ ,0.00')]//, GetText(getSalCtt)
      property SalarioContrato: Currency read FSalarioContrato write FSalarioContrato;
  end;

implementation

{ UContrato }

constructor TContrato.Create;
begin

end;

destructor TContrato.Destroy;
begin
  inherited;
end;

end.
