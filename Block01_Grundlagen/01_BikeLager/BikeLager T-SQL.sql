--*********************************************************
-- Bikelager
--*********************************************************

-----------------------------------------------------------
-- Datenbank erstellen
-----------------------------------------------------------
use master
go
drop database if exists BikeLager;
go
create database BikeLager;
go
use BikeLager;
go

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
