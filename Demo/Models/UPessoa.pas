unit UPessoa;

interface

uses
  SolvoDAO, SolvoAttributes;

type
  [Tabela('TBLPES', 'PE')]
  TPessoa = class(TSolvoDAO)
    private
    FCodigoPessoa: Integer;
    FTipoPessoa: String;
    FNomePessoa: String;
    FInscricaoPessoa: String;
    public
      constructor Create;
      destructor Destroy; override;
    published
      [Campo('CODPES'), PK, AutoInc]
      property CodigoPessoa: Integer read FCodigoPessoa write FCodigoPessoa;
      [Campo('TIPPES'), Display('Tipo Pessoa'), Format(1)]
      property TipoPessoa: String read FTipoPessoa write FTipoPessoa;
      [Campo('NOMPES'), Display('Nome'), NotNull]
      property NomePessoa: String read FNomePessoa write FNomePessoa;
      [Campo('INSPES'), Display('Inscrição'), NotNull]
      property InscricaoPessoa: String read FInscricaoPessoa write FInscricaoPessoa;
  end;

implementation

{ UPessoa }

constructor TPessoa.Create;
begin

end;

destructor TPessoa.Destroy;
begin
  inherited;
end;

end.
