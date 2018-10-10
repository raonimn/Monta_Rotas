unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  UWebGMapsCommon, UWebGMaps, Vcl.ComCtrls, UWebGMapsMarkers, Vcl.Clipbrd,
  UniProvider, SQLiteUniProvider, Data.DB, MemDS, DBAccess, Uni;

type
  TForm1 = class(TForm)
    lv1: TListView;
    mmo1: TMemo;
    gmap1: TWebGMaps;
    btn1: TButton;
    btn2: TButton;
    con1: TUniConnection;
    unqry1: TUniQuery;
    sqltnprvdr1: TSQLiteUniProvider;
    procedure btn1Click(Sender: TObject);
    procedure lv1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure btn2Click(Sender: TObject);
    procedure gmap1WebGMapsError(Sender: TObject; ErrorType: TErrorType);
  private
    { Private declarations }
    Descending: Boolean;
    SortedColumn: Integer;
    procedure eSalvar;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  Aorigem: array[0..5] of string;
  origem: string;
  distribuidora: string;
  pontos, distribuidoras: TStringlist;
  I, J: Integer;
  m: TMarker;
  item: TListItem;
  percorre: TStringList;
  rota: string;
  qt: Integer;
begin
  Aorigem[0] := '7°D Sup - Recife PE';                               //RCE
  Aorigem[1] := '4º BPM - BATALHÃO BARRETO DE MENEZES - Caruaru PE'; //CRU
  Aorigem[2] := '71º BIMtz - Garanhuns PE';                          //GRS
  Aorigem[3] := '3° Batalhão da Polícia Militar - ARCOVERDE PE';     //AVZ
  Aorigem[4] := '8°BPM Salgueiro - PE';                              //SGP
  Aorigem[5] := '72º BIMtz - Petrolina PE';                          //PNZ
  lv1.Clear;
  percorre := TStringList.Create;
  percorre.StrictDelimiter := true;
  percorre.Delimiter := Chr(9);


  //Busca as rotas no banco
  distribuidoras := TStringList.Create;

  try
    con1.connect;
    if con1.Connected then
    begin
      unqry1.SQL.Clear;
      unqry1.SQL.Text := 'SELECT Distribuidora FROM "Geo" group by Distribuidora;';
      unqry1.Open;
      unqry1.First;
      while not unqry1.Eof do
      begin
        distribuidoras.Add(unqry1.Fields[0].AsString);
        Unqry1.Next;
      end;
      unqry1.Close;
    end;
  finally
    con1.Disconnect;

  end;
  pontos := TStringList.Create;
  for I := 0 to distribuidoras.Count - 1 do
  begin
    distribuidora := distribuidoras[I];
    unqry1.SQL.Text := 'SELECT Local from Geo WHERE Distribuidora = ' + QuotedStr(distribuidora);
    if not con1.connected then
      con1.Connect;
    unqry1.Open;
    unqry1.First;
    pontos.Clear;
    while not unqry1.Eof do
    begin
      pontos.Add(unqry1.Fields[0].AsString);
      unqry1.Next;
    end;
    unqry1.Close;
    gmap1.Routing.Clear;
    gmap1.RemoveAllDirections;
    if AnsiPos('RCE', distribuidora) <> 0 then
      origem := Aorigem[0]
    else if AnsiPos('CRU', distribuidora) <> 0 then
      origem := Aorigem[1]
    else if AnsiPos('GRS', distribuidora) <> 0 then
      origem := Aorigem[2]
    else if AnsiPos('AVZ', distribuidora) <> 0 then
      origem := Aorigem[3]
    else if AnsiPos('SGP', distribuidora) <> 0 then
      origem := Aorigem[4]
    else if AnsiPos('PNZ', distribuidora) <> 0 then
      origem := Aorigem[5];

    gmap1.GetDirections(origem, origem, False, tmDriving, usMetric, lnPortuguese, False, false, pontos, true);

    if gmap1.Directions.Count > 0 then
    begin
      lv1.Items.Clear;
      for J := 0 to pontos.Count - 1 do
      begin
        item := lv1.Items.Add;
        item.Caption := distribuidora;
        item.SubItems.Add(pontos[J]);
        item.SubItems.Add('');
        item.SubItems.Add('');
        item.SubItems.Add('');
      end;
      qt := gmap1.Directions[0].Legs.Count;
      for J := 0 to gmap1.Directions[0].Legs.Count - 2 do
      begin
        lv1.Items[gmap1.Directions[0].Legs[J].WayPointIndex].SubItems[1] := inttostr(J + 1);
        lv1.Items[gmap1.Directions[0].Legs[J].WayPointIndex].SubItems[2] := IntToStr(gmap1.Directions[0].Legs[J].Duration);
        lv1.Items[gmap1.Directions[0].Legs[J].WayPointIndex].SubItems[3] := inttostr(gmap1.Directions[0].Legs[J].Distance);
      end;
      item := lv1.Items.Add;
      item.Caption := distribuidora;
      item.SubItems.Add(origem);
      item.SubItems.Add(IntToStr(qt));
      item.SubItems.Add(IntToStr(gmap1.Directions[0].Legs[qt - 1].Duration));
      item.SubItems.Add(IntToStr(gmap1.Directions[0].Legs[qt - 1].Distance));

    end;
    eSalvar;
  end;


  //Para cada rota, busca a rota
  //Grava os dados no Banco

//Traça a rota

  distribuidoras.Free;
  mmo1.Clear;
  pontos.Free;
end;

procedure TForm1.eSalvar;
var
  I: Integer;
  t, l: string;
  J: Integer;
  Arq: TStringlist;
  myFile: TextFile;
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
  AssignFile(myFile, 'd:\raoni\Rotas.txt');
  if not FileExists('d:\raoni\Rotas.txt') then
    ReWrite(myFile)
  else
    Append(myFile);
  write(myFile, t);
  CloseFile(myFile);
  {
  Arq := Tstringlist.Create;
  Arq.Text := t;
  Arq.SaveToFile('d:\raoni\Rotas.txt');
  Arq.Free;
}
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

