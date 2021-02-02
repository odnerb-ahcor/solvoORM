unit SolvoDAOSQLAttribute;

interface

uses
  SolvoInterface, System.Classes, SolvoDAO, SolvoDAOJoinAttribute;

Type
  TSolvoDAOSQLAttribute<T : class> = class(TInterfacedObject,
    iSolvoDAOSQLAttribute<T>)
  private
    [weak]
    FParent: iSolvoORM<T>;
    FFields: String;
    FWhere: String;
    FOrderBy: String;
    FGroupBy: String;
    FJoin : String;
    FJoinAttribute: iSolvoDAOJoinAttribute<T>;
  public
    constructor Create(Parent: iSolvoORM<T>);
    destructor Destroy; override;
    class function New(Parent: iSolvoORM<T>): iSolvoDAOSQLAttribute<T>;
    function Fields(aSQL: String): iSolvoDAOSQLAttribute<T>; overload;
    function Where(aSQL: String): iSolvoDAOSQLAttribute<T>; overload;
    function OrderBy(aSQL: String): iSolvoDAOSQLAttribute<T>; overload;
    function GroupBy (aSQL : String) : iSolvoDAOSQLAttribute<T>; overload;
    function Join (aSQL : String) : iSolvoDAOSQLAttribute<T>; overload;
    function JoinAttribute : iSolvoDAOJoinAttribute<T>; overload;
    function Fields: String; overload;
    function Join : String; overload;
    function Where: String; overload;
    function OrderBy: String; overload;
    function GroupBy : String; overload;
    function Clear : iSolvoDAOSQLAttribute<T>;
    function &End: iSolvoORM<T>;
  end;

implementation

{ TSolvoDAOSQLAttribute<T> }

function TSolvoDAOSQLAttribute<T>.&End: iSolvoORM<T>;
begin
  Result := FParent;
end;

function TSolvoDAOSQLAttribute<T>.Fields: String;
begin
  Result := FFields + FJoinAttribute.Fields;
end;

function TSolvoDAOSQLAttribute<T>.GroupBy: String;
begin
  Result := FGroupBy;
end;

function TSolvoDAOSQLAttribute<T>.Join: String;
begin
  Result := FJoin + FJoinAttribute.Join;
end;

function TSolvoDAOSQLAttribute<T>.Join(
  aSQL: String): iSolvoDAOSQLAttribute<T>;
begin
  Result := Self;
  FJoin := FJoin + ' ' + aSQL;
end;

function TSolvoDAOSQLAttribute<T>.GroupBy(
  aSQL: String): iSolvoDAOSQLAttribute<T>;
begin
  Result := Self;
  FGroupBy := FGroupBy + ' ' + aSQL;
end;

function TSolvoDAOSQLAttribute<T>.Clear: iSolvoDAOSQLAttribute<T>;
begin
  Result := Self;
  FFields := '';
  FWhere := '';
  FOrderBy := '';
  FGroupBy := '';
  FJoin := '';
end;

constructor TSolvoDAOSQLAttribute<T>.Create(Parent: iSolvoORM<T>);
begin
  FParent := Parent;
  FJoinAttribute := TSolvoDAOJoinAttribute<T>.New(self);
end;

destructor TSolvoDAOSQLAttribute<T>.Destroy;
begin

  inherited;
end;

function TSolvoDAOSQLAttribute<T>.Fields(aSQL: String)
  : iSolvoDAOSQLAttribute<T>;
begin
  Result := Self;
  FFields := FFields + ' ' + aSQL;
end;

class function TSolvoDAOSQLAttribute<T>.New(Parent: iSolvoORM<T>)
  : iSolvoDAOSQLAttribute<T>;
begin
  Result := Self.Create(Parent);
end;

function TSolvoDAOSQLAttribute<T>.OrderBy: String;
begin
  Result := FOrderBy;
end;

function TSolvoDAOSQLAttribute<T>.OrderBy(aSQL: String)
  : iSolvoDAOSQLAttribute<T>;
begin
  Result := Self;
  FOrderBy := FOrderBy + ' ' + aSQL;
end;

function TSolvoDAOSQLAttribute<T>.Where(aSQL: String)
  : iSolvoDAOSQLAttribute<T>;
begin
  Result := Self;
  FWhere := FWhere + ' ' + aSQL;
end;

function TSolvoDAOSQLAttribute<T>.Where: String;
begin
  Result := FWhere;
end;

function TSolvoDAOSQLAttribute<T>.JoinAttribute : iSolvoDAOJoinAttribute<T>;
begin
  Result := FJoinAttribute;
end;

end.
