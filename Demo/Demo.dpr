program Demo;

uses
  Vcl.Forms,
  UfrmPrincipal in 'UfrmPrincipal.pas' {frmPrincipal},
  SolvoAttributes in '..\SolvoAttributes.pas',
  SolvoDAOSQLAttribute in '..\SolvoDAOSQLAttribute.pas',
  SolvoInterface in '..\SolvoInterface.pas',
  SolvoORM in '..\SolvoORM.pas',
  SolvoQueryFiredac in '..\SolvoQueryFiredac.pas',
  SolvoRTTI in '..\SolvoRTTI.pas',
  SolvoRTTIHelper in '..\SolvoRTTIHelper.pas',
  SolvoSQL in '..\SolvoSQL.pas',
  SolvoUtil in '..\SolvoUtil.pas',
  SolvoValidator in '..\SolvoValidator.pas',
  UdmConexao in 'UdmConexao.pas' {dmConexao: TDataModule},
  UPessoa in 'Models\UPessoa.pas',
  SolvoDAO in '..\SolvoDAO.pas',
  UContrato in 'Models\UContrato.pas',
  UContratoController in 'Controller\UContratoController.pas',
  SolvoDAOJoinAttribute in '..\SolvoDAOJoinAttribute.pas',
  UfrmCadEpg in 'View\UfrmCadEpg.pas' {frmCadEpg},
  UPessoaController in 'Controller\UPessoaController.pas',
  SolvoObjectList in '..\SolvoObjectList.pas',
  SolvoComponents in '..\SolvoComponents.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := true;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.
