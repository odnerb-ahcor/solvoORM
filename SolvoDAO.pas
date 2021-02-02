unit SolvoDAO;

interface

uses
  SolvoAttributes;

Type
  TJoinType = (INNER, LEFT, RIGHT, FULL);
  TModo     = (tmBROWSE, tmNEW, tmEDIT, tmDELETE);


  TSolvoDao = class
    private
      FModo: TModo;
    published
      [Ignore]
      property Modo: TModo read FModo write FModo default tmBROWSE;
  end;

implementation

end.
