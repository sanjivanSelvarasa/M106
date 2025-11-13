use master
go
drop database if exists BikeLager;
go
create database BikeLager;
go
use BikeLager;
go

drop table if exists Bike;
drop table if exists Typ;
drop table if exists Marke;

-----------------------------------------------------------
-- Tabllen erstellen
-----------------------------------------------------------
create table Typ(
  TypId integer identity,
  Bez varchar(20),
  primary key (TypId)
);

create table Marke (
  MarkeId integer identity,
  Bez varchar(20),
  primary key (MarkeId)
);

create table Bike (
  BikeId integer identity,
  Bez varchar(20),
  Preis decimal(9, 2),
  fk_TypId integer,
  fk_MarkeId integer,
  primary key (BikeId),
  foreign key (fk_TypId) references Typ (TypId),
  foreign key (fk_MarkeId) references Marke (MarkeId)
);
go

-----------------------------------------------------------
-- Inhalte einfügen
-----------------------------------------------------------
insert into Typ (Bez) values
  ('Citybike'),
  ('E-Bike'),
  ('Kinderbike'),
  ('Mountainbike'),
  ('Rennvelo');

insert into Marke (Bez) values
  ('Scott'),
  ('Trek'),
  ('Flyer'),
  ('Wheeler'),
  ('Cube');

insert into Bike (Bez, Preis) values
  ('Travel SL', 1399),     /* Cube, Citybike */
  ('Upstreet 5', 3899),    /* Flyer, E-Bike */
  ('Uproc 3', 4599),       /* Flyer, E-Bike */
  ('C 5.1', 3199),         /* Flyer, E-Bike */
  ('Powerfly FS 7', 5399), /* Trek, E-Bike */
  ('Fuel EX 9.8', 3999),   /* Trek, Mountainbike */
  ('Scale 24', 499),       /* Scott, Kinderbike */
  ('Scale 950', 1199),     /* Scott, Mountainbike */
  ('XT EQT 24', 499),      /* Wheeler, Citybike */
  ('Protron XT-10', 999);  /* Wheeler, Mountainbike */
go

-----------------------------------------------------------
-- Typ und Marke pro Bike setzen
-----------------------------------------------------------
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Citybike'),      fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Cube'   )  where Bike.Bez = 'Travel SL';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'E-Bike'),        fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Flyer'  )  where Bike.Bez = 'Upstreet 5';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'E-Bike'),        fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Flyer'  )  where Bike.Bez = 'Uproc 3';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'E-Bike'),        fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Flyer'  )  where Bike.Bez = 'C 5.1';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'E-Bike'),        fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Trek'   )  where Bike.Bez = 'Powerfly FS 7';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Mountainbike'),  fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Trek'   )  where Bike.Bez = 'Fuel EX 9.8';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Kinderbike'),    fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Scott'  )  where Bike.Bez = 'Scale 24';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Mountainbike'),  fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Scott'  )  where Bike.Bez = 'Scale 950';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Citybike'),      fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Wheeler')  where Bike.Bez = 'XT EQT 24';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Mountainbike'),  fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Wheeler')  where Bike.Bez = 'Protron XT-10';

SELECT * FROM Bike 
WHERE Bike.fk_MarkeId = 3;
use BikeLager;
go

drop table Bike;
drop table Typ;
drop table Marke;

-----------------------------------------------------------
-- Tabllen erstellen
-----------------------------------------------------------
create table Typ(
  TypId integer identity,
  Bez varchar(20),
  primary key (TypId)
);

create table Marke (
  MarkeId integer identity,
  Bez varchar(20),
  primary key (MarkeId)
);

create table Bike (
  BikeId integer identity,
  Bez varchar(20),
  Preis decimal(9, 2),
  fk_TypId integer,
  fk_MarkeId integer,
  primary key (BikeId),
  foreign key (fk_TypId) references Typ (TypId),
  foreign key (fk_MarkeId) references Marke (MarkeId)
);
go

-----------------------------------------------------------
-- Inhalte einfügen
-----------------------------------------------------------
insert into Typ (Bez) values
  ('Citybike'),
  ('E-Bike'),
  ('Kinderbike'),
  ('Mountainbike'),
  ('Rennvelo');

insert into Marke (Bez) values
  ('Scott'),
  ('Trek'),
  ('Flyer'),
  ('Wheeler'),
  ('Cube');

insert into Bike (Bez, Preis) values
  ('Travel SL', 1399),     /* Cube, Citybike */
  ('Upstreet 5', 3899),    /* Flyer, E-Bike */
  ('Uproc 3', 4599),       /* Flyer, E-Bike */
  ('C 5.1', 3199),         /* Flyer, E-Bike */
  ('Powerfly FS 7', 5399), /* Trek, E-Bike */
  ('Fuel EX 9.8', 3999),   /* Trek, Mountainbike */
  ('Scale 24', 499),       /* Scott, Kinderbike */
  ('Scale 950', 1199),     /* Scott, Mountainbike */
  ('XT EQT 24', 499),      /* Wheeler, Citybike */
  ('Protron XT-10', 999);  /* Wheeler, Mountainbike */
go

