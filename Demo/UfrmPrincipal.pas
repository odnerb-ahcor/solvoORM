unit UfrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, UContratoController, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls;

type
  TfrmPrincipal = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Contrato: TContratoController;

    procedure LoadObject;
    procedure Edit;
    procedure Insert;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}
uses
  UfrmCadEpg;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  Insert();
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  Edit();
end;

procedure TfrmPrincipal.Edit;
begin
  if TfrmCadEpg.Execute(Contrato) then
    //
  else
    Contrato.ORM.Cancel;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  LoadObject;
end;

procedure TfrmPrincipal.Insert;
begin
  if TfrmCadEpg.Execute(Contrato.NovoEmpregado) then
    //
  else
    Contrato.ORM.Cancel;
end;

procedure TfrmPrincipal.LoadObject;
begin
  Contrato := TContratoController.New;
  Contrato
    .DataSource(DataSource1)
    .BindForm(self)
  .Find;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  Contrato.Free;
end;

end.
