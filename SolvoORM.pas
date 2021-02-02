unit SolvoORM;

interface

uses
  SolvoInterface,
  System.RTTI,
  System.Generics.Collections,
  SolvoObjectList,
  System.Classes,
  Data.DB,
  VCL.Forms,
  UdmConexao,
  SolvoDAOSQLAttribute,
  System.Threading,
  SolvoDAO,
  SolvoValidator;

Type
  TSolvoORM<T: class, constructor> = class(TInterfacedObject, iSolvoORM<T>)
    private
      FMemory : iSolvoQuery;
      FQuery : iSolvoQuery;
      FDataSource : TDataSource;
      FForm : TForm;
      FList : TSolvoObjectList<T>;
      FSQLAttribute : iSolvoDAOSQLAttribute<T>;

      function FillParameter(aInstance : T) : iSolvoORM<T>; overload;
      function FillParameter(aInstance : T; aId : Variant) : iSolvoORM<T>; overload;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iSolvoORM<T>; overload;

      function Find: iSolvoORM<T>; overload; {BUSCA TODOS OS DADOS DA TABELA}
      function Find(aId : Integer) : T; overload; {BUSCA PESQUISANDO PELAS FK}
      function Insert(): iSolvoORM<T>; overload;

      function Insert(aValue: T): iSolvoORM<T>; overload;
      function Modo: TModo;
      function setModo(const aModo: TModo): iSolvoORM<T>;
      function Save(const Atualizar: Boolean = False): iSolvoORM<T>;
      function Cancel: iSolvoORM<T>;
      function LoadFK(const ClassObject: TObject): iSolvoORM<T>;
      procedure OnDataChange(Sender : TObject; Field : TField);
      function ObjectList: T;
      function SQL : iSolvoDAOSQLAttribute<T>;
      function DataSource( aDataSource : TDataSource) : iSolvoORM<T>;
      function BindForm(aForm : TForm)  : iSolvoORM<T>;
      function BindShow : iSolvoORM<T>;
  end;

implementation

uses
  System.SysUtils, SolvoAttributes, System.TypInfo, SolvoRTTI, SolvoSQL,
  SolvoQueryFiredac;

{ TGenericDAO }


{ TSolvoORM }

class function TSolvoORM<T>.New: iSolvoORM<T>;
begin
  Result := Self.Create;
end;

function TSolvoORM<T>.ObjectList: T;
begin
  Result := FList.ObjectItem;
end;

procedure TSolvoORM<T>.OnDataChange(Sender: TObject; Field: TField);
begin
  if ( FList.Count > 0) and (FDataSource.DataSet.RecNo-1 <= FList.Count) then
  begin
    FList.Pos := FDataSource.DataSet.RecNo-1;
  end;
end;

function TSolvoORM<T>.Cancel: iSolvoORM<T>;
begin
  FreeAndNil(FList);
  FList := TSolvoObjectList<T>.Create;
  FMemory.DataSet.DisableControls;
  TSolvoRTTI<T>.New(nil).DataSetToEntityList(FMemory.DataSet, FList);
  FMemory.DataSet.EnableControls;
end;

constructor TSolvoORM<T>.Create;
begin
  FMemory := TSolvoQueryFiredac.New(dmConexao.Conecta);
  FQuery := TSolvoQueryFiredac.New(dmConexao.Conecta);
  FSQLAttribute := TSolvoDAOSQLAttribute<T>.New(Self);
  FList := TSolvoObjectList<T>.Create;
end;

function TSolvoORM<T>.DataSource(aDataSource: TDataSource): iSolvoORM<T>;
begin
  Result := Self;
  FDataSource := aDataSource;
  FDataSource.DataSet := FMemory.DataSet;
  FDataSource.OnDataChange := OnDataChange;
end;

function TSolvoORM<T>.BindForm(aForm: TForm): iSolvoORM<T>;
begin
  Result := Self;
  FForm := aForm;
end;

function TSolvoORM<T>.BindShow: iSolvoORM<T>;
begin
  if ( FList.Count > 0) and (FMemory.DataSet.RecNo-1 <= FList.Count) then
  begin
    {$IFNDEF CONSOLE}
    if Assigned(FForm) then
     TSolvoRTTI<T>
      .New(nil)
      .BindClassToForm(FForm, FList.ObjectItem);
    {$ENDIF}
  end;
end;

function TSolvoORM<T>.Find: iSolvoORM<T>;
var
  aSQL : String;
