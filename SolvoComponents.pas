unit SolvoComponents;

interface

uses
  System.Classes, System.RTTI, VCL.Forms, VCL.StdCtrls, Vcl.ExtCtrls;

procedure __BindValueToComponent(aComponent: TComponent;  aValue: Variant);
function __GetComponentToValue(aComponent: TComponent; aProperty : TRttiProperty): TValue;
function FromVariant(const Value: Variant; aProperty : TRttiProperty): TValue;

implementation

uses
  Vcl.ComCtrls, Vcl.Graphics, Variants, SolvoRTTIHelper, Vcl.Mask,
//  cxTextEdit, cxCalendar,  cxDropDownEdit,
  System.UITypes;

procedure __BindValueToComponent(aComponent: TComponent; aValue: Variant);
begin
  if VarIsNull(aValue) then exit;

  if aComponent is TEdit then
    (aComponent as TEdit).Text := aValue;

//  if aComponent is TCxTextEdit then
//    (aComponent as TCxTextEdit).Text := aValue;

  if aComponent is TComboBox then
    (aComponent as TComboBox).ItemIndex := (aComponent as TComboBox).Items.IndexOf(aValue);

//  if aComponent is TcxComboBox then
//    (aComponent as TcxComboBox).ItemIndex := (aComponent as TcxComboBox).Properties.Items.IndexOf(aValue);

  if aComponent is TRadioGroup then
    (aComponent as TRadioGroup).ItemIndex := (aComponent as TRadioGroup).Items.IndexOf(aValue);

  if aComponent is TCheckBox then
    (aComponent as TCheckBox).Checked := aValue;

  if aComponent is TTrackBar then
    (aComponent as TTrackBar).Position := aValue;

  if aComponent is TDateTimePicker then
    (aComponent as TDateTimePicker).Date := aValue;

//  if aComponent is TcxDateEdit then
//    (aComponent as TcxDateEdit).Date := aValue;

  if aComponent is TShape then
    (aComponent as TShape).Brush.Color := aValue;

  if aComponent is TMaskEdit then
   (aComponent as TMaskEdit).Text := aValue;

end;

function __GetComponentToValue(aComponent: TComponent; aProperty : TRttiProperty): TValue;
var
  a: string;
begin
  if aComponent is TEdit then
    Result := FromVariant((aComponent as TEdit).Text, aProperty);

  if aComponent is TComboBox then
    Result := FromVariant((aComponent as TComboBox).Items[(aComponent as TComboBox).ItemIndex], aProperty);

  if aComponent is TRadioGroup then
    Result := FromVariant((aComponent as TRadioGroup).Items[(aComponent as TRadioGroup).ItemIndex], aProperty);

  if aComponent is TCheckBox then
    Result := FromVariant((aComponent as TCheckBox).Checked, aProperty);

  if aComponent is TTrackBar then
    Result := FromVariant((aComponent as TTrackBar).Position, aProperty);

  if aComponent is TDateTimePicker then
    Result := FromVariant((aComponent as TDateTimePicker).DateTime, aProperty);

  if aComponent is TShape then
    Result := FromVariant((aComponent as TShape).Brush.Color, aProperty);

  if aComponent is TMaskEdit then
    Result := (aComponent as TMaskEdit).Text;

  a := Result.TOString;
end;

function FromVariant(const Value: Variant; aProperty : TRttiProperty): TValue;
begin
  case TVarData(Value).VType of
    varEmpty, varNull: Exit();
    varBoolean: Result := TVarData(Value).VBoolean;
    varShortInt: Result := TVarData(Value).VShortInt;
    varSmallint: Result := TVarData(Value).VSmallInt;
    varInteger: Result := TVarData(Value).VInteger;
    varSingle: Result := TVarData(Value).VSingle;
    varDouble: Result := TVarData(Value).VDouble;
    varCurrency: Result := TVarData(Value).VCurrency;
    varDate: Result := TValue.From<TDateTime>(TVarData(Value).VDate);
    varOleStr: Result := string(TVarData(Value).VOleStr);
    varDispatch: Result := TValue.From<IDispatch>(IDispatch(TVarData(Value).VDispatch));
    varError: Result := TValue.From<HRESULT>(TVarData(Value).VError);
    varUnknown: Result := TValue.From<IInterface>(IInterface(TVarData(Value).VUnknown));
    varByte: Result := TVarData(Value).VByte;
    varWord: Result := TVarData(Value).VWord;
    varUInt32: Result := TVarData(Value).VUInt32;
    varInt64: Result := TVarData(Value).VInt64;
    varUInt64: Result := TVarData(Value).VUInt64;
    varString: Result := string(RawByteString(TVarData(Value).VString));
    varUString:
      begin
        case aProperty.PropertyType.TypeKind of
          tkFloat: Result := TVarData(Value).VDouble;
          tkString, tkWChar, tkLString, tkWString, tkVariant, tkUString:
            Result := UnicodeString(TVarData(Value).VUString);
        end;
      end;
  else
    //raise EVariantTypeCastError.CreateRes();
  end;
end;

end.
