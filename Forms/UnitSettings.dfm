object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 365
  ClientWidth = 537
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    537
    365)
  PixelsPerInch = 96
  TextHeight = 13
  object sButton1: TButton
    Left = 454
    Top = 332
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 0
    OnClick = sButton1Click
  end
  object sButton2: TButton
    Left = 8
    Top = 332
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Reset'
    TabOrder = 1
    OnClick = sButton2Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 521
    Height = 318
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet3: TTabSheet
      Caption = 'General'
      ImageIndex = 2
      object Label3: TLabel
        Left = 8
        Top = 55
        Width = 132
        Height = 13
        Caption = 'Link add timeout (seconds):'
      end
      object Label4: TLabel
        Left = 3
        Top = 102
        Width = 244
        Height = 13
        Caption = 'Download rate limit per process (0 = no limit) in KB:'
      end
      object CheckUpdateBtn: TCheckBox
        Left = 3
        Top = 3
        Width = 132
        Height = 20
        Caption = 'Check updates on start'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object CheckYoutubeDlUpdateBtn: TCheckBox
        Left = 3
        Top = 29
        Width = 193
        Height = 17
        Caption = 'Check youtube-dl update at start'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object LinkAddTimeOutEdit: TJvSpinEdit
        Left = 146
        Top = 52
        Width = 75
        Height = 21
        CheckOptions = [coCheckOnExit, coCropBeyondLimit]
        CheckMaxValue = False
        Alignment = taCenter
        ButtonKind = bkClassic
        MinValue = 15.000000000000000000
        Value = 60.000000000000000000
        TabOrder = 2
      end
      object RateLimitEdit: TJvSpinEdit
        Left = 253
        Top = 99
        Width = 125
        Height = 21
        CheckMinValue = True
        Alignment = taCenter
        ButtonKind = bkClassic
        TabOrder = 3
      end
      object DroppedLinksArePlaylistsBtn: TCheckBox
        Left = 3
        Top = 79
        Width = 213
        Height = 17
        Caption = 'Treat dropped links as playlist/user'
        TabOrder = 4
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Download'
      object Label1: TLabel
        Left = 16
        Top = 6
        Width = 81
        Height = 13
        Caption = 'Prefered format:'
      end
      object Label2: TLabel
        Left = 8
        Top = 65
        Width = 117
        Height = 13
        Caption = 'Parallel download count:'
      end
      object Label6: TLabel
        Left = 3
        Top = 176
        Width = 123
        Height = 13
        Caption = 'Output file name pattern:'
      end
      object PreferedFormatEdit: TEdit
        Left = 103
        Top = 3
        Width = 407
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'mp4, 1080p, DASH, video'
      end
      object DashVideoBtn: TCheckBox
        Left = 3
        Top = 30
        Width = 274
        Height = 20
        Caption = 'When a "DASH" video is selected download audio too'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object ProcessCountBar: TTrackBar
        Left = 184
        Top = 61
        Width = 326
        Height = 23
        Max = 16
        Min = 1
        Position = 4
        ShowSelRange = False
        TabOrder = 2
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = ProcessCountBarChange
      end
      object ProcessCountEdit: TEdit
        Left = 129
        Top = 60
        Width = 49
        Height = 21
        Alignment = taCenter
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = '4'
      end
      object DontDoubleDownloadBtn: TCheckBox
        Left = 3
        Top = 90
        Width = 248
        Height = 20
        Caption = 'Don'#39't download again if  local file contains audio'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object DontPreviewImgBtn: TCheckBox
        Left = 3
        Top = 116
        Width = 233
        Height = 20
        Caption = 'Don'#39't download video preview images'
        TabOrder = 5
      end
      object PlaySoundBtn: TCheckBox
        Left = 3
        Top = 142
        Width = 196
        Height = 20
        Caption = 'Play a sound when download is done'
        TabOrder = 6
      end
      object FilePatternList: TComboBox
        Left = 132
        Top = 173
        Width = 378
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 7
        Text = '%(title)s.%(ext)s'
        Items.Strings = (
          '%(title)s.%(ext)s'
          '%(uploader)s.%(ext)s'
          '%(upload_date)s.%(title)s.%(ext)s'
          '%(upload_date)s.%(uploader)s.%(ext)s'
          '%(playlist_title)s.%(title)s.%(ext)s'
          '%(playlist_title)s.%(playlist_index)s.%(ext)s'
          '%(uploader)s.%(title)s.%(ext)s'
          '%(title)s.%(uploader)s.%(ext)s')
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Subtitle'
      ImageIndex = 1
      object Label5: TLabel
        Left = 5
        Top = 6
        Width = 135
        Height = 13
        Caption = 'Preferred subtitle language:'
      end
      object MuxSubBtn: TCheckBox
        Left = 3
        Top = 30
        Width = 190
        Height = 17
        Caption = 'Mux subtitle to mp4 and webm'
        TabOrder = 0
        OnClick = MuxSubBtnClick
      end
      object SubLangList: TComboBox
        Left = 146
        Top = 3
        Width = 281
        Height = 21
        Style = csDropDownList
        ItemIndex = 39
        TabOrder = 1
        Text = 'en - English - English'
        Items.Strings = (
          'ab - Abkhaz - '#1072#1191#1089#1091#1072
          'aa - Afar - Afaraf'
          'af - Afrikaans - Afrikaans'
          'ak - Akan - Akan'
          'sq - Albanian - Shqip'
          'am - Amharic - '#4768#4635#4653#4763
          'ar - Arabic - '#1575#1604#1593#1585#1576#1610#1577
          'an - Aragonese - Aragon'#233's'
          'hy - Armenian - '#1344#1377#1397#1381#1408#1381#1398
          'as - Assamese - '#2437#2488#2478#2496#2479#2492#2494
          'av - Avaric - '#1072#1074#1072#1088' '#1084#1072#1094#1216', '#1084#1072#1075#1216#1072#1088#1091#1083' '#1084#1072#1094#1216
          'ae - Avestan - avesta'
          'ay - Aymara - aymar aru'
          'az - Azerbaijani - az'#601'rbaycan dili'
          'bm - Bambara - bamanankan'
          'ba - Bashkir - '#1073#1072#1096#1185#1086#1088#1090' '#1090#1077#1083#1077
          'eu - Basque - euskara, euskera'
          'be - Belarusian - '#1041#1077#1083#1072#1088#1091#1089#1082#1072#1103
          'bn - Bengali - '#2476#2494#2434#2482#2494
          'bh - Bihari - '#2349#2379#2332#2346#2369#2352#2368
          'bi - Bislama - Bislama'
          'bs - Bosnian - bosanski jezik'
          'br - Breton - brezhoneg'
          'bg - Bulgarian - '#1073#1098#1083#1075#1072#1088#1089#1082#1080' '#1077#1079#1080#1082
          'my - Burmese - '#4119#4121#4140#4101#4140
          'ca - Catalan; Valencian - Catal'#224
          'ch - Chamorro - Chamoru'
          'ce - Chechen - '#1085#1086#1093#1095#1080#1081#1085' '#1084#1086#1090#1090
          'ny - Chichewa; Chewa; Nyanja - chiChe'#373'a, chinyanja'
          'zh - Chinese - '#20013#25991' (Zh'#333'ngw'#233'n), '#27721#35821', '#28450#35486
          'cv - Chuvash - '#1095#1233#1074#1072#1096' '#1095#1239#1083#1093#1080
          'kw - Cornish - Kernewek'
          'co - Corsican - corsu, lingua corsa'
          'cr - Cree - '#5312#5158#5123#5421#5133#5135#5155
          'hr - Croatian - hrvatski'
          'cs - Czech - '#269'esky, '#269'e'#353'tina'
          'da - Danish - dansk'
          'dv - Divehi; Dhivehi; Maldivian; - '#1931#1960#1928#1964#1920#1960
          'nl - Dutch - Nederlands, Vlaams'
          'en - English - English'
          'eo - Esperanto - Esperanto'
          'et - Estonian - eesti, eesti keel'
          'ee - Ewe - E'#651'egbe'
          'fo - Faroese - f'#248'royskt'
          'fj - Fijian - vosa Vakaviti'
          'fi - Finnish - suomi, suomen kieli'
          'fr - French - fran'#231'ais, langue fran'#231'aise'
          'ff - Fula; Fulah; Pulaar; Pular - Fulfulde, Pulaar, Pular'
          'gl - Galician - Galego'
          'ka - Georgian - '#4325#4304#4320#4311#4323#4314#4312
          'de - German - Deutsch'
          'el - Greek, Modern - '#917#955#955#951#957#953#954#940
          'gn - Guaran'#237' - Ava'#241'e'#7869
          'gu - Gujarati - '#2711#2753#2716#2736#2750#2724#2752
          'ht - Haitian; Haitian Creole - Krey'#242'l ayisyen'
          'ha - Hausa - Hausa, '#1607#1614#1608#1615#1587#1614
          'he - Hebrew (modern) - '#1506#1489#1512#1497#1514
          'hz - Herero - Otjiherero'
          'hi - Hindi - '#2361#2367#2344#2381#2342#2368', '#2361#2367#2306#2342#2368
          'ho - Hiri Motu - Hiri Motu'
          'hu - Hungarian - Magyar'
          'ia - Interlingua - Interlingua'
          'id - Indonesian - Bahasa Indonesia'
          
            'ie - Interlingue - Originally called Occidental; then Interlingu' +
            'e after WWII'
          'ga - Irish - Gaeilge'
          'ig - Igbo - As'#7909's'#7909' Igbo'
          'ik - Inupiaq - I'#241'upiaq, I'#241'upiatun'
          'io - Ido - Ido'
          'is - Icelandic - '#205'slenska'
          'it - Italian - Italiano'
          'iu - Inuktitut - '#5123#5316#5251#5198#5200#5222
          'ja - Japanese - '#26085#26412#35486' ('#12395#12411#12435#12372#65295#12395#12387#12413#12435#12372')'
          'jv - Javanese - basa Jawa'
          'kl - Kalaallisut, Greenlandic - kalaallisut, kalaallit oqaasii'
          'kn - Kannada - '#3221#3240#3277#3240#3233
          'kr - Kanuri - Kanuri'
          'ks - Kashmiri - '#2325#2358#2381#2350#2368#2352#2368', '#1603#1588#1605#1610#1585#1610#8206
          'kk - Kazakh - '#1178#1072#1079#1072#1179' '#1090#1110#1083#1110
          'km - Khmer - '#6039#6070#6047#6070#6017#6098#6040#6082#6042
          'ki - Kikuyu, Gikuyu - G'#297'k'#361'y'#361
          'rw - Kinyarwanda - Ikinyarwanda'
          'ky - Kirghiz, Kyrgyz - '#1082#1099#1088#1075#1099#1079' '#1090#1080#1083#1080
          'kv - Komi - '#1082#1086#1084#1080' '#1082#1099#1074
          'kg - Kongo - KiKongo'
          'ko - Korean - '#54620#44397#50612' ('#38867#22283#35486'), '#51312#49440#47568' ('#26397#39854#35486')'
          'kj - Kwanyama, Kuanyama - Kuanyama'
          'la - Latin - latine, lingua latina'
          'lb - Luxembourgish, Letzeburgesch - L'#235'tzebuergesch'
          'lg - Luganda - Luganda'
          'li - Limburgish, Limburgan, Limburger - Limburgs'
          'ln - Lingala - Ling'#225'la'
          'lo - Lao - '#3742#3762#3754#3762#3749#3762#3751
          'lt - Lithuanian - lietuvi'#371' kalba'
          'lu - Luba-Katanga - '
          'lv - Latvian - latvie'#353'u valoda'
          'gv - Manx - Gaelg, Gailck'
          'mk - Macedonian - '#1084#1072#1082#1077#1076#1086#1085#1089#1082#1080' '#1112#1072#1079#1080#1082
          'mg - Malagasy - Malagasy fiteny'
          'ms - Malay - bahasa Melayu, '#1576#1607#1575#1587' '#1605#1604#1575#1610#1608#8206
          'ml - Malayalam - '#3374#3378#3375#3390#3379#3330
          'mt - Maltese - Malti'
          'mi - M'#257'ori - te reo M'#257'ori'
          'mr - Marathi (Mar'#257#7789'h'#299') - '#2350#2352#2366#2336#2368
          'mh - Marshallese - Kajin M'#807'aje'#316
          'mn - Mongolian - '#1084#1086#1085#1075#1086#1083
          'na - Nauru - Ekakair'#361' Naoero'
          'nv - Navajo, Navaho - Din'#233' bizaad, Din'#233'k'#700'eh'#496#237
          'nb - Norwegian Bokm'#229'l - Norsk bokm'#229'l'
          'nd - North Ndebele - isiNdebele'
          'ne - Nepali - '#2344#2375#2346#2366#2354#2368
          'ng - Ndonga - Owambo'
          'nn - Norwegian Nynorsk - Norsk nynorsk'
          'no - Norwegian - Norsk'
          'ii - Nuosu - '#41352#41760#42175' Nuosuhxop'
          'nr - South Ndebele - isiNdebele'
          'oc - Occitan - Occitan'
          'oj - Ojibwe, Ojibwa - '#5130#5314#5393#5320#5167#5287#5134#5328
          
            'cu - Old Church Slavonic, Church Slavic, Church Slavonic, Old Bu' +
            'lgarian, Old Slavonic - '#1129#1079#1099#1082#1098' '#1089#1083#1086#1074#1123#1085#1100#1089#1082#1098
          'om - Oromo - Afaan Oromoo'
          'or - Oriya - '#2835#2849#2876#2879#2822
          'os - Ossetian, Ossetic - '#1080#1088#1086#1085' '#230#1074#1079#1072#1075
          'pa - Panjabi, Punjabi - '#2602#2672#2588#2622#2604#2624', '#1662#1606#1580#1575#1576#1740#8206
          'pi - P'#257'li - '#2346#2366#2356#2367
          'fa - Persian - '#1601#1575#1585#1587#1740
          'pl - Polish - polski'
          'ps - Pashto, Pushto - '#1662#1690#1578#1608
          'pt - Portuguese - Portugu'#234's'
          'qu - Quechua - Runa Simi, Kichwa'
          'rm - Romansh - rumantsch grischun'
          'rn - Kirundi - kiRundi'
          'ro - Romanian, Moldavian, Moldovan - rom'#226'n'#259
          'ru - Russian - '#1088#1091#1089#1089#1082#1080#1081' '#1103#1079#1099#1082
          'sa - Sanskrit (Sa'#7745'sk'#7771'ta) - '#2360#2306#2360#2381#2325#2371#2340#2350#2381
          'sc - Sardinian - sardu'
          'sd - Sindhi - '#2360#2367#2344#2381#2343#2368', '#1587#1606#1676#1610#1548' '#1587#1606#1583#1726#1740#8206
          'se - Northern Sami - Davvis'#225'megiella'
          'sm - Samoan - gagana faa Samoa'
          'sg - Sango - y'#226'ng'#226' t'#238' s'#228'ng'#246
          'sr - Serbian - '#1089#1088#1087#1089#1082#1080' '#1112#1077#1079#1080#1082
          'gd - Scottish Gaelic; Gaelic - G'#224'idhlig'
          'sn - Shona - chiShona'
          'si - Sinhala, Sinhalese - '#3523#3538#3458#3524#3517
          'sk - Slovak - sloven'#269'ina'
          'sl - Slovene - sloven'#353#269'ina'
          'so - Somali - Soomaaliga, af Soomaali'
          'st - Southern Sotho - Sesotho'
          'es - Spanish; Castilian - espa'#241'ol, castellano'
          'su - Sundanese - Basa Sunda'
          'sw - Swahili - Kiswahili'
          'ss - Swati - SiSwati'
          'sv - Swedish - svenska'
          'ta - Tamil - '#2980#2990#3007#2996#3021
          'te - Telugu - '#3108#3142#3122#3137#3095#3137
          'tg - Tajik - '#1090#1086#1207#1080#1082#1251', to'#287'ik'#299', '#1578#1575#1580#1740#1705#1740#8206
          'th - Thai - '#3652#3607#3618
          'ti - Tigrinya - '#4725#4877#4653#4763
          'bo - Tibetan Standard, Tibetan, Central - '#3926#3964#3921#3851#3937#3954#3906
          'tk - Turkmen - T'#252'rkmen, '#1058#1199#1088#1082#1084#1077#1085
          'tl - Tagalog - Wikang Tagalog, '#5903#5906#5891#5893#5908' '#5894#5892#5902#5907#5892#5908
          'tn - Tswana - Setswana'
          'to - Tonga (Tonga Islands) - faka Tonga'
          'tr - Turkish - T'#252'rk'#231'e'
          'ts - Tsonga - Xitsonga'
          'tt - Tatar - '#1090#1072#1090#1072#1088#1095#1072', tatar'#231'a, '#1578#1575#1578#1575#1585#1670#1575#8206
          'tw - Twi - Twi'
          'ty - Tahitian - Reo Tahiti'
          'ug - Uighur, Uyghur - Uy'#419'urq'#601', '#1574#1735#1610#1594#1735#1585#1670#1749#8206
          'uk - Ukrainian - '#1091#1082#1088#1072#1111#1085#1089#1100#1082#1072
          'ur - Urdu - '#1575#1585#1583#1608
          'uz - Uzbek - zbek, '#1038#1079#1073#1077#1082', '#1571#1735#1586#1576#1744#1603#8206
          've - Venda - Tshiven'#7699'a'
          'vi - Vietnamese - Ti'#7871'ng Vi'#7879't'
          'vo - Volap'#252'k - Volap'#252'k'
          'wa - Walloon - Walon'
          'cy - Welsh - Cymraeg'
          'wo - Wolof - Wollof'
          'fy - Western Frisian - Frysk'
          'xh - Xhosa - isiXhosa'
          'yi - Yiddish - '#1497#1497#1460#1491#1497#1513
          'yo - Yoruba - Yor'#249'b'#225
          'za - Zhuang, Chuang - Sa'#623' cue'#331#389', Saw cuengh"}')
      end
      object DeleteSubAfterMuxBtn: TCheckBox
        Left = 3
        Top = 53
        Width = 206
        Height = 17
        Caption = 'Delete subtitles after muxing them'
        Enabled = False
        TabOrder = 2
      end
    end
  end
end
