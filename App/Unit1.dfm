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
    TabOrder = 1
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
        Caption = 'Tempo (s)'
      end
      item
        Caption = 'Distancia (m)'
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
      
        '01_PE_RCE_01'#9'CASE ARCOVERDE AVENIDA DOM PEDRO II, S/N - ARCOVERD' +
        'E'
      
        '01_PE_RCE_01'#9'COLONIA PENAL FEMININA DE BUIQUE RUA AURORA LAERTE ' +
        'CAVALCANTI, S/N - BUIQUE'
      
        '01_PE_RCE_01'#9'PRESIDIO ADVOGADO BRITO ALVES RUA NOVA PROJETADA, S' +
        '/N - ARCOVERDE'
      
        '01_PE_RCE_01'#9'PRESIDIO DESEMBARGADOR AUGUSTO DUQUE LOTEAMENTO NOV' +
        'O PONTAL, S/N - PESQUEIRA')
    ScrollBars = ssBoth
    TabOrder = 4
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
    TabOrder = 2
    OnClick = btn2Click
  end
  object con1: TUniConnection
    ProviderName = 'SQLite'
    Database = 'D:\Delphi\Monta_rotas\dbENEM2018.db'
    LoginPrompt = False
    Left = 384
    Top = 128
  end
  object unqry1: TUniQuery
    Connection = con1
    Left = 384
    Top = 184
  end
  object sqltnprvdr1: TSQLiteUniProvider
    Left = 384
    Top = 80
  end
end
