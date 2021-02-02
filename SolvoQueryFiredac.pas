unit SolvoQueryFiredac;

interface

uses
  SolvoInterface, FireDAC.Comp.Client, System.Classes, Data.DB,
  FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

Type
  TSolvoQueryFiredac = class(TInterfacedObject, iSolvoQuery)
    private
      FConnection : TFDConnection;
      FQuery : TFDQuery;
      FParams : TParams;
    public
      constructor Create(aConnection : TFDConnection);
      destructor Destroy; override;
      class function New(aConnection : TFDConnection) : iSolvoQuery;
      function SQL : TStrings;
      function Params : TParams;
      function ExecSQL : iSolvoQuery;
      function DataSet : TDataSet;
      function Open(aSQL : String) : iSolvoQuery; overload;
      function Open : iSolvoQuery; overload;
  end;

implementation

uses
  System.SysUtils;

{ TSolvoQuery<T> }

constructor TSolvoQueryFiredac.Create(aConnection : TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FConnection := aConnection;
  FQuery.Connection := FConnection;
end;

function TSolvoQueryFiredac.DataSet: TDataSet;
begin
  Result := TDataSet(FQuery);
end;

destructor TSolvoQueryFiredac.Destroy;
begin
  FreeAndNil(FQuery);
  if Assigned(FParams) then
    FreeAndNil(FParams);
  inherited;
end;

function TSolvoQueryFiredac.ExecSQL: iSolvoQuery;
begin
  Result := Self;
  if Assigned(FParams) then
    FQuery.Params.Assign(FParams);

  FQuery.Prepare;
  FQuery.ExecSQL;

  if Assigned(FParams) then
    FreeAndNil(FParams);
end;

class function TSolvoQueryFiredac.New(aConnection : TFDConnection): iSolvoQuery;
begin
  Result := Self.Create(aConnection);
end;

function TSolvoQueryFiredac.Open: iSolvoQuery;
begin
  Result := Self;
  FQuery.Close;

  if Assigned(FParams) then
    FQuery.Params.Assign(FParams);

  FQuery.Prepare;
  FQuery.Open;

  if Assigned(FParams) then
    FreeAndNil(FParams);
end;

function TSolvoQueryFiredac.Open(aSQL: String): iSolvoQuery;
begin
  Result := Self;
  FQuery.Close;
  FQuery.Open(aSQL);
end;

function TSolvoQueryFiredac.Params: TParams;
begin
  if not Assigned(FParams) then
  begin
    FParams := TParams.Create(nil);
    FParams.Assign(FQuery.Params);
  end;
  Result := FParams;
end;

function TSolvoQueryFiredac.SQL: TStrings;
begin
  Result := FQuery.SQL;
end;

end.
