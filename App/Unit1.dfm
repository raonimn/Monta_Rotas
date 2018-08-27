object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 557
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gmap1: TWebGMaps
    AlignWithMargins = True
    Left = 3
    Top = 218
    Width = 629
    Height = 336
    Align = alClient
    APIKey = 'AIzaSyBVE8YZZJufdUvrWsmiQo7iN141qUmI9Fs'
    AutoLaunch = False
    Clusters = <>
    Markers = <>
    Polylines = <>
    Polygons = <>
    Directions = <>
    MapOptions.DefaultLatitude = 48.859040000000000000
    MapOptions.DefaultLongitude = 2.294297000000000000
    Routing.PolylineOptions.Icons = <>
    StreetViewOptions.DefaultLatitude = 48.859040000000000000
    StreetViewOptions.DefaultLongitude = 2.294297000000000000
    MapPersist.Location = mplInifile
    MapPersist.Key = 'WebGMaps'
    MapPersist.Section = 'MapBounds'
    PolygonLabel.Font.Charset = DEFAULT_CHARSET
    PolygonLabel.Font.Color = clBlack
    PolygonLabel.Font.Height = -16
    PolygonLabel.Font.Name = 'Arial'
    PolygonLabel.Font.Style = []
    TabOrder = 2
    Version = '2.9.7.0'
    OnWebGMapsError = gmap1WebGMapsError
  end
  object lv1: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 629
    Height = 209
    Align = alTop
    Columns = <
      item
        Caption = 'Rota'
      end
      item
        Caption = 'Escola'
      end
      item
        Caption = 'Posi'#231#227'o'
      end
      item
        Caption = 'Tempo'
      end
      item
        Caption = 'Distancia'
      end>
    MultiSelect = True
    RowSelect = True
    SortType = stData
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lv1ColumnClick
    OnCompare = lv1Compare
  end
  object mmo1: TMemo
    Left = 8
    Top = 460
    Width = 385
    Height = 89
    Lines.Strings = (
      '01_PE_RCE_01'#9'EE LUIZ DELGADO RECIFE PE'
      '01_PE_RCE_01'#9'ESCOLA JOAO BARBALHO RECIFE PE'
      '01_PE_RCE_01'#9'CEJA VALDEMAR DE OLIVEIRA RECIFE PE'
      '01_PE_RCE_01'#9'EE CONEGO ROCHAEL DE MEDEIROS RECIFE PE'
      '01_PE_RCE_01'#9'EE SYLVIO RABELLO RECIFE PE'
      '01_PE_RCE_01'#9'EREM ANIBAL FERNANDES RECIFE PE'
      '01_PE_RCE_01'#9'EREM SIZENANDO SILVEIRA RECIFE PE')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object btn1: TButton
    Left = 464
    Top = 392
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 3
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 288
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = btn2Click
  end
end
