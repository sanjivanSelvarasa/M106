go
use master;
go
drop database if exists ArtikelKauf;
go
create database ArtikelKauf;
go
use ArtikelKauf;
go

drop table if exists Ort;
drop table if exists Kunde;
drop table if exists Kauft;
drop table if exists Gruppe;
drop table if exists Artikel;
---------------------------------------------------------------------
-- Tabellen erstellen
---------------------------------------------------------------------
create table Artikel (
  ArtikelId integer identity(1, 1) primary key,
  Bez varchar(50) not null,
  Preis decimal(9, 2),
  fk_GruppeId integer,
);

create table Gruppe (
  GruppeId integer identity(1, 1) primary key,
  Bez varchar(50)
);

create table Kauft
(
  KauftId integer identity(1, 1) primary key,
  fk_KundeId integer not null,
  fk_ArtikelId integer not null,
);

create table Kunde (
  KundeId integer identity(1, 1) primary key,
  Nachname varchar(50),
  Vorname varchar(50),
  fk_OrtId int,
);

create table Ort (
  OrtId integer identity(1, 1) primary key,
  PLZ varchar(10),
  Bez varchar(50),
  Kanton varchar(2)
);

---------------------------------------------------------------------
-- Foreign Key Beziehungen erstellen
---------------------------------------------------------------------
alter table Artikel add foreign key (fk_GruppeId)   references Gruppe(GruppeId)
alter table Kauft   add foreign key (fk_KundeId)    references Kunde(KundeId)
alter table Kauft   add foreign key (fk_ArtikelId)  references Artikel(ArtikelId)
alter table Kunde   add foreign key (fk_OrtId)      references Ort(OrtId)

---------------------------------------------------------------------
-- Daten einf�gen
---------------------------------------------------------------------
insert into Ort (PLZ, Bez, Kanton) values
('6020', 'Emmenbr�cke',   'LU'),
('6000', 'Luzern',        'LU'),
('6204', 'Sempach-Stadt', 'LU'),
('6023', 'Rothenburg',    'LU'),
('6210', 'Sursee',        'LU'),
('3555', 'Trubschachen',  'BE'),
('3600', 'Thun',          'BE'),
('6370', 'Stans',         'NW'),
('6060', 'Sarnen',        'OW'),
('6074', 'Giswil',        'OW'),
('6460', 'Altdorf',       'UR'),
('6343', 'Rotkreuz',      'ZG');

insert into Kunde (Nachname, Vorname, fk_OrtId) values
('B�hler',       'Rita',       (select OrtId from Ort where PLZ='6210')),
('Dobler',       'Max',        (select OrtId from Ort where PLZ='6460')),
('Heggli',       'Carla',      (select OrtId from Ort where PLZ='6060')),
('Inderbitzin',  'Reto',       (select OrtId from Ort where PLZ='6210')),
('Jacomet',      'Mario',      (select OrtId from Ort where PLZ='3600')),
('Lingg',        'Hans',       (select OrtId from Ort where PLZ='6020')),
('Meier',        'Roland',     (select OrtId from Ort where PLZ='6023')),
('Renggli',      'Jana',       (select OrtId from Ort where PLZ='6060')),
('Schiffmann',   'David',      (select OrtId from Ort where PLZ='6020')),
('Schurter',     'Armin',      (select OrtId from Ort where PLZ='6370')),
('Schnider',     'Benedikt',   (select OrtId from Ort where PLZ='3555')),
('St�ckli',      'Franziska',  null);

insert into Gruppe (Bez) values
('Werkzeug'),
('Lebensmittel'),
('M�bel'),
('Ger�te'),
('Kleider');

