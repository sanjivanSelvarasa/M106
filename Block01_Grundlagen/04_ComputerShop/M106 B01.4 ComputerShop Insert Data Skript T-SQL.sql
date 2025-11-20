--********************************************************************
-- Computershop: Skript zum Einfügen der Daten
--********************************************************************

----------------------------------------------------------------------
-- Auf Datenbank ComputerShop positionieren
----------------------------------------------------------------------
use ComputerShop
go

----------------------------------------------------------------------
-- Tabelle Ort abfüllen
----------------------------------------------------------------------
insert into Ort
  (Bez,           Plz) values
  ('Sursee',      '6210'),
  ('Luzern',      '6000'),
  ('Horw',        '6048'),
  ('Kriens',      '6010'),
  ('Emmen',       '6032'),
  ('Willisau',    '6130'),
  ('Sempach',     '6204'),
  ('Entlebuch',   '6162'),
  ('Rothenburg',  '6023'),
  ('Meggen',      '6045')
go

----------------------------------------------------------------------
-- Tabelle Lieferant abfüllen
----------------------------------------------------------------------
insert into Lieferant
  ([Name]) values
  ('Brack'),
  ('Digitec'),
  ('Also'),
  ('Steg'),
  ('TechData'),
  ('Ingram Micro'),
  ('Littlebit'),
  ('Bechtle'),
  ('Alltron'),
  ('microspot');
go

----------------------------------------------------------------------
-- Tabelle Hersteller abfüllen
----------------------------------------------------------------------
insert into Hersteller
  ([Name]) values
  ('HP'),
  ('Asus'),
  ('Acer'),
  ('Dell'),
  ('Lenovo'),
  ('Brother'),
  ('Canon'),
  ('Epson'),
  ('Logitech'),
  ('Samsung');
go

----------------------------------------------------------------------
-- Tabelle Artikel abfüllen
----------------------------------------------------------------------
insert into Artikel
  (Bez,                         Preis,    fk_HerstellerId,                                                fk_LieferantId) values
  ('ProBook 650',               1449.00,  (select HerstellerId from Hersteller where Name = 'HP'),        (select LieferantId from Lieferant where Name = 'Brack')),
  ('MFC-L3770CDW Drucker',       529.00,  (select HerstellerId from Hersteller where Name = 'Brother'),   (select LieferantId from Lieferant where Name = 'Digitec')),
  ('ThinkPad T15',              1590.00,  (select HerstellerId from Hersteller where Name = 'Lenovo'),    (select LieferantId from Lieferant where Name = 'Steg')),
  ('LaserJet Pro MFP M227fdw',   359.00,  (select HerstellerId from Hersteller where Name = 'HP'),        (select LieferantId from Lieferant where Name = 'Digitec')),
  ('ZenBook Flip 15',           1499.00,  (select HerstellerId from Hersteller where Name = 'Asus'),      (select LieferantId from Lieferant where Name = 'Steg')),
  ('Asus TUF 27 Monitor',        530.00,  (select HerstellerId from Hersteller where Name = 'Asus'),      (select LieferantId from Lieferant where Name = 'Steg')),
  ('Perfection V850 Scanner',    949.00,  (select HerstellerId from Hersteller where Name = 'Epson'),     (select LieferantId from Lieferant where Name = 'Also')),
  ('MX Illuminated Keyboard',    105.00,  (select HerstellerId from Hersteller where Name = 'Logitech'),  (select LieferantId from Lieferant where Name = 'Littlebit')),
  ('MX Anywhere 3 Maus',          65.00,  (select HerstellerId from Hersteller where Name = 'Logitech'),  (select LieferantId from Lieferant where Name = 'TechData')),
  ('Galaxy S21 Ultra',          1230.00,  (select HerstellerId from Hersteller where Name = 'Samsung'),   (select LieferantId from Lieferant where Name = 'Brack'));
go

