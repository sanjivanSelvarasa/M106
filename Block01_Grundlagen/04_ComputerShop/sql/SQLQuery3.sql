--********************************************************************
-- Computershop: Skript zum Erstellen der Datenbank mit allen Tabellen
--********************************************************************

----------------------------------------------------------------------
-- Datenbank erstellen
----------------------------------------------------------------------
go
use master
go
drop database if exists ComputerShop
go
create database ComputerShop
go
use ComputerShop
go


drop table if exists Ort;
drop table if exists Lieferant;
drop table if exists Kunde;
drop table if exists Hersteller;
drop table if exists Bestellung;
drop table if exists BestehtAus;
drop table if exists Artikel;
----------------------------------------------------------------------
-- Tabellen erstellen (alphabetisch, ohne Beziehungen)
----------------------------------------------------------------------
create table Artikel (
  ArtikelId integer identity,
  Bez varchar(50),
  Preis decimal(9,2),
  fk_HerstellerId integer,
  fk_LieferantId integer,
  primary key(ArtikelId)
);

create table BestehtAus (
  BestehtAusId integer identity,
  Anzahl float,
  fk_ArtikelId integer,
  fk_BestellungId integer,
  primary key(BestehtAusId)
);

create table Bestellung (
  BestellungId integer identity,
  Datum date,
  fk_KundeId integer,
  primary key(BestellungId)
);

create table Hersteller (
  HerstellerId integer identity,
  Name varchar(40),
  primary key(HerstellerId)
);

create table Kunde (
  KundeId integer identity,
  Nachname varchar(40),
  Vorname varchar(40),
  Strasse varchar(40),
  Hausnummer varchar(5),
  fk_OrtId integer,
  primary key(KundeId)
);

create table Lieferant (
  LieferantId integer identity,
  Name varchar(40),
  primary key(LieferantId)
);

create table Ort (
  OrtId integer identity,
  Bez varchar(40),
  Plz varchar(10),
  primary key(OrtId)
);
go -- Wichtig: sonst sind die Tabellen nicht definitiv erstellt

----------------------------------------------------------------------
-- Beziehungen erstellen
----------------------------------------------------------------------
alter table Artikel add
  foreign key(fk_HerstellerId) references Hersteller(HerstellerId),
  foreign key(fk_LieferantId) references Lieferant(LieferantId);

alter table BestehtAus add
  foreign key(fk_ArtikelId) references Artikel(ArtikelId),
  foreign key(fk_BestellungId) references Bestellung(BestellungId);

alter table Bestellung add
  foreign key(fk_KundeId) references Kunde(KundeId);

alter table Kunde add
  foreign key(fk_OrtId) references Ort(OrtId);
go

-----------------------------------------------------------
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
  (Nachname,Vorname, Strasse, Hausnummer, fk_OrtId) values
  ('Bucher',  'Hans',     'Kantonsstrasse',     '51',       (select OrtId from Ort where Bez = 'Horw')),
  ('Fuchs',   'Lea',      'Br nigstrasse',      '12',       (select OrtId from Ort where Bez = 'Emmen')),
  ('Koch',    'Samuel',   'Luzernerstrasse',    '7',        (select OrtId from Ort where Bez = 'Kriens')),
  ('Roth',    'Monika',   'Bahnhofstrasse',     '13',       (select OrtId from Ort where Bez = 'Emmen')),
  ('Wild',    'Gerhard',  'Centralstarsse',     '37',       (select OrtId from Ort where Bez = 'Sursee')),
  ('Graf',    'Robert',   'Ettiswilerstrasse',  '8',        (select OrtId from Ort where Bez = 'Willisau')),
  ('Alt',     'Sonja',    'Flecken',            '15',       (select OrtId from Ort where Bez = 'Rothenburg')),
  ('Moser',   'Nadja',    'Badstrasse',         '26',       (select OrtId from Ort where Bez = 'Sursee')),
  ('Peier',   'Louis',    'Hirschengraben',     '52',       (select OrtId from Ort where Bez = 'Luzern')),
  ('Hofer',   'Rita',     'Z richstrasse',      '9',        (select OrtId from Ort where Bez = 'Luzern'));
