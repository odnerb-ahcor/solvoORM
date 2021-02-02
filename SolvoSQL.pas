unit SolvoSQL;

interface

uses
  SolvoInterface;

Type
  TSolvoSQL<T : class, constructor> = class(TInterfacedObject, iSolvoSQL<T>)
    private
      FInstance : T;
      FFields : String;
      FWhere : String;
      FOrderBy : String;
      FGroupBy : String;
      FJoin : String;
    public
      constructor Create(aInstance : T);
      destructor Destroy; override;
      class function New(aInstance : T) : iSolvoSQL<T>;
      function Insert (var aSQL : String) : iSolvoSQL<T>;
      function Update (var aSQL : String) : iSolvoSQL<T>;
      function Delete (var aSQL : String) : iSolvoSQL<T>;
      function Select (var aSQL : String) : iSolvoSQL<T>;
      function SelectId(var aSQL: String): iSolvoSQL<T>;
      function Fields (aSQL : String) : iSolvoSQL<T>;
      function Where (aSQL : String) : iSolvoSQL<T>;
      function OrderBy (aSQL : String) : iSolvoSQL<T>;
      function GroupBy (aSQL : String) : iSolvoSQL<T>;
      function Join (aSQL : String) : iSolvoSQL<T>;
  end;

implementation

uses
  SolvoRTTI, System.Generics.Collections;

{ TSolvoSQL<T> }

constructor TSolvoSQL<T>.Create(aInstance : T);
begin
  FInstance := aInstance;
end;

function TSolvoSQL<T>.Delete(var aSQL: String): iSolvoSQL<T>;
var
  aClassName, aWhere : String;
begin
  Result := Self;

  TSolvoRTTI<T>.New(FInstance)
    .TableName(aClassName)
    .Where(aWhere);

  aSQL := aSQL + 'DELETE FROM ' + aClassName;
  aSQL := aSQL + ' WHERE ' + aWhere;

end;

destructor TSolvoSQL<T>.Destroy;
begin

  inherited;
end;

function TSolvoSQL<T>.Fields(aSQL: String): iSolvoSQL<T>;
begin
  Result := Self;
  FFields := aSQL;
end;

function TSolvoSQL<T>.GroupBy(aSQL: String): iSolvoSQL<T>;
begin
  Result := Self;
  FGroupBy := aSQL;
end;

function TSolvoSQL<T>.Insert(var aSQL: String): iSolvoSQL<T>;
var
  aClassName, aFields, aParam, aReturning : String;
begin
  Result := Self;

  TSolvoRTTI<T>.New(FInstance)
    .TableName(aClassName, False)
    .FieldsInsert(aFields)
    .Param(aParam)
    .Returning(aReturning);

  aSQL := aSQL + 'INSERT INTO ' + aClassName;
  aSQL := aSQL + ' (' + aFields + ') ';
  aSQL := aSQL + ' VALUES (' + aParam + ')';

  if aReturning <> '' then
    aSQL := aSQL + ' RETURNING ' + aReturning + ';'
  else
    aSQL := aSQL + ';';
end;

function TSolvoSQL<T>.Join(aSQL: String): iSolvoSQL<T>;
begin
  Result := Self;
  FJoin := aSQL;
end;

class function TSolvoSQL<T>.New(aInstance : T): iSolvoSQL<T>;
begin
  Result := Self.Create(aInstance);
end;

function TSolvoSQL<T>.OrderBy(aSQL: String): iSolvoSQL<T>;
begin
  Result := Self;
  FOrderBy := aSQL;
end;

function TSolvoSQL<T>.Select (var aSQL : String) : iSolvoSQL<T>;
var
  aFields, aClassName : String;
begin
  Result := Self;

  TSolvoRTTI<T>.New(nil)
    .Fields(aFields)
    .TableName(aClassName);

  if FFields <> '' then
    aSQL := aSQL + ' SELECT ' + aFields + ', ' + FFields
  else
    aSQL := aSQL + ' SELECT ' + aFields;

  aSQL := aSQL + ' FROM ' + aClassName;

  if FJoin <> '' then
    aSQL := aSQL + ' ' + FJoin + ' ';

  if FWhere <> '' then
    aSQL := aSQL + ' WHERE ' + FWhere;

  if FGroupBy <> '' then
    aSQL := aSQL + ' GROUP BY ' + FGroupBy;  

  if FOrderBy <> '' then
    aSQL := aSQL + ' ORDER BY ' + FOrderBy;

end;

function TSolvoSQL<T>.SelectId(var aSQL: String): iSolvoSQL<T>;
var
  aFields, aClassName, aWhere : String;
begin
  Result := Self;

  TSolvoRTTI<T>.New(FInstance)
    .Fields(aFields)
    .TableName(aClassName)
    .Where(aWhere);
  if FWhere <> '' then
    aSQL := aSQL + ' WHERE ' + FWhere;

  aSQL := aSQL + ' SELECT ' + aFields;
  aSQL := aSQL + ' FROM ' + aClassName;
  aSQL := aSQL + ' WHERE ' + aWhere;
end;

function TSolvoSQL<T>.Update(var aSQL: String): iSolvoSQL<T>;
var
  ClassName, aUpdate, aWhere : String;
begin
  Result := Self;

  TSolvoRTTI<T>.New(FInstance)
    .TableName(ClassName)
    .Update(aUpdate)
    .Where(aWhere);

  aSQL := aSQL + 'UPDATE ' + ClassName;
  aSQL := aSQL + ' SET ' + aUpdate;
  aSQL := aSQL + ' WHERE ' + aWhere;

end;

function TSolvoSQL<T>.Where(aSQL: String): iSolvoSQL<T>;
begin
  Result := Self;
  FWhere := aSQL;
end;

end.