----------------------------------------------------------------------
-- Tabelle Kunde abfüllen
----------------------------------------------------------------------
insert into Kunde
  (Nachname,  Vorname,    Strasse,              Hausnummer, fk_OrtId) values
  ('Bucher',  'Hans',     'Kantonsstrasse',     '51',       (select OrtId from Ort where Bez = 'Horw')),
  ('Fuchs',   'Lea',      'Br�nigstrasse',      '12',       (select OrtId from Ort where Bez = 'Emmen')),
  ('Koch',    'Samuel',   'Luzernerstrasse',    '7',        (select OrtId from Ort where Bez = 'Kriens')),
  ('Roth',    'Monika',   'Bahnhofstrasse',     '13',       (select OrtId from Ort where Bez = 'Emmen')),
  ('Wild',    'Gerhard',  'Centralstarsse',     '37',       (select OrtId from Ort where Bez = 'Sursee')),
  ('Graf',    'Robert',   'Ettiswilerstrasse',  '8',        (select OrtId from Ort where Bez = 'Willisau')),
  ('Alt',     'Sonja',    'Flecken',            '15',       (select OrtId from Ort where Bez = 'Rothenburg')),
  ('Moser',   'Nadja',    'Badstrasse',         '26',       (select OrtId from Ort where Bez = 'Sursee')),
  ('Peier',   'Louis',    'Hirschengraben',     '52',       (select OrtId from Ort where Bez = 'Luzern')),
  ('Hofer',   'Rita',     'Z�richstrasse',      '9',        (select OrtId from Ort where Bez = 'Luzern'));
go

----------------------------------------------------------------------
-- Tabelle Bestellung abfüllen
----------------------------------------------------------------------
insert into Bestellung
  (Datum,         fk_KundeId) values
  ('2020-12-15',  (select KundeId from Kunde where Nachname = 'Fuchs')),
  ('2020-12-31',  (select KundeId from Kunde where Nachname = 'Wild')),
  ('2021-01-02',  (select KundeId from Kunde where Nachname = 'Graf')),
  ('2021-01-25',  (select KundeId from Kunde where Nachname = 'Hofer')),
  ('2021-02-03',  (select KundeId from Kunde where Nachname = 'Koch')),
  ('2021-02-11',  (select KundeId from Kunde where Nachname = 'Fuchs')),
  ('2021-02-15',  (select KundeId from Kunde where Nachname = 'Wild'));
go

----------------------------------------------------------------------
-- Tabelle BestehtAus abfüllen
----------------------------------------------------------------------
insert into BestehtAus
  (Anzahl,  fk_ArtikelId,                                                           fk_BestellungId) values
  (1,       (select ArtikelId from Artikel where Bez = 'ProBook 650'),              (select BestellungId from Bestellung where Datum = '2020-12-15')),
  (2,       (select ArtikelId from Artikel where Bez = 'MX Anywhere 3 Maus'),       (select BestellungId from Bestellung where Datum = '2020-12-15')),
  (1,       (select ArtikelId from Artikel where Bez = 'MX Illuminated Keyboard'),  (select BestellungId from Bestellung where Datum = '2020-12-15')),
  (1,       (select ArtikelId from Artikel where Bez = 'Asus TUF 27 Monitor'),      (select BestellungId from Bestellung where Datum = '2020-12-31')),
  (1,       (select ArtikelId from Artikel where Bez = 'ZenBook Flip 1'),           (select BestellungId from Bestellung where Datum = '2021-01-02')),
  (3,       (select ArtikelId from Artikel where Bez = 'LaserJet Pro MFP M227fdw'), (select BestellungId from Bestellung where Datum = '2021-01-25')),
  (1,       (select ArtikelId from Artikel where Bez = 'Galaxy S21 Ultra'),         (select BestellungId from Bestellung where Datum = '2021-02-03')),
  (2,       (select ArtikelId from Artikel where Bez = 'MFC-L3770CDW Drucker'),     (select BestellungId from Bestellung where Datum = '2021-02-11')),
  (2,       (select ArtikelId from Artikel where Bez = 'Asus TUF 27 Monitor'),      (select BestellungId from Bestellung where Datum = '2021-02-11')),
  (1,       (select ArtikelId from Artikel where Bez = 'MX Anywhere 3 Maus'),       (select BestellungId from Bestellung where Datum = '2020-02-11')),
  (1,       (select ArtikelId from Artikel where Bez = 'Galaxy S21 Ultra'),         (select BestellungId from Bestellung where Datum = '2021-02-15'));
go
