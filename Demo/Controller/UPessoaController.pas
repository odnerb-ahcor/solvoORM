unit UPessoaController;

interface

uses
  Data.DB, UPessoa, System.Generics.Collections, Vcl.Forms, SolvoInterface, SolvoORM, SolvoDAO;

type

  TPessoaController = class
    private
      iORM : iSolvoORM<TPessoa>;
      FDataSource : TDataSource;
      FBindForm : TForm;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : TPessoaController;
      function find(const CodPes: Integer): TPessoaController;

      function NewFuncionario: TPessoaController;

      function ORM : iSolvoORM<TPessoa>;
      function Pessoa : TPessoa;
      function DataSource( aDataSource: TDataSource ) : TPessoaController;
      function BindForm( aForm: TForm ): TPessoaController;
      function BindShow: TPessoaController;
  end;

implementation

{ UPessoaController }

function TPessoaController.BindForm(aForm: TForm): TPessoaController;
begin
  Result := Self;
  FBindForm := aForm as TForm;
  iORM.BindForm(FBindForm);

end;

function TPessoaController.BindShow: TPessoaController;
begin
  Result := Self;
  iORM.BindShow;
end;

constructor TPessoaController.Create;
begin
  iORM := TSolvoORM<TPessoa>.New;
end;

function TPessoaController.ORM: iSolvoORM<TPessoa>;
begin
  Result := iORM;
end;

function TPessoaController.Pessoa: TPessoa;
begin
  Result := iORM.ObjectList;
end;

function TPessoaController.DataSource(aDataSource: TDataSource): TPessoaController;
begin
  Result := Self;
  FDataSource := aDataSource;
  iORM.DataSource(FDataSource);
end;

class function TPessoaController.New: TPessoaController;
begin
  Result := Self.Create;
end;

destructor TPessoaController.Destroy;
begin
  inherited;
end;

function TPessoaController.find(const CodPes: Integer): TPessoaController;
begin
  Result := Self;
  iORM.Find(CodPes);
end;

function TPessoaController.NewFuncionario: TPessoaController;
var
  aPessoa: TPessoa;
begin
  Result := Self;

  aPessoa := TPessoa.Create;
  aPessoa.TipoPessoa := 'F';

  aPessoa.Modo := tmNEW;

  iORM.Insert(aPessoa);
end;


end.
