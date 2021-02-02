# SolvoORM
ORM para Aplicações Delphi


O SolvoORM é baseado no SimpleORM criado por:
[bittencourtthulio](https://github.com/bittencourtthulio/SimpleORM)</br>

O SolvoORM tem o Objetivo de facilitar suas implementações de CRUD, agilizando mais de 80% do seu processo de desenvolvimento de software.


Entidade do Banco de Dados Mapeada

```delphi
uses
  SolvoDAO, SolvoAttributes;

type
  [Tabela('TBLCTT', 'CT')]
  TContrato = class(TSolvoDAO)
    private
    FMatriculaEmpregadoContrato: Integer;
    FCodigoPessoa: Integer;
    FTipoPessoa: String;
    FDataAdmissao: TDateTime;
    FSalarioContrato: Currency;
    public
      constructor Create;
      destructor Destroy; override;
    published
      [Campo('MATEPGCTT'), PK, AutoInc, Display('Matricula')]
      property MatriculaEmpregadoContrato: Integer read FMatriculaEmpregadoContrato write FMatriculaEmpregadoContrato;
      [Campo('CODPES'), FK('CODPES')]
      property CodigoPessoa: Integer read FCodigoPessoa write FCodigoPessoa;
      [Campo('TIPPES'), FK('TIPPES'), Display('Tipo Pessoa')]
      property TipoPessoa: String read FTipoPessoa write FTipoPessoa;
      [Campo('DTAADMCTT'), Display('Data Admissão')]
      property DataAdmissao: TDateTime read FDataAdmissao write FDataAdmissao;
      [Campo('SALCTT'), NotNull, Display('Salário'), FieldMask('R$ ,0.00;-R$ ,0.00')]
      property SalarioContrato: Currency read FSalarioContrato write FSalarioContrato;
  end;
```

Controller da Entidade

```delphi

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

```

## Atributos
`Tabela`  - Informa o Nome da Tabela no Banco em que a Classe faz o mapeamento.

`Campo`   - Informa o Nome do Campo no Banco de Dados em que a property está fazendo Referência.

`PK`      - Informa se o Campo é PrimaryKey.

`FK`      - Informa se o Campo é ForeignKey e o campo que o mesmo referencia na tabela pai.

`NotNull` - Informa se o Campo é NotNull.

`Ignore`  - Ignorar o Campo nas Operações de CRUD.

`AutoInc` - Informa se o Campo é AutoIncremento.

`NumberOnly` - Informa se o Campo deve aceitar somente números.

`Bind` - Informa o Nome do Campo no Banco de Dados ou a `property` que o componente visual está fazendo Referência.

`Display` - Informa a descrição que deve aparecer no título de grids.

`Format`  - Informa o formato que o campo deve ter, coisas como (tamanho, precisão, máscara e range).

# Principais Operações


## Instalação
Basta adicionar ao LibraryPatch o Caminho do SolvoORM.

## Uses Necessárias

SolvoInterface,

SolvoORM,

SolvoDAO,

SolvoAttributes,

## Inicialização do SolvoORM

```delphi
var
  objContrato : iSolvoDAO<TContrato>;
begin
  DAOPedido := TSolvoDAO<TContrato>
                  .New
                  .DataSource(DataSource1)
                  .BindForm(Self);
end;
```

`DAOPedido` - Instância o DAO para uma Entidade Mapeada, passando a Classe de Mapeamento como Atributo Genérico.

`DataSource`- Você pode informar um DataSource para que os dados sejam armazenados nele para facilitar seu processo de listagem de dados, podem linkar ao DBGrid para exibição dos mesmos.

`Bind`      - Você pode informar o formulário que deseja que o SolvoORM faça o Bind automatico entre a Classe e os Componentes da tela (Edit, Combo, CheckBox, RadioButton e etc...)


## MAPEAMENTO DO BIND DO FORMULÁRIO
Quando você fizer o mapeamento Bind do Formulário, não precisará ligar manualmente os campos da classe ao Edits, o SolvoORM faz isso automáticamente, basta você realizar o mapeamento correto conforme abaixo.

```delphi
type
  TForm1 = class(TForm)
    [Bind('MatriculaEmpregadoContrato')]
    Edit1: TEdit;
    [Bind('CodigoPessoa')]
    Edit2: TEdit;
    [Bind('TipoPessoa')]
    Edit3: TEdit;
    Button2: TButton;
    [Bind('DataAdmissao')]
    DateTimePicker1: TDateTimePicker;
```

No atributo Bind de cada campo, você deve informar o nome da Property correspondente na Classe Mapeada do banco de dados ou o nome do campo na tabela do banco de dados, ATENÇÃO de qualquer forma a Classe deve estar mapeada corretamente.

## INSERT COM BIND

```delphi
begin
  objPessoa.ORM.Save;
  objContrato.ORM.LoadFK(objPessoa.Pessoa); //PREENCHE AS FK COM BASE NO objPessoa
  objContrato.ORM.Save(True); //SE PASSAR 'TRUE' A GRID SERA ATUALIZADA
end;
```

## INSERT COM OBJETO
```delphi

begin
  objPessoa.ORM.Save;
  objContrato.ORM.LoadFK(objPessoa.Pessoa); //PREENCHE AS FK COM BASE NO objPessoa
  objContrato.Contrato.
  objContrato.ORM.Save(True); //SE PASSAR 'TRUE' A GRID SERA ATUALIZADA
end;
```

## UPDATE COM BIND
```delphi
begin
  // EM CONSTRUÇÃO
end;
```

## UPDATE COM OBJETO
```delphi
begin
  // EM CONSTRUÇÃO
end;
```

## DELETE COM BIND
```delphi
begin
  // EM CONSTRUÇÃO
end;
```

## DELETE COM OBJETO
```delphi
begin
  // EM CONSTRUÇÃO
end;
```

## SELECT 
Você pode executar desde operações simples como trazer todos os dados da tabela, como filtrar campos e outras instruções SQL, 

executando a instrução abaixo você retornará todos os dados da tabela
```delphi
  objContrato
    .DataSource(DataSource1)  //PASSA O DATA SOURCE  -OPCIONAL
    .BindForm(self) 		  //PASSA O FOMULARIO PARA USAR A OPÇÃO DE FIND POR BIND  -OPCIONAL	
    .Find
  .BindShow;				  //CARREGAS AS INFORMAÇÕES DENTRO DOS CAMPOS DO FOMULARIO QUE ESTIVEREM COM BIND  -OPCIONAL
```

Abaixo um exemplo de todas as operações possíveis no SolvoORM
```delphi
begin
  objContrato.ORM
    .SQL
      .Fields('Informe os Campos que deseja trazer separados por virgula')
      .Join('Informe a Instrução Join que desejar ex INNER JOIN PESSOA PE ON CT.CODPES = PE.CODPES')
      .Where('Coloque a Clausula Where que desejar ex: CT.MATEPGCTT = 1')
      .OrderBy('Informe o nome do Campo que deseja ordenar ex: CT.MATEPGCTT')
      .GroupBy('Informe os campos que deseja agrupar separados por virgula')
    .&End
  .Find;
end;
```

Mesmo exemplo do anterior utilizando JoinAttribute
```delphi
begin
  objContrato.ORM
    .SQL
      .Fields('Informe os Campos que deseja trazer separados por virgula')
      .JoinAttribute
        .Fields('PE.NOMPES') //CAMPOS QUE SERAO RETORNADO DA TBLPES
        .Condition('CT.CODPES;CT.TIPPES', 'TBLPES PE', 'PE.CODPES;PE.TIPPES') //1°- CAPOS FK DA TBLCTT 2°- TABELA RELACIONADA 3°- CAMPOS DA TABELA RELACIONADA
        .TypeJoin(INNER) //MODO INNER (INNER, LEFT, RIGHT, FULL), 
      .&End
      .Where('Coloque a Clausula Where que desejar ex: CT.MATEPGCTT = 1')
      .OrderBy('Informe o nome do Campo que deseja ordenar ex: CT.MATEPGCTT')
      .GroupBy('Informe os campos que deseja agrupar separados por virgula')
    .&End
  .Find;
end;
```


