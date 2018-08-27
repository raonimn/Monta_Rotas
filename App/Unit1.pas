unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  UWebGMapsCommon, UWebGMaps, Vcl.ComCtrls, UWebGMapsMarkers, Vcl.Clipbrd;

type
  TForm1 = class(TForm)
    lv1: TListView;
    mmo1: TMemo;
    gmap1: TWebGMaps;
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure lv1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure btn2Click(Sender: TObject);
    procedure gmap1WebGMapsError(Sender: TObject; ErrorType: TErrorType);
  private
    { Private declarations }
    Descending: Boolean;
    SortedColumn: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
const
  origem: string = 'AVENIDA GENERAL SAN MARTIN, 1083 RECIFE PE';
  destino: string = 'AVENIDA GENERAL SAN MARTIN, 1083 RECIFE PE';
var
  pontos: TStringlist;
  I: Integer;
  m: TMarker;
  item: TListItem;
  percorre: TStringList;
  rota: string;
  qt: Integer;
begin
  lv1.Clear;
  percorre := TStringList.Create;
  percorre.StrictDelimiter := true;
  percorre.Delimiter := Chr(9);
  for I := 0 to mmo1.Lines.Count - 1 do
  begin
    percorre.DelimitedText := mmo1.Lines[I];
    item := lv1.Items.Add;
    item.Caption := percorre[0];
    item.SubItems.Add(percorre[1]);
    item.SubItems.Add('');
    item.SubItems.Add('');
    item.SubItems.Add('');
  end;

  gmap1.Routing.Clear;
  gmap1.RemoveAllDirections;
  pontos := TSTringlist.Create;

  for I := 0 to lv1.Items.Count - 1 do
  begin
    pontos.Add(lv1.Items[I].SubItems[0]);

  end;

//Traça a rota


  gmap1.GetDirections(origem, destino, False, tmDriving, usMetric, lnPortuguese, False, false, pontos, true);

  ShowMessage(pontos.Text);
  if gmap1.Directions.Count > 0 then
  begin
    qt := gmap1.Directions[0].Legs.Count;
    for I := 0 to gmap1.Directions[0].Legs.Count - 2 do
    begin
      lv1.Items[gmap1.Directions[0].Legs[I].WayPointIndex].SubItems[1] := inttostr(I + 1);
      lv1.Items[gmap1.Directions[0].Legs[I].WayPointIndex].SubItems[2] := gmap1.Directions[0].Legs[I].DurationText;
      lv1.Items[gmap1.Directions[0].Legs[I].WayPointIndex].SubItems[3] := gmap1.Directions[0].Legs[I].DistanceText;
    end;
    item := lv1.Items.Add;
    item.Caption := '01_PE_RCE_01';
    item.SubItems.Add('CTE Recife');
    item.SubItems.Add(IntToStr(qt));
    item.SubItems.Add(gmap1.Directions[0].Legs[qt - 1].DurationText);
    item.SubItems.Add(gmap1.Directions[0].Legs[qt - 1].DistanceText);

  end;

  mmo1.Clear;
  pontos.Free;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  I: Integer;
  t, l: string;
  J: Integer;
begin

  t := '';
  l := '';
  for I := 0 to lv1.Items.Count - 1 do
  begin
    l := lv1.Items[I].Caption;
    for J := 0 to lv1.Items[I].SubItems.Count - 1 do
    begin
      l := l + chr(9) + lv1.Items[I].SubItems[J];
    end;
    t := t + l + sLineBreak;

  end;
  Clipboard.AsText := t;
end;

procedure TForm1.gmap1WebGMapsError(Sender: TObject; ErrorType: TErrorType);
begin
  if ErrorType = etGMapsProblem then
    showmessage('problema no GMAPs')
  else if ErrorType = etScreenshotProblem then
    showmessage('problema no screenshot')
  else if ErrorType = etJavascriptError then
    showmessage('problema no JavaScript')
  else if ErrorType = etNotValidMarker then
    showmessage('Marcador inválido')
  else if ErrorType = etStreetViewUnknownError then
    showmessage('Erro não identificado no street view')
  else if ErrorType = etStreetViewNoResults then
    showmessage('Sem resultado para o strret view')
  else if ErrorType = etInvalidWaypoint then
    showmessage('Waypoint inválido')
  else
    showmessage('Fudeu!!!');

end;

procedure TForm1.lv1ColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index <> SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end
  else
    Descending := not Descending;
  TListView(Sender).SortType := stText;
end;

procedure TForm1.lv1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else if SortedColumn <> 0 then
    Compare := CompareText(Item1.SubItems[SortedColumn - 1], Item2.SubItems[SortedColumn - 1]);
  if Descending then
    Compare := -Compare;
end;

end.