insert into Artikel (Bez, Preis, fk_GruppeId) values
('Multischleifer',    65.00,  (select GruppeId from Gruppe where Bez='Werkzeug')),
('Akku-Bohrer',      179.00,  (select GruppeId from Gruppe where Bez='Werkzeug')),
('Multis�ge',         49.00,  (select GruppeId from Gruppe where Bez='Werkzeug')),
('Akku-Hobel',        89.00,  (select GruppeId from Gruppe where Bez='Werkzeug')),
('Hammer',             5.00,  (select GruppeId from Gruppe where Bez='Werkzeug')),
('Raclette Ofen',     20.00,  (select GruppeId from Gruppe where Bez='Ger�te')),
('Outdoor Grill',    899.00,  (select GruppeId from Gruppe where Bez='Ger�te')),
('Relaxliege',       119.00,  (select GruppeId from Gruppe where Bez='M�bel')),
('Kommode',          245.00,  (select GruppeId from Gruppe where Bez='M�bel')),
('Tisch',            540.00,  (select GruppeId from Gruppe where Bez='M�bel')),
('Schrank',         1450.00,  (select GruppeId from Gruppe where Bez='M�bel')),
('Mineralwasser',      1.50,  (select GruppeId from Gruppe where Bez='Lebensmittel')),
('Lager Bier',         1.90,  (select GruppeId from Gruppe where Bez='Lebensmittel')),
('Brot',               3.20,  (select GruppeId from Gruppe where Bez='Lebensmittel')),
('Duschgel',           4.45,  null);

insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Lingg'),      (select ArtikelId from Artikel where Bez = 'Akku-Bohrer'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'B�hler'),     (select ArtikelId from Artikel where Bez = 'Outdoor Grill'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Renggli'),    (select ArtikelId from Artikel where Bez = 'Mineralwasser'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Schurter'),   (select ArtikelId from Artikel where Bez = 'Akku-Bohrer'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Lingg'),      (select ArtikelId from Artikel where Bez = 'Akku-Hobel'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'St�ckli'),    (select ArtikelId from Artikel where Bez = 'Kommode'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Jacomet'),    (select ArtikelId from Artikel where Bez = 'Hammer'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Jacomet'),    (select ArtikelId from Artikel where Bez = 'Multis�ge'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Heggli'),     (select ArtikelId from Artikel where Bez = 'Brot'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'St�ckli'),    (select ArtikelId from Artikel where Bez = 'Mineralwasser'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Heggli'),     (select ArtikelId from Artikel where Bez = 'Mineralwasser'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Schiffmann'), (select ArtikelId from Artikel where Bez = 'Mineralwasser'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'B�hler'),     (select ArtikelId from Artikel where Bez = 'Hammer'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Dobler'),     (select ArtikelId from Artikel where Bez = 'Relaxliege'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Heggli'),     (select ArtikelId from Artikel where Bez = 'Tisch'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Meier'),      (select ArtikelId from Artikel where Bez = 'Lager Bier'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Lingg'),      (select ArtikelId from Artikel where Bez = 'Lager Bier'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Schnider'),   (select ArtikelId from Artikel where Bez = 'Multis�ge'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'Schnider'),   (select ArtikelId from Artikel where Bez = 'Akku-Bohrer'));
insert into Kauft (fk_KundeId, fk_ArtikelId) values((select KundeId from Kunde where Nachname = 'B�hler'),     (select ArtikelId from Artikel where Bez = 'Relaxliege'));

--SELECT Kunde.Vorname, Kunde.Nachname, Ort.Bez FROM Kunde
--INNER JOIN Ort ON Kunde.fk_OrtId = Ort.OrtId
--ORDER BY Nachname, Vorname;

--SELECT Artikel.Bez, CONCAT(Kunde.Vorname, ' ' , Kunde.Nachname) AS Kunde FROM Kauft
--INNER JOIN Kunde ON Kauft.fk_KundeId = Kunde.KundeId
--INNER JOIN Artikel ON Kauft.fk_ArtikelId = Artikel.ArtikelId
--ORDER BY Artikel.Bez, Kunde.Nachname, Kunde.Vorname

