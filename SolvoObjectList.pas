unit SolvoObjectList;

interface

uses
  System.Generics.Collections, SolvoDAO;

type
  { Nao e possivel criar um Helper de classes Genericas :( }
  TSolvoObjectList<T: class> = class(TObjectList<T>)
    private
      FPos: Integer;
      FObjeto: T;
      FEof: Boolean;
      FMode: TModo;

      function getObjectItem: T;
      function getMode: TModo;
      procedure setMode(const aMode: TModo);
    public
      procedure Next;
      procedure Prior;
      procedure First;
      procedure Last;
      procedure Insert(const aValue: T; const aMode: TModo = tmBROWSE);
      procedure Remove;

    published
      property ObjectItem: T read getObjectItem;
      property Pos: Integer read FPos write FPos default 0;
      property Eof: Boolean read FEof default False;
      property Mode: TModo read getMode write setMode;
  end;

implementation

{ TSolvoObjectList<T> }

procedure TSolvoObjectList<T>.Insert(const aValue: T; const aMode: TModo);
begin
  (aValue as TSolvoDAO).Modo := aMode;
  self.Add(aValue);
  FPos := self.Count - 1;
end;

procedure TSolvoObjectList<T>.Remove;
begin
  self.Delete(FPos);
  if FPos > 0 then
   FPos := FPos - 1;
end;

procedure TSolvoObjectList<T>.setMode(const aMode: TModo);
begin
  FMode := aMode;
  (ObjectItem as TSolvoDAO).Modo := aMode;
end;

procedure TSolvoObjectList<T>.First;
begin
  FPos := 0;
  FEof := False;
end;

function TSolvoObjectList<T>.getMode: TModo;
begin
  FMode  := (ObjectItem as TSolvoDAO).Modo;
  Result := FMode;
end;

function TSolvoObjectList<T>.getObjectItem: T;
begin
  Result := self.Items[Pos];
end;

procedure TSolvoObjectList<T>.Last;
begin
  FPos := self.Count;
  FEof := False;
end;

procedure TSolvoObjectList<T>.Next;
begin
  if FPos + 1 >= self.Count then
   FEof := True
  else
   begin
    FPos := FPos + 1;
    FEof := False;
   end;
end;

procedure TSolvoObjectList<T>.Prior;
begin
  FEof := False;
  if FPos - 1 >= 0 then
    FPos := FPos + 1;
end;

end.
