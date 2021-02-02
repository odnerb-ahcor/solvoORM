unit UdmConexao;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Moni.Base, FireDAC.Moni.Custom,
  FireDAC.Comp.UI, System.Classes, Data.DB, FireDAC.Comp.Client, Winapi.ShlObj;

type
  TdmConexao = class(TDataModule)
    Conecta: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDMoniCustomClientLink1: TFDMoniCustomClientLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FDialog: IFileDialog;
  public
    { Public declarations }
    property Dialog: IFileDialog  read FDialog write FDialog;
  end;

var
  dmConexao: TdmConexao;

implementation

{$R *.dfm}

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
 Conecta.Connected := True;
end;

end.