--SELECT Kunde.Vorname, Kunde.Nachname, SUM(Artikel.Preis) AS Umsatz FROM Kauft
--INNER JOIN Artikel ON Kauft.fk_ArtikelId = Artikel.ArtikelId
--INNER JOIN Kunde ON Kauft.fk_KundeId = Kunde.KundeId
--WHERE Kunde.Vorname = 'Carla' AND Kunde.Nachname = 'Heggli'
--GROUP BY Kunde.Vorname, Kunde.Nachname

--SELECT Kunde.Vorname, Kunde.Nachname, COUNT(Artikel.ArtikelId) AS Anzahl FROM Kauft
--INNER JOIN Artikel ON Kauft.fk_ArtikelId = Artikel.ArtikelId
--INNER JOIN Kunde ON Kauft.fk_KundeId = Kunde.KundeId
--GROUP BY Kunde.Vorname, Kunde.Nachname
--ORDER BY Anzahl DESC, Kunde.Nachname, Kunde.Vorname

--SELECT Gruppe.Bez AS Artikelgruppe, COUNT(Artikel.ArtikelId) AS 'Anzahl Artikel' FROM Artikel
--INNER JOIN Gruppe ON Artikel.fk_GruppeId = Gruppe.GruppeId
--GROUP BY Gruppe.Bez
--ORDER BY Gruppe.Bez

--SELECT Gruppe.Bez AS 'Gruppen ohne Artikel' FROM Gruppe
--LEFT JOIN Artikel ON Gruppe.GruppeId = Artikel.fk_GruppeId
--WHERE Artikel.ArtikelId is NULL
--ORDER BY Gruppe.Bez

--SELECT Artikel.Bez, Artikel.Preis FROM Artikel
--LEFT JOIN Kauft ON Artikel.ArtikelId = Kauft.fk_ArtikelId
--WHERE Kauft.fk_ArtikelId is NULL
--ORDER BY Artikel.Preis DESC;

--SELECT Artikel.Bez AS Artikel, Artikel.Preis FROM Artikel
--LEFT JOIN Gruppe ON Artikel.fk_GruppeId = Gruppe.GruppeId
--WHERE Gruppe.GruppeId is NULL
--ORDER BY Artikel.Bez

--SELECT CONCAT(Kunde.Vorname, ' ', Kunde.Nachname) AS Kunde, Artikel.Bez, Artikel.Preis FROM Kauft
--INNER JOIN Artikel ON Kauft.fk_ArtikelId = Artikel.ArtikelId
--INNER JOIN Kunde ON Kauft.fk_KundeId = Kunde.KundeId
--WHERE Artikel.Bez = 'Mineralwasser'
--ORDER BY Kunde.Nachname, Kunde.Vorname

--SELECT CONCAT(Kunde.Vorname, ' ', Kunde.Nachname) AS Kunde, SUM(Artikel.Preis) AS Umsatz FROM Kauft
--INNER JOIN Kunde ON Kauft.fk_KundeId = Kunde.KundeId
--INNER JOIN Artikel ON Kauft.fk_ArtikelId = Artikel.ArtikelId
--GROUP BY Kunde.Vorname, Kunde.Nachname
--ORDER BY Umsatz DESC

--SELECT Kunde.Vorname, Kunde.Nachname FROM Kunde
--LEFT JOIN Kauft ON Kunde.KundeId = Kauft.fk_KundeId
--GROUP BY Kunde.Vorname, Kunde.Nachname
--HAVING SUM(Kauft.fk_ArtikelId) is NUll
--ORDER BY Kunde.Nachname, Kunde.Vorname

SELECT Ort.PLZ, Ort.Bez, Ort.Kanton, COUNT(Kunde.fk_OrtId) AS 'Anz. Kunden' FROM Ort
Left JOIN Kunde ON Ort.OrtId = Kunde.fk_OrtId
GROUP BY Ort.PLZ, Ort.Bez, Ort.Kanton
ORDER BY [Anz. Kunden] DESC