begin
  Result := Self;

  TSolvoSQL<T>
    .New(nil)
    .Fields(FSQLAttribute.Fields)
    .Join(FSQLAttribute.Join)
    .Where(FSQLAttribute.Where)
    .OrderBy(FSQLAttribute.OrderBy)
    .Select(aSQL);

  FMemory.DataSet.DisableControls;
  FMemory.Open(aSQL);

  TSolvoRTTI<T>.New(nil).DataSetToEntityList(FMemory.DataSet, FList);

  FSQLAttribute.Clear;
  FMemory.DataSet.EnableControls;
end;

function TSolvoORM<T>.Find(aId: Integer): T;
var
  aSQL : String;
begin
  Result := T.Create;
  TSolvoSQL<T>.New(nil).SelectId(aSQL);
  FMemory.SQL.Clear;
  FMemory.SQL.Add(aSQL);
  Self.FillParameter(Result, aId);
  FMemory.Open;
  TSolvoRTTI<T>.New(nil).DataSetToEntity(FMemory.DataSet, Result);
  TSolvoRTTI<T>.New(nil).DataSetToEntityList(FMemory.DataSet, FList);
end;

function TSolvoORM<T>.Insert: iSolvoORM<T>;
var
  aSQL : String;
  Entity : T;
begin
  Result := Self;
  Entity := FList.ObjectItem;
  try
    TSolvoSQL<T>.New(Entity).Insert(aSQL);
    FQuery.SQL.Clear;
    FQuery.SQL.Add(aSQL);
    TSolvoRTTI<T>.New(nil).BindFormToClass(FForm, Entity);
    TSolvoValidator.Validate(Entity);
    Self.FillParameter(Entity);
    if Pos('RETURNING', aSQL) > 0 then
     begin
      FQuery.Open;
      TSolvoRTTI<T>.New(nil).DataSetToEntity(FQuery.DataSet, Entity);
     end
    else
      FQuery.ExecSQL;

  finally
    //FreeAndNil(Entity);
  end;
end;

function TSolvoORM<T>.Insert(aValue: T): iSolvoORM<T>;
begin
  FList.Insert(aValue, tmNEW);
  Result := Self;
end;

function TSolvoORM<T>.LoadFK(const ClassObject: TObject): iSolvoORM<T>;
var
  Entity : T;
begin
  Result := Self;
  Entity := FList.ObjectItem;
  TSolvoRTTI<T>.New(nil).FkToEntity(ClassObject, Entity);
end;

function TSolvoORM<T>.Modo: TModo;
begin
  Result := FList.Mode;
end;

function TSolvoORM<T>.Save(const Atualizar: Boolean): iSolvoORM<T>;
begin
  FList.First;
  while not FList.Eof do
  begin
    case FList.Mode of
      tmNEW: self.Insert;
      tmEDIT: FList.Last;
      tmDELETE: FList.Last;
    end;

    FList.Next;
  end;

  if Atualizar then
  begin
    FMemory.DataSet.Refresh;
    Cancel;
  end;
end;

function TSolvoORM<T>.setModo(const aModo: TModo): iSolvoORM<T>;
begin
  Result := Self;
  FList.Mode := aModo;
end;

function TSolvoORM<T>.SQL: iSolvoDAOSQLAttribute<T>;
begin
  Result := FSQLAttribute;
end;

function TSolvoORM<T>.FillParameter(aInstance: T): iSolvoORM<T>;
var
  Key : String;
  DictionaryFields : TDictionary<String, Variant>;
  P : TParams;
begin
  DictionaryFields := TDictionary<String, Variant>.Create;
  TSolvoRTTI<T>.New(aInstance).DictionaryFields(DictionaryFields);
  try
    for Key in DictionaryFields.Keys do
    begin
      if FQuery.Params.FindParam(Key) <> nil then
        FQuery.Params.ParamByName(Key).Value := DictionaryFields.Items[Key];
    end;
  finally
    FreeAndNil(DictionaryFields);
  end;
end;

function TSolvoORM<T>.FillParameter(aInstance: T; aId: Variant): iSolvoORM<T>;
var
  I : Integer;
  ListFields : TList<String>;
  teste : string;
begin
  ListFields := TList<String>.Create;
  TSolvoRTTI<T>.New(aInstance).ListFields(ListFields);
  try
    for I := 0 to Pred(ListFields.Count) do
    begin
      teste := ListFields[I];
      if FMemory.Params.FindParam(ListFields[I]) <> nil then
        FMemory.Params.ParamByName(ListFields[I]).Value := aId;
    end;
  finally
    FreeAndNil(ListFields);
  end;
end;

destructor TSolvoORM<T>.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

end.
