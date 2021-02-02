unit SimpleEntity;

interface

uses
  {$IFNDEF CONSOLE}
  Vcl.Forms,
  {$ENDIF}
  Data.DB, System.Generics.Collections, System.SysUtils;

type
  TSolvoEntity = class
  public
    {$IFNDEF CONSOLE}
    function Parse(const aForm: TForm): TSolvoEntity; overload; virtual;
    {$ENDIF}
    function Parse(const aDataSet: TDataSet): TSolvoEntity; overload; virtual;
    procedure Parse(const psJSON: string); overload;
    procedure SaveToFileJSON(const poFileName: TFileName); overload; virtual;
    procedure SaveToFileJSON(const poFileName: TFileName; poEncoding: TEncoding); overload; virtual;
    function ToJSON: string;
    function ToJSONRefletion: string;
  end;

  TSolvoEntityList<T: TSolvoEntity, constructor> = class(TObjectList<T>)
  public
    function Parse(const aDataSet: TDataSet): TSolvoEntityList<T>; virtual;
    function ToJSON: string;
    function ToJSONRefletion: string;
  end;

implementation

uses
  SolvoUtil, SolvoJSONUtil, System.Classes, System.JSON, System.StrUtils;

{ TSolvoEntity }

function TSolvoEntity.Parse(const aDataSet: TDataSet): TSolvoEntity;
begin
  Result := Self;
  TSolvoUtil.GetValuesFromDataset(aDataSet, Self);
end;

procedure TSolvoEntity.SaveToFileJSON(const poFileName: TFileName);
begin
  SaveToFileJSON(poFileName, TEncoding.Default);
end;

procedure TSolvoEntity.Parse(const psJSON: string);
begin
  TSolvoJsonUtil.JSONStringToObject(psJSON, Self);
end;

procedure TSolvoEntity.SaveToFileJSON(const poFileName: TFileName;
  poEncoding: TEncoding);
var
  oConteudo: TStringList;
begin
  oConteudo := TStringList.Create;
  try
    oConteudo.Text := ToJSON;
    if ForceDirectories(ExtractFilePath(poFileName)) then
      oConteudo.SaveToFile(poFileName, poEncoding);
  finally
    FreeAndNil(oConteudo);
  end;
end;

function DecodeUnicodeEscapes(psEscaped: string): string;
var
  FoundPos: LongInt;
  HexCode: String;
  DecodedChars: String;
begin
  Result := psEscaped;
  FoundPos := Pos('\u', Result);
  while (FoundPos <> 0) and (FoundPos < Length(Result) - 4) do
  begin
    HexCode :=  Copy(Result, FoundPos + 2, 4);
    DecodedChars := WideChar(StrToInt('$' + HexCode));
    Result := AnsiReplaceStr(Result, '\u' + HexCode,
                             Utf8ToAnsi(UTF8Encode(DecodedChars)));
    FoundPos := Pos('\u', Result);
  end;
  Result := StringReplace(Result, '\/', '/', [rfReplaceAll])
end;

function TSolvoEntity.ToJSON: string;
begin
  Result := TSolvoJsonUtil.ObjectToJSONString(Self);
end;

function TSolvoEntity.ToJSONRefletion: string;
var
  oJSONValue: TJSONValue;
begin
  oJSONValue := TSolvoJsonUtil.ObjectToJSON(Self);
  try
    Result := DecodeUnicodeEscapes(oJSONValue.ToJSON);
  finally
    FreeAndNil(oJSONValue);
  end;
end;

{ TSolvoEntityList<T> }

function TSolvoEntityList<T>.Parse(const aDataSet: TDataSet): TSolvoEntityList<T>;
begin
  Result := Self;
  Self.Clear;
  TSolvoUtil.DataSetToObjectList<T>(aDataSet, Self);
end;

{$IFNDEF CONSOLE}

function TSolvoEntity.Parse(const aForm: TForm): TSolvoEntity;
begin
  Result := Self;
  TSolvoUtil.GetObjectFromForm(aForm, Self);
end;

{$ENDIF}

function TSolvoEntityList<T>.ToJSON: string;
begin
  Result := TSolvoJsonUtil.ListToJSONArrayString<T>(Self, [jfFormat]);
end;

function TSolvoEntityList<T>.ToJSONRefletion: string;
var
  oJSONArray: TJSONArray;
begin
  oJSONArray := TSolvoJsonUtil.ListToJSONArray<T>(Self);
  try
    Result := oJSONArray.ToJSON;
  finally
    FreeAndNil(oJSONArray);
  end;
end;

end.
