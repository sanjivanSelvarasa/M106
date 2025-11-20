--********************************************************************
-- Computershop: Skript zum Erstellen der Datenbank mit allen Tabellen
--********************************************************************

----------------------------------------------------------------------
-- Datenbank erstellen
----------------------------------------------------------------------
use master
go
drop database if exists ComputerShop
go
create database ComputerShop
go
use ComputerShop
go

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