-----------------------------------------------------------
-- Typ und Marke pro Bike setzen
-----------------------------------------------------------
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Citybike'),      fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Cube'   )  where Bike.Bez = 'Travel SL';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'E-Bike'),        fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Flyer'  )  where Bike.Bez = 'Upstreet 5';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'E-Bike'),        fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Flyer'  )  where Bike.Bez = 'Uproc 3';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'E-Bike'),        fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Flyer'  )  where Bike.Bez = 'C 5.1';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'E-Bike'),        fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Trek'   )  where Bike.Bez = 'Powerfly FS 7';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Mountainbike'),  fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Trek'   )  where Bike.Bez = 'Fuel EX 9.8';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Kinderbike'),    fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Scott'  )  where Bike.Bez = 'Scale 24';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Mountainbike'),  fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Scott'  )  where Bike.Bez = 'Scale 950';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Citybike'),      fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Wheeler')  where Bike.Bez = 'XT EQT 24';
update Bike set fk_TypId = (select TypId from Typ where Typ.Bez = 'Mountainbike'),  fk_MarkeId = (select MarkeId from Marke where Marke.Bez = 'Wheeler')  where Bike.Bez = 'Protron XT-10';


--SELECT * FROM Marke;

--SELECT * FROM Bike;

--SELECT * FROM Typ;

--SELECT * FROM Bike 
--WHERE Bike.fk_MarkeId = 3;

--SELECT * FROM Bike 
--WHERE Bike.fk_TypId = 4 AND Bike.fk_MarkeId = 1;

--	 SELECT Marke.Bez, Bike.Bez AS Bike, Bike.Preis FROM Bike 
--INNER JOIN Marke on Bike.fk_MarkeId = Marke.MarkeId

--SELECT Marke.Bez, Bike.Bez AS Bike, Typ.Bez, Bike.Preis FROM Bike 
--INNER JOIN Marke on Bike.fk_MarkeId = Marke.MarkeId
--INNER JOIN Typ ON Bike.fk_TypId = Typ.TypId
--ORDER By Marke.Bez, Typ.Bez, Bike.Bez;

--SELECT Marke.Bez, Bike.Bez AS Bike, Typ.Bez, Bike.Preis FROM Bike 
--INNER JOIN Marke on Bike.fk_MarkeId = Marke.MarkeId
--INNER JOIN Typ ON Bike.fk_TypId = Typ.TypId
--WHERE Marke.Bez = 'Wheeler'
--ORDER By Bike.Preis;

--SELECT AVG(Bike.Preis) AS Durchschnittspreis FROM Bike
--INNER JOIN Typ ON Bike.fk_TypId = Typ.TypId
--WHERE Typ.Bez = 'E-Bike';


--SELECT * FROM Bike 
--WHERE Bike.fk_MarkeId = 3;

--SELECT Marke.Bez, COUNT(*) AS Anzahl FROM Bike
--INNER JOIN Marke ON Bike.fk_MarkeId = Marke.MarkeId
--GROUP BY Marke.Bez
--ORDER BY Anzahl;

--SELECT Typ.Bez FROM Typ
--LEFT JOIN Bike ON Typ.TypId = Bike.fk_TypId
--WHERE Bike.fk_TypId is NULL;

--SELECT Typ.Bez AS Bez, COUNT(*) AS Anzahl FROM Bike
--INNER JOIN Typ ON Bike.fk_TypId = Typ.TypId
--GROUP BY Typ.Bez
--ORDER BY Anzahl;

--SELECT Marke.Bez, AVG(Bike.Preis) AS Preis FROM Bike
--INNER JOIN Marke ON Bike.fk_MarkeId = Marke.MarkeId
--INNER JOIN Typ ON Bike.fk_TypId = Typ.TypId
--WHERE Typ.Bez = 'Mountainbike'
--GROUP BY Marke.Bez
--ORDER BY Preis ASC;

--SELECT Marke.Bez, MIN(Bike.Preis) AS Minimum, MAX(Bike.Preis) AS Maximum, SUM(Bike.Preis) AS Gesamt FROM Bike
--INNER JOIN Marke ON Bike.fk_MarkeId = Marke.MarkeId
--GROUP BY Marke.Bez

--SELECT Marke.Bez, COUNT(*) AS Anzahl FROM Bike
--INNER JOIN Marke ON Bike.fk_MarkeId = Marke.MarkeId
--INNER JOIN Typ ON Bike.fk_TypId = Typ.TypId
--WHERE Typ.Bez = 'E-Bike'
--GROUP BY Marke.Bez
--ORDER BY Anzahl ASC

--SELECT Marke.Bez, Bike.Preis, ROUND(Bike.Preis / 100 * 92,85, 2) AS VPExlusive, ROUND(Bike.Preis / 100 * 7.15, 2) AS MWST FROM Bike
--INNER JOIN Marke ON Bike.fk_MarkeId = Marke.MarkeId
--ORDER BY Bike.Preis ASC

--SELECT ROUND(SUM(Bike.Preis) / 100 * 15, 2) AS Gewinn FROM Bike

--SELECT Marke.Bez, Bike.Bez, Typ.Bez, Bike.Preis AS 'NORMAL-VP', Bike.Preis - 200 AS 'AKTION-VP' FROM Bike
--INNER JOIN Marke ON Bike.fk_MarkeId = Marke.MarkeId
--INNER JOIN Typ ON Bike.fk_TypId = Typ.TypId
--WHERE Bike.Preis > 1000 AND Typ.Bez != 'E-Bike'
--GROUP BY Bike.Bez, Marke.Bez, Typ.Bez, Bike.Preis
--ORDER BY Marke.Bez, Bike.Bez;




