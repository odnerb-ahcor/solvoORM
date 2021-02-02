unit SolvoInterface;

interface

uses
  System.Classes,
  System.Generics.Collections,
  SolvoObjectList,
  Data.DB,
  System.TypInfo,
  {$IFNDEF CONSOLE}
  VCL.Forms,
  {$ENDIF}
  System.SysUtils,
  SolvoDAO;
type
  iSolvoDAOSQLAttribute<T : class> = interface;

  iSolvoORM<T : class> = interface
    ['{599C023A-1A3A-4E3C-AAA5-2ABC2F70B494}']
    function Find: iSolvoORM<T>; overload;
    function Find(aId : Integer) : T; overload;
    function Insert: iSolvoORM<T>; overload;
    function Insert(aValue: T): iSolvoORM<T>; overload;
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

  iSolvoDAOJoinAttribute<T: class> = interface
    ['{2A7DC1D8-EC41-496A-BBA9-2FA50463F450}']
    function Fields(aSQL: String): iSolvoDAOJoinAttribute<T>; overload;
    function Condition(ColumnsName, RefTblName, RefColName: String): iSolvoDAOJoinAttribute<T>; overload;
    function TypeJoin(aType: TJoinType): iSolvoDAOJoinAttribute<T>; overload;
    function Fields: String; overload;
    function Join: String; overload;
    function Tables: String; overload;
    function &End: iSolvoDAOSQLAttribute<T>;
  end;

  iSolvoDAOSQLAttribute<T : class> = interface
    ['{375DA59D-15D8-4F9E-B896-CE441D6FD5EC}']
    function Fields (aSQL : String) : iSolvoDAOSQLAttribute<T>; overload;
    function Where (aSQL : String) : iSolvoDAOSQLAttribute<T>; overload;
    function OrderBy (aSQL : String) : iSolvoDAOSQLAttribute<T>; overload;
    function GroupBy (aSQL : String) : iSolvoDAOSQLAttribute<T>; overload;
    function Join (aSQL : String) : iSolvoDAOSQLAttribute<T>; overload;
    function JoinAttribute : iSolvoDAOJoinAttribute<T>; overload;
    function Join : String; overload;
    function Fields : String; overload;
    function Where : String; overload;
    function OrderBy : String; overload;
    function GroupBy : String; overload;
    function Clear : iSolvoDAOSQLAttribute<T>;
    function &End : iSolvoORM<T>;
  end;

  iSolvoRTTI<T : class> = interface
    ['{91C9BA48-1C2D-4992-B355-8E9DABC8A66F}']
    function TableName(var aTableName: String; const bTag: Boolean = True): iSolvoRTTI<T>;
    function ClassName (var aClassName : String) : iSolvoRTTI<T>;
    function DictionaryFields(var aDictionary : TDictionary<string, variant>) : iSolvoRTTI<T>;
    function ListFields (var List : TList<String>) : iSolvoRTTI<T>;
    function Update (var aUpdate : String) : iSolvoRTTI<T>;
    function Where (var aWhere : String) : iSolvoRTTI<T>;
    function Fields (var aFields : String) : iSolvoRTTI<T>;
    function FieldsInsert (var aFields : String) : iSolvoRTTI<T>;
    function Param (var aParam : String) : iSolvoRTTI<T>;
    function Returning(var aReturning : String) : iSolvoRTTI<T>;
    function DataSetToEntityList (aDataSet : TDataSet; var aList : TSolvoObjectList<T>) : iSolvoRTTI<T>;
    function DataSetToEntity (aDataSet : TDataSet; var aEntity : T) : iSolvoRTTI<T>;
    function DataSetToEntityAux (const aEntity : T; aDataSet : TDataSet) : iSolvoRTTI<T>;
    function FkToEntity(const ClassObject: TObject; var aEntity : T) : iSolvoRTTI<T>;
    {$IFNDEF CONSOLE}
    function BindClassToForm (aForm : TForm;  const aEntity : T) : iSolvoRTTI<T>;
    function BindFormToClass (aForm : TForm; var aEntity : T) : iSolvoRTTI<T>;
    {$ENDIF}
  end;

  iSolvoSQL<T> = interface
    ['{CA550BF0-8860-4AE6-B181-9EAC0603EC6D}']
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

  iSolvoQuery = interface
    ['{8A727F03-442E-4FFC-8FC8-FF72A7710599}']
    function SQL : TStrings;
    function Params : TParams;
    function ExecSQL : iSolvoQuery;
    function DataSet : TDataSet;
    function Open(aSQL : String) : iSolvoQuery; overload;
    function Open : iSolvoQuery; overload;
  end;



implementation

end.
