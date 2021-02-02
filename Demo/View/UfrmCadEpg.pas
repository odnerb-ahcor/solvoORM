unit UfrmCadEpg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.StdCtrls, SolvoAttributes,
  SolvoDAO, UContratoController, UPessoaController;

type
  TfrmCadEpg = class(TForm)
    GroupBox1: TGroupBox;
    [Bind('NomePessoa')]
    edtNome: TEdit;
    GroupBox2: TGroupBox;
    [Bind('InscricaoPessoa')]
    edtIns: TMaskEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    [Bind('DataAdmissao')]
    edtDtaAdm: TDateTimePicker;
    [Bind('SalarioContrato')]
    edtSalEpg: TMaskEdit;
    GroupBox5: TGroupBox;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    objPessoa: TPessoaController;
    objContrato: TContratoController;

    procedure SaveObject;
    procedure LoadObject;
  public
    { Public declarations }
    class function Execute(aContrato: TContratoController): Boolean;

  end;

var
  frmCadEpg: TfrmCadEpg;

implementation

{$R *.dfm}

{ TfrmCadEpg }


procedure TfrmCadEpg.Button1Click(Sender: TObject);
begin
  SaveObject;
end;

procedure TfrmCadEpg.Button2Click(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

class function TfrmCadEpg.Execute(aContrato: TContratoController): Boolean;
var
  objForm: TfrmCadEpg;
begin
  objForm := TfrmCadEpg.Create(nil);

  try
    objForm.objContrato       := aContrato;
    Result := objForm.ShowModal = mrOK;
  finally
    objForm.Free;
  end;
end;

procedure TfrmCadEpg.FormShow(Sender: TObject);
begin
  LoadObject();
end;

procedure TfrmCadEpg.SaveObject;
begin
  objPessoa.ORM.Save;
  objContrato.ORM.LoadFK(objPessoa.Pessoa);
  objContrato.ORM.Save(True);

  self.ModalResult := mrOk;
end;

procedure TfrmCadEpg.LoadObject;
begin
  if objContrato.Contrato.Modo = tmNEW then
    begin
      objPessoa := TPessoaController.New;
      objPessoa
        .BindForm(Self)
      .NewFuncionario;

      objContrato.BindForm(Self);
    end
  else
   begin
     objContrato.BindForm(Self).BindShow;

     objPessoa := TPessoaController.New;
     objPessoa
       .Find(objContrato.Contrato.CodigoPessoa)
       .BindForm(Self)
     .BindShow;
   end;

end;

procedure TfrmCadEpg.FormDestroy(Sender: TObject);
begin
  objPessoa.Free;
end;

end.


