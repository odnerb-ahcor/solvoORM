unit UContratoController;

interface

uses
  Data.DB, UContrato, System.Generics.Collections, Vcl.Forms,
  SolvoInterface, SolvoORM, SolvoDAO;

type

  TContratoController = class
    private
      iORM : iSolvoORM<TContrato>;
      FDataSource : TDataSource;
      FBindForm : TForm;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : TContratoController;
      function Find: TContratoController;

      function NovoEmpregado: TContratoController;

      function ORM: iSolvoORM<TContrato>;
      function Contrato: TContrato;
      function DataSource( aDataSource: TDataSource ) : TContratoController;
      function BindForm( aForm: TForm ): TContratoController;
      function BindShow: TContratoController;
  end;

implementation

{ TContratoController }

function TContratoController.BindForm(aForm: TForm): TContratoController;
begin
  Result := Self;
  FBindForm := aForm as TForm;
  iORM.BindForm(FBindForm);

end;

function TContratoController.BindShow: TContratoController;
begin
  Result := Self;
  iORM.BindShow;
end;

constructor TContratoController.Create;
begin
  iORM := TSolvoORM<TContrato>.New;
end;

function TContratoController.ORM: iSolvoORM<TContrato>;
begin
  Result := iORM;
end;

function TContratoController.Contrato: TContrato;
begin
  Result := iORM.ObjectList;
end;

function TContratoController.DataSource(aDataSource: TDataSource): TContratoController;
begin
  Result := Self;
  FDataSource := aDataSource;
  iORM.DataSource(FDataSource);
end;

class function TContratoController.New: TContratoController;
begin
  Result := Self.Create;
end;


function TContratoController.NovoEmpregado: TContratoController;
var
  aContrato: TContrato;
begin
  Result := Self;
  aContrato := TContrato.Create;
  aContrato.Modo := tmNEW;

  iORM.Insert(aContrato);
end;

function TContratoController.Find: TContratoController;
begin
  iORM
    .SQL
      .JoinAttribute
        .Fields('PE.NOMPES')
        .Condition('CT.CODPES;CT.TIPPES', 'TBLPES PE', 'PE.CODPES;PE.TIPPES')
        .TypeJoin(INNER)
      .&End
      .JoinAttribute
        .Fields('PE.NOMPES')
        .Condition('CT.CODPES;CT.TIPPES', 'TBLPES PE', 'PE.CODPES;PE.TIPPES')
        .TypeJoin(INNER)
      .&End
    .&End
  .Find;
  Result := Self;
end;

destructor TContratoController.Destroy;
begin
  inherited;
end;

end.