go

----------------------------------------------------------------------
-- Tabelle Bestellung abfüllen
----------------------------------------------------------------------
insert into Bestellung
  (Datum,fk_KundeId) values
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
  (Anzahl,fk_ArtikelId, fk_BestellungId) values
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

--SELECT CONCAT(Kunde.Vorname, ' ', Kunde.Nachname) AS Kunde, Ort.Bez, Bestellung.Datum, Artikel.Bez, Artikel.Preis FROM Bestellung
--INNER JOIN Kunde ON Bestellung.fk_KundeId = Kunde.KundeId
--INNER JOIN ORT ON Kunde.fk_OrtId = Ort.OrtId
--INNER JOIN BestehtAus ON Bestellung.BestellungId = BestehtAus.fk_BestellungId
--INNER JOIN Artikel ON BestehtAus.fk_ArtikelId = Artikel.ArtikelId
--WHERE Kunde.Vorname = 'Lea' AND Kunde.Nachname = 'Fuchs'
--ORDER BY Bestellung.Datum;

--SELECT CONCAT(Kunde.Vorname, ' ', Kunde.Nachname) AS Kunde, BestehtAus.Anzahl AS 'Anzahl Bestellungen' FROM Kunde
--INNER JOIN Bestellung ON Kunde.KundeId = Bestellung.BestellungId
--INNER JOIN BestehtAus ON Bestellung.BestellungId = BestehtAus.fk_BestellungId
--ORDER BY BestehtAus.Anzahl DESC, Kunde.Nachname, Kunde.Vorname 

--SELECT CONCAT(Kunde.Vorname, ' ', Kunde.Nachname) AS Kunde, Ort.Bez, Bestellung.Datum, BestehtAus.Anzahl, Hersteller.Name, Artikel.Bez, Artikel.Preis, Lieferant.Name FROM Bestellung
--INNER JOIN Kunde ON Bestellung.fk_KundeId = Kunde.KundeId
--INNER JOIN Ort ON Kunde.fk_OrtId = Ort.OrtId
--INNER JOIN BestehtAus ON Bestellung.BestellungId = BestehtAus.fk_BestellungId
--INNER JOIN Artikel ON BestehtAus.fk_ArtikelId = Artikel.ArtikelId
--INNER JOIN Hersteller ON Artikel.fk_HerstellerId = Hersteller.HerstellerId
--INNER JOIN Lieferant ON Artikel.fk_LieferantId = Lieferant.LieferantId
--ORDER BY Bestellung.Datum DESC
--OFFSET 0 ROWS
--FETCH FIRST 1 ROWS ONLY

--SELECT Kunde.Vorname, Kunde.Nachname, FORMAT(SUM(Artikel.Preis), 'N2', 'de-CH') AS Umsatz FROM Bestellung
--INNER JOIN Kunde ON Bestellung.fk_KundeId = Kunde.KundeId
--INNER JOIN BestehtAus ON Bestellung.BestellungId = BestehtAus.fk_BestellungId
--INNER JOIN Artikel ON BestehtAus.fk_ArtikelId = Artikel.ArtikelId
--GROUP BY Kunde.Vorname, Kunde.Nachname
--ORDER BY Umsatz DESC

--SELECT 
-- CASE 
-- WHEN BestehtAus.Anzahl is NULL THEN 0
-- ELSE BestehtAus.Anzahl
-- END AS Anzahl, Artikel.Bez FROM Artikel
--LEFT JOIN BestehtAus ON Artikel.ArtikelId = BestehtAus.fk_ArtikelId
--ORDER BY BestehtAus.Anzahl DESC, Artikel.Bez ASC








