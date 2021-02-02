unit SolvoDAOJoinAttribute;

interface

uses
  SolvoInterface, SolvoDAO, System.Classes;

type
  TSolvoDAOJoinAttribute<T : class> = class(TInterfacedObject, iSolvoDAOJoinAttribute<T>)
    private
      [weak]
      FParent: iSolvoDAOSQLAttribute<T>;
      FFields: String;
      FJoin: String;
      FCondition: String;
      FTypeJoin: TJoinType;
      FTables: String;
    public
      constructor Create(Parent: iSolvoDAOSQLAttribute<T>);
      destructor Destroy; override;
      class function New(Parent: iSolvoDAOSQLAttribute<T>): iSolvoDAOJoinAttribute<T>;
      function Fields(aSQL: String): iSolvoDAOJoinAttribute<T>; overload;
      function Condition(ColumnsName, RefTblName, RefColName: String): iSolvoDAOJoinAttribute<T>; overload;
      function TypeJoin(aType: TJoinType): iSolvoDAOJoinAttribute<T>; overload;
      function Fields: String; overload;
      function Join: String; overload;
      function Tables: String; overload;
      function &End: iSolvoDAOSQLAttribute<T>;

  end;
implementation

uses
  System.SysUtils;

{ TSolvoDAOJoinAttribute<T> }

function TSolvoDAOJoinAttribute<T>.Condition(ColumnsName, RefTblName, RefColName: String): iSolvoDAOJoinAttribute<T>;
var
  sCampos, sRefCampos: TStringList;
  I: Integer;
begin
  sCampos := TStringList.Create;
  sRefCampos := TStringList.Create;

  try
    sCampos.Delimiter := ';';
    sCampos.DelimitedText := ColumnsName;

    sRefCampos.Delimiter := ';';
    sRefCampos.DelimitedText := RefColName;

    FTables := RefTblName;

    if (sCampos.Count = sRefCampos.Count) then
     begin
       FCondition := RefTblName + ' ON ' + sCampos.Strings[0] + ' = ' + sRefCampos.Strings[0];

       for I := 1 to sCampos.Count - 1 do
        FCondition := FCondition + ' AND ' + sCampos.Strings[I] + ' = ' + sRefCampos.Strings[I];
     end;
  finally
    FreeAndNil(sCampos);
    FreeAndNil(sRefCampos);
  end;



  Result := Self;
end;

function TSolvoDAOJoinAttribute<T>.TypeJoin(aType: TJoinType): iSolvoDAOJoinAttribute<T>;
begin
  Result := Self;
  FTypeJoin := aType;
end;

function TSolvoDAOJoinAttribute<T>.Fields(aSQL: String): iSolvoDAOJoinAttribute<T>;
begin
  Result := Self;
  FFields := FFields + ' ' + aSQL;
end;

function TSolvoDAOJoinAttribute<T>.&End: iSolvoDAOSQLAttribute<T>;
begin
  Result := FParent;

  case FTypeJoin of
    Inner: FJoin := FJoin + ' INNER JOIN ' + FCondition;
    Left:  FJoin := FJoin + ' LEFT JOIN '  + FCondition;
    Right: FJoin := FJoin + ' RIGHT JOIN ' + FCondition;
    Full:  FJoin := FJoin + ' FULL JOIN '  + FCondition;
  end;
end;

function TSolvoDAOJoinAttribute<T>.Fields: String;
begin
  Result := FFields;
end;

function TSolvoDAOJoinAttribute<T>.Join: String;
begin
  Result := FJoin;
end;

function TSolvoDAOJoinAttribute<T>.Tables: String;
begin
  Result := FTables;
end;

class function TSolvoDAOJoinAttribute<T>.New(Parent: iSolvoDAOSQLAttribute<T>): iSolvoDAOJoinAttribute<T>;
begin
  Result := Self.Create(Parent);
end;

constructor TSolvoDAOJoinAttribute<T>.Create(Parent: iSolvoDAOSQLAttribute<T>);
begin
  FParent := Parent;
  FTypeJoin := INNER;
end;

destructor TSolvoDAOJoinAttribute<T>.Destroy;
begin

  inherited;
end;

end.
