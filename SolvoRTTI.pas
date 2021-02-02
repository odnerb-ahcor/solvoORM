{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit SolvoRTTI;

interface

uses
  SolvoInterface,
  SolvoObjectList,
  SolvoComponents,
  System.Generics.Collections,
  System.RTTI,
  Data.DB,
  TypInfo,
  {$IFNDEF CONSOLE}
  VCL.Forms,
  VCL.StdCtrls,
  Vcl.ExtCtrls,
  {$ENDIF}
  System.Classes,
  System.SysUtils;

Type
  ESolvoRTTI = Exception;


  TSolvoRTTI<T : class, constructor> = class(TInterfacedObject, iSolvoRTTI<T>)
    private
      FInstance : T;
      function __findRTTIField(ctxRtti : TRttiContext; classe: TClass; const Field: String): TRttiField;
      function __FloatFormat( aValue : String ) : Currency;
      {$IFNDEF CONSOLE}
      //function __BindValueToComponent( aComponent : TComponent; aValue : Variant) : iSolvoRTTI<T>;
      //function __GetComponentToValue( aComponent : TComponent) : TValue;
      {$ENDIF}
      function __BindValueToProperty( aEntity : T; aProperty : TRttiProperty; aValue : TValue) : iSolvoRTTI<T>;

      function __GetRTTIPropertyValue(aEntity : T; aPropertyName : String) : Variant;
      function __GetRTTIProperty(aEntity : T; aPropertyName : String) : TRttiProperty;
    public
      constructor Create( aInstance : T );
      destructor Destroy; override;
      class function New( aInstance : T ) : iSolvoRTTI<T>;
      function TableName(var aTableName: String; const bTag: Boolean = True): iSolvoRTTI<T>;

      
      function Fields (var aFields : String) : iSolvoRTTI<T>;
      function FieldsInsert (var aFields : String) : iSolvoRTTI<T>;
      function Param (var aParam : String) : iSolvoRTTI<T>;
      function Where (var aWhere : String) : iSolvoRTTI<T>;
      function Returning(var aReturning : String) : iSolvoRTTI<T>;
      function Update(var aUpdate : String) : iSolvoRTTI<T>;
      function DictionaryFields(var aDictionary : TDictionary<string, variant>) : iSolvoRTTI<T>;
      function ListFields (var List : TList<String>) : iSolvoRTTI<T>;
      function ClassName (var aClassName : String) : iSolvoRTTI<T>;
      function DataSetToEntityList (aDataSet : TDataSet; var aList : TSolvoObjectList<T>) : iSolvoRTTI<T>;
      function DataSetToEntity (aDataSet : TDataSet; var aEntity : T) : iSolvoRTTI<T>;
      function DataSetToEntityAux (const aEntity : T; aDataSet : TDataSet) : iSolvoRTTI<T>;
      function FkToEntity(const ClassObject: TObject; var aEntity : T) : iSolvoRTTI<T>;
      {$IFNDEF CONSOLE}
      function BindClassToForm (aForm : TForm; const aEntity : T): iSolvoRTTI<T>;
      function BindFormToClass (aForm : TForm; var aEntity : T) : iSolvoRTTI<T>;
      {$ENDIF}
  end;

implementation

uses
  SolvoAttributes,
  {$IFNDEF CONSOLE}
  Vcl.ComCtrls,
  Vcl.Graphics,
  {$ENDIF}
  Variants,
  SolvoRTTIHelper,
  Vcl.Mask,
//  cxTextEdit,
//  cxCalendar,
//  cxDropDownEdit,
  System.UITypes;

{ TSolvoRTTI }


function TSolvoRTTI<T>.__BindValueToProperty( aEntity : T; aProperty : TRttiProperty; aValue : TValue) : iSolvoRTTI<T>;
begin
  if aProperty = nil then
   Exit;

  case aProperty.PropertyType.TypeKind of
    tkUnknown: ;
    tkInteger: aProperty.SetValue(Pointer(aEntity), StrToInt(aValue.ToString));
    tkChar: ;
    tkEnumeration: ;
    tkFloat:
    begin
      if (aValue.TypeInfo = TypeInfo(TDate))
        or (aValue.TypeInfo = TypeInfo(TTime))
        or (aValue.TypeInfo = TypeInfo(TDateTime)) then
        aProperty.SetValue(Pointer(aEntity), StrToDateTime(aValue.ToString))
      else
        aProperty.SetValue(Pointer(aEntity), StrToFloat(aValue.ToString));
    end;
    tkSet: ;
    tkClass: ;
    tkMethod: ;
    tkString, tkWChar, tkLString, tkWString, tkVariant, tkUString:
      aProperty.SetValue(Pointer(aEntity), aValue);
    tkArray: ;
    tkRecord: ;
    tkInterface: ;
    tkInt64: aProperty.SetValue(Pointer(aEntity), aValue.Cast<Int64>);
    tkDynArray: ;
    tkClassRef: ;
    tkPointer: ;
    tkProcedure: ;
    tkMRecord: ;
    else
      aProperty.SetValue(Pointer(aEntity), aValue);
  end;

end;

function TSolvoRTTI<T>.__findRTTIField(ctxRtti: TRttiContext; classe: TClass;
  const Field: String): TRttiField;
var
  typRtti : TRttiType;
begin
  typRtti := ctxRtti.GetType(classe.ClassInfo);
  Result  := typRtti.GetField(Field);
end;

function TSolvoRTTI<T>.__FloatFormat( aValue : String ) : Currency;
begin
  while Pos('.', aValue) > 0 do
    delete(aValue,Pos('.', aValue),1);

  Result := StrToCurr(aValue);
end;

function TSolvoRTTI<T>.__GetRTTIProperty(aEntity: T;
  aPropertyName: String): TRttiProperty;
var
  ctxRttiEntity : TRttiContext;
  typRttiEntity : TRttiType;
begin
  ctxRttiEntity := TRttiContext.Create;
  try
    typRttiEntity := ctxRttiEntity.GetType(aEntity.ClassInfo);
    Result := typRttiEntity.GetProperty(aPropertyName);
    if not Assigned(Result) then
      Result := typRttiEntity.GetPropertyFromAttribute<Campo>(aPropertyName);

    //if not Assigned(Result) then
   //   raise ESolvoRTTI.Create('Property ' + aPropertyName + ' not found!');
  finally
    ctxRttiEntity.Free;
  end;

end;

function TSolvoRTTI<T>.__GetRTTIPropertyValue(aEntity: T;
  aPropertyName: String): Variant;
var
  RttiProp: TRttiProperty;
begin
  RttiProp := __GetRTTIProperty(aEntity, aPropertyName);

  if Assigned(RttiProp) then
    Result := RttiProp.GetValue(Pointer(aEntity)).AsVariant
  else
    Result := null;
end;

{$IFNDEF CONSOLE}
function TSolvoRTTI<T>.BindClassToForm(aForm: TForm;
  const aEntity: T): iSolvoRTTI<T>;
var
  ctxRtti : TRttiContext;
  typRtti : TRttiType;
  prpRtti : TRttiField;
begin
  Result := Self;
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(aForm.ClassInfo);
    for prpRtti in typRtti.GetFields do
    begin
      if prpRtti.Tem<Bind> then
      begin
        __BindValueToComponent(
                          aForm.FindComponent(prpRtti.Name),
                          __GetRTTIPropertyValue(
                                                   aEntity,
                                                   prpRtti.GetAttribute<Bind>.Field
                          )
        );
      end;
    end;
  finally
    ctxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.BindFormToClass(aForm: TForm;
  var aEntity: T): iSolvoRTTI<T>;
var
  ctxRtti : TRttiContext;
  typRtti : TRttiType;
  prpRtti : TRttiField;
  ptyRtti : TRttiProperty;
begin
  Result := Self;
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(aForm.ClassInfo);
    for prpRtti in typRtti.GetFields do
    begin
      if prpRtti.Tem<Bind> then
      begin
        ptyRtti := __GetRTTIProperty(aEntity, prpRtti.GetAttribute<Bind>.Field);
        if not Assigned(ptyRtti) then
          continue;
        __BindValueToProperty(
          aEntity,
          ptyRtti,
          __GetComponentToValue(aForm.FindComponent(prpRtti.Name), ptyRtti)
        );
      end;
    end;
  finally
    ctxRtti.Free;
  end;
end;
{$ENDIF}

function TSolvoRTTI<T>.ClassName (var aClassName : String) : iSolvoRTTI<T>;
var
  Info      : PTypeInfo;
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    aClassName := Copy(typRtti.Name, 2, Length(typRtti.Name));
  finally
    ctxRtti.Free;
  end;
end;

constructor TSolvoRTTI<T>.Create( aInstance : T );
begin
  FInstance := aInstance;
end;

function TSolvoRTTI<T>.DataSetToEntity(aDataSet: TDataSet;
  var aEntity: T): iSolvoRTTI<T>;
var
  Field : TField;
  teste: string;
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
  Value : TValue;
begin
  Result := Self;
  aDataSet.First;
  while not aDataSet.Eof do
  begin
    Info := System.TypeInfo(T);
    ctxRtti := TRttiContext.Create;
    try
      for Field in aDataSet.Fields do
      begin
          typRtti := ctxRtti.GetType(Info);
          for prpRtti in typRtti.GetProperties do
          begin
            if LowerCase(prpRtti.FieldName) = LowerCase(Field.DisplayName) then
            begin
              case prpRtti.PropertyType.TypeKind of
                tkUnknown, tkString, tkWChar, tkLString, tkWString, tkUString:
                  Value := Field.AsString;
                tkInteger, tkInt64:
                  Value := Field.AsInteger;
                tkChar: ;
                tkEnumeration: ;
                tkFloat: Value := Field.AsFloat;
                tkSet: ;
                tkClass: ;
                tkMethod: ;
                tkVariant: ;
                tkArray: ;
                tkRecord: ;
                tkInterface: ;
                tkDynArray: ;
                tkClassRef: ;
                tkPointer: ;
                tkProcedure: ;
              end;
              prpRtti.SetValue(Pointer(aEntity), Value);
            end;
          end;
      end;
    finally
      ctxRtti.Free;
    end;
    aDataSet.Next;
  end;
  aDataSet.First;
end;

function TSolvoRTTI<T>.DataSetToEntityAux(const aEntity: T; aDataSet: TDataSet): iSolvoRTTI<T>;
var
  Field : TField;
  teste: string;
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
  Value : TValue;
begin
  Result := Self;
  aDataSet.First;
  while not aDataSet.Eof do
  begin
    //Info := System.TypeInfo(aEntity.ClassInfo);
    ctxRtti := TRttiContext.Create;
    try
      for Field in aDataSet.Fields do
      begin
          typRtti := ctxRtti.GetType(aEntity.ClassInfo);
          for prpRtti in typRtti.GetProperties do
          begin
            if LowerCase(prpRtti.FieldName) = LowerCase(Field.DisplayName) then
            begin
              case prpRtti.PropertyType.TypeKind of
                tkUnknown, tkString, tkWChar, tkLString, tkWString, tkUString:
                  Value := Field.AsString;
                tkInteger, tkInt64:
                  Value := Field.AsInteger;
                tkChar: ;
                tkEnumeration: ;
                tkFloat: Value := Field.AsFloat;
                tkSet: ;
                tkClass: ;
                tkMethod: ;
                tkVariant: ;
                tkArray: ;
                tkRecord: ;
                tkInterface: ;
                tkDynArray: ;
                tkClassRef: ;
                tkPointer: ;
                tkProcedure: ;
              end;
              prpRtti.SetValue(Pointer(aEntity), Value);
            end;
          end;
      end;
    finally
      ctxRtti.Free;
    end;
    aDataSet.Next;
  end;
  aDataSet.First;
end;

function TSolvoRTTI<T>.DataSetToEntityList(aDataSet: TDataSet;
  var aList: TSolvoObjectList<T>): iSolvoRTTI<T>;
var
  Field : TField;
  teste: string;
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
  Value : TValue;
begin
  Result := Self;
  aList.Clear;
  aDataSet.First;
  while not aDataSet.Eof do
  begin
    aList.Insert(T.Create);
    Info := System.TypeInfo(T);
    ctxRtti := TRttiContext.Create;
    try
      for Field in aDataSet.Fields do
      begin
        typRtti := ctxRtti.GetType(Info);
        for prpRtti in typRtti.GetProperties do
        begin
          if LowerCase(prpRtti.FieldName) = LowerCase(Field.FieldName) then
          begin
            Field.DisplayLabel := prpRtti.DisplayName;

            case prpRtti.PropertyType.TypeKind of
              tkUnknown, tkString, tkWChar, tkLString, tkWString, tkUString:
                Value := Field.AsString;
              tkInteger, tkInt64:
                Value := Field.AsInteger;
              tkChar: ;
              tkEnumeration: ;
              tkFloat:
              begin
                Value := Field.AsFloat;
                TCurrencyField(Field).DisplayFormat := prpRtti.Mask;
              end;
              tkSet: ;
              tkClass: ;
              tkMethod: ;
              tkVariant: ;
              tkArray: ;
              tkRecord: ;
              tkInterface: ;
              tkDynArray: ;
              tkClassRef: ;
              tkPointer: ;
              tkProcedure: ;
            end;
            prpRtti.SetValue(Pointer(aList[Pred(aList.Count)]), Value);
          end;
        end;
      end;
    finally
      ctxRtti.Free;
    end;
    aDataSet.Next;
  end;
  aDataSet.First;
end;

destructor TSolvoRTTI<T>.Destroy;
begin

  inherited;
end;

function TSolvoRTTI<T>.DictionaryFields(var aDictionary : TDictionary<string, variant>) : iSolvoRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
  Aux : String;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.IsIgnore then
        Continue;

      case prpRtti.PropertyType.TypeKind of
        tkInteger, tkInt64:
          begin
            if prpRtti.EhChaveEstrangeira then
            begin
              if prpRtti.GetValue(Pointer(FInstance)).AsInteger = 0 then
                aDictionary.Add(prpRtti.FieldName, Null)
              else
                aDictionary.Add(prpRtti.FieldName, prpRtti.GetValue(Pointer(FInstance)).AsInteger);
            end
            else
              aDictionary.Add(prpRtti.FieldName, prpRtti.GetValue(Pointer(FInstance)).AsInteger);
          end;
        tkFloat       :
        begin
          if prpRtti.GetValue(Pointer(FInstance)).TypeInfo = TypeInfo(TDateTime) then
            aDictionary.Add(prpRtti.FieldName, StrToDateTime(prpRtti.GetValue(Pointer(FInstance)).ToString))
          else
          if prpRtti.GetValue(Pointer(FInstance)).TypeInfo = TypeInfo(TDate) then
              aDictionary.Add(prpRtti.FieldName, StrToDate(prpRtti.GetValue(Pointer(FInstance)).ToString))
          else
          if prpRtti.GetValue(Pointer(FInstance)).TypeInfo = TypeInfo(TTime) then
            aDictionary.Add(prpRtti.FieldName, StrToTime(prpRtti.GetValue(Pointer(FInstance)).ToString))
          else
            aDictionary.Add(prpRtti.FieldName, __FloatFormat(prpRtti.GetValue(Pointer(FInstance)).ToString));
        end;
        tkWChar,
        tkLString,
        tkWString,
        tkUString,
        tkString      : aDictionary.Add(prpRtti.FieldName, prpRtti.GetValue(Pointer(FInstance)).AsString);
        tkVariant     : aDictionary.Add(prpRtti.FieldName, prpRtti.GetValue(Pointer(FInstance)).AsVariant);
      else
          aDictionary.Add(prpRtti.FieldName, prpRtti.GetValue(Pointer(FInstance)).AsString);
      end;
    end;
  finally
    ctxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.Fields (var aFields : String) : iSolvoRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info      : PTypeInfo;
  aTag      : String;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    if typRtti.Tem<Tabela> then
     aTag := typRtti.GetAttribute<Tabela>.Tag;

    for prpRtti in typRtti.GetProperties do
    begin
      if not prpRtti.IsIgnore then
        aFields := aFields + aTag + '.' + prpRtti.FieldName + ', ';
    end;
  finally
    aFields := Copy(aFields, 0, Length(aFields) - 2) + ' ';
    ctxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.FieldsInsert(var aFields: String): iSolvoRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info      : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.IsAutoInc then
        Continue;

      if prpRtti.IsIgnore then
        Continue;

      aFields := aFields + prpRtti.FieldName + ', ';
    end;
  finally
    aFields := Copy(aFields, 0, Length(aFields) - 2) + ' ';
    ctxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.FkToEntity(const ClassObject: TObject;
  var aEntity: T): iSolvoRTTI<T>;
var
  ctxRtti, ctxRttiAux : TRttiContext;
  typRtti, typRttiAux : TRttiType;
  prpRtti, prpRttiAux : TRttiProperty;
  Info      : PTypeInfo;
  aFields  : String;
begin
  Result := Self;
  ctxRtti := TRttiContext.Create;
  ctxRttiAux := TRttiContext.Create;
  try
    typRttiAux := ctxRttiAux.GetType(aEntity.ClassInfo);
    typRtti := ctxRtti.GetType(ClassObject.ClassInfo);
    for prpRttiAux in typRttiAux.GetProperties do
    begin
      if not prpRttiAux.EhChaveEstrangeira then
        Continue;

      for prpRtti in typRtti.GetProperties do
      begin
        if LowerCase(prpRtti.FieldName) = LowerCase(prpRttiAux.FieldFK) then
         begin
           prpRttiAux.SetValue(Pointer(aEntity), prpRtti.GetValue(Pointer(ClassObject)));
         end;
      end;
    end;


  finally
    ctxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.ListFields(var List: TList<String>): iSolvoRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  if not Assigned(List) then
    List := TList<string>.Create;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      List.Add(prpRtti.FieldName);
    end;
  finally
    ctxRtti.Free;
  end;
end;

class function TSolvoRTTI<T>.New( aInstance : T ): iSolvoRTTI<T>;
begin
  Result := Self.Create(aInstance);
end;

function TSolvoRTTI<T>.Param (var aParam : String) : iSolvoRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.IsIgnore then
        Continue;

      if prpRtti.IsAutoInc then
        Continue;

      aParam  := aParam + ':' + prpRtti.FieldName + ', ';
    end;
  finally
    aParam := Copy(aParam, 0, Length(aParam) - 2) + ' ';
    ctxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.Returning(var aReturning: String): iSolvoRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info      : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if not prpRtti.IsAutoInc then
        Continue;

      aReturning := aReturning + prpRtti.FieldName + ', ';
    end;
  finally
    aReturning := Copy(aReturning, 0, Length(aReturning) - 2);
    ctxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.TableName(var aTableName: String; const bTag: Boolean): iSolvoRTTI<T>;
var
  vInfo   : PTypeInfo;
  vCtxRtti: TRttiContext;
  vTypRtti: TRttiType;
begin
  Result := Self;
  vInfo := System.TypeInfo(T);
  vCtxRtti := TRttiContext.Create;
  try
    vTypRtti := vCtxRtti.GetType(vInfo);
    if vTypRtti.Tem<Tabela> then
      if bTag then
        aTableName := vTypRtti.GetAttribute<Tabela>.Name + ' ' + vTypRtti.GetAttribute<Tabela>.Tag
      else
        aTableName := vTypRtti.GetAttribute<Tabela>.Name;
  finally
    vCtxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.Update(var aUpdate : String) : iSolvoRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.IsIgnore then
        Continue;

      if prpRtti.IsAutoInc then
        Continue;

      aUpdate := aUpdate + prpRtti.FieldName + ' = :' + prpRtti.FieldName + ', ';
    end;
  finally
    aUpdate := Copy(aUpdate, 0, Length(aUpdate) - 2) + ' ';
    ctxRtti.Free;
  end;
end;

function TSolvoRTTI<T>.Where (var aWhere : String) : iSolvoRTTI<T>;
var
  ctxRtti   : TRttiContext;
  typRtti   : TRttiType;
  prpRtti   : TRttiProperty;
  Info     : PTypeInfo;
begin
  Result := Self;
  Info := System.TypeInfo(T);
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(Info);
    for prpRtti in typRtti.GetProperties do
    begin
      if prpRtti.EhChavePrimaria then
        aWhere := aWhere + prpRtti.FieldName + ' = :' + prpRtti.FieldName + ' AND ';
    end;
  finally
    aWhere := Copy(aWhere, 0, Length(aWhere) - 4) + ' ';
    ctxRtti.Free;
  end;
end;

end.
