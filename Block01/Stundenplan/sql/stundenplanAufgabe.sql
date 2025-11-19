use master 
go
drop database if exists Stundenplan;
go
create database Stundenplan;
go
use Stundenplan;
go

drop table if exists KlHatFa;
drop table if exists LeIstInKl;
drop table if exists Raum;
drop table if exists Fach;
drop table if exists Klasse;
drop table if exists Lehrperson;
drop table if exists Lernender;

create table Lernender (
  LernenderId integer identity,
  Nachname varchar(50),
  Vorname varchar(50),
  primary key(LernenderId)
);

create table Lehrperson (
  LehrpersonId integer identity,
  Nachname varchar(50),
  Vorname varchar(50),
  primary key(LehrpersonId)
);

create table Klasse (
  KlasseId integer identity,
  Bez varchar(10),
  fk_LehrpersonId integer,
  primary key(KlasseId),
  foreign key(fk_LehrpersonId) references Lehrperson(LehrpersonId)
);

create table Fach (
  FachId integer identity,
  KurzBez varchar(5),
  LangBez varchar(20),
  primary key(FachId)
);

create table Raum (
  RaumId integer identity,
  Bez varchar(10),
  primary key(RaumId)
);

create table LeIstInKl (
  LeIstInKlId integer identity,
  fk_LernenderId integer,
  fk_KlasseId integer,
  primary key(LeIstInKlId),
  foreign key(fk_LernenderId) references Lernender(LernenderId),
  foreign key(fk_KlasseId) references Klasse(KlasseId)
);

create table KlHatFa (
  KlHatFaId integer identity,
  fk_FachId integer,
  fk_KlasseId integer,
  fk_LehrpersonId integer,
  fk_RaumId integer,
  primary key(KlHatFaId),
  foreign key(fk_FachId) references Fach(FachId),
  foreign key(fk_KlasseId) references Klasse(KlasseId),
  foreign key(fk_LehrpersonId) references Lehrperson(LehrpersonId),
  foreign key(fk_RaumId) references Raum(RaumId)
);

insert into Raum (Bez) values
  ('E01'),
  ('E02'),
  ('E03'),
  ('101'),
  ('102'),
  ('201'),
  ('202'),
  ('203'),
  ('204'),
  ('205');

insert into Fach (KurzBez, LangBez) values
  ('MAT', 'Mathematik'),
  ('INF', 'Informatik'),
  ('ENG', 'Englisch'),
  ('ABU', 'Allgemeinbildung'),
  ('SPO', 'Sport'),
  ('BKU', 'Berufskunde'),
  ('DEU', 'Deutsch');

insert into Lernender (Vorname, Nachname) values
  ('Esther', 'Hodel'),
  ('Selina', 'Muri'),
  ('Florian', 'Koch'),
  ('Tamara', 'Zihlmann'),
  ('Sabrina', 'Isenschmid'),
  ('Vreni', 'Walker'),
  ('Remo', 'Jenni'),
  ('Ueli', 'Merz'),
  ('Melanie', 'Keller'),
  ('David', 'Gisler'),
  ('Anja', 'Graf'),
  ('Simone', 'Studer'),
  ('Ivan', 'Kurmann'),
  ('Lisa', 'Marti'),
  ('Ivo', 'Felder'),
  ('Michael', 'Herger'),
  ('Lino', 'Bieri'),
  ('Tanja', 'Lang'),
  ('Chantal', 'Tanner'),
  ('Lena', 'Heer'),
  ('Andrea', 'Baumann'),
  ('Claudia', 'Scherrer'),
  ('Silvia', 'Kunz'),
  ('Sandra', 'Suter'),
  ('Denise', 'Beck'),
  ('Lara', 'Wagner'),
  ('Adrian', 'Spörri'),
  ('Oliver', 'Furrer'),
  ('Samuel', 'Gasser'),
  ('Pascal', 'Sager'),
  ('Mario', 'Rossi'),
  ('Julia', 'Becker'),
  ('Doris', 'Heim'),
  ('Jessica', 'Maurer'),
  ('Kevin', 'Schenker'),
  ('Fabian', 'Zeller'),
  ('Marco', 'Kälin');


insert into Lehrperson (Vorname, Nachname) values
  ('Monika', 'Rohrer'),
  ('Bruno', 'Suter'),
  ('Nicole', 'Birrer'),
  ('Max', 'Wolf'),
  ('Fabio', 'Schaub'),
  ('Maria', 'Widmer'),
  ('Rita', 'Peyer'),
  ('Urs', 'Haas'),
  ('Robert', 'Frick');

insert into Klasse (Bez, fk_LehrpersonId) values
  ('INF1a', 4),
  ('INF1b', 1),
  ('INF2a', 3),
  ('INF2b', 2),
  ('MMA1a', 6),
  ('MMA2a', 2);

insert into LeIstInKl (fk_LernenderId, fk_KlasseId) values
  (01, 1),
  (07, 1),
  (13, 1),
  (20, 1),
  (26, 1),
  (32, 1);

insert into LeIstInKl (fk_LernenderId, fk_KlasseId) values
  (02, 2),
  (08, 2),
  (14, 2),
  (21, 2),
  (27, 2),
  (33, 2);

insert into LeIstInKl (fk_LernenderId, fk_KlasseId) values
  (03, 3),
  (09, 3),
  (15, 3),
  (22, 3),
  (28, 3),
  (34, 3);

insert into LeIstInKl (fk_LernenderId, fk_KlasseId) values
  (04, 4),
  (10, 4),
  (16, 4),
  (23, 4),
  (29, 4),
  (35, 4);

insert into LeIstInKl (fk_LernenderId, fk_KlasseId) values
  (05, 5),
  (11, 5),
  (17, 5),
  (24, 5),
  (30, 5),
  (36, 5);

insert into KlHatFa (fk_KlasseId, fk_FachId, fk_LehrpersonId, fk_RaumId) values
  (1, 2, 1, 1),
  (1, 4, 6, 4),
  (1, 5, 3, 5),
  (2, 2, 2, 1),
  (2, 3, 3, 2),
  (3, 2, 1, 3),
  (3, 4, 6, 4),
  (3, 5, 4, 5),
  (4, 1, 1, 2),
  (4, 2, 2, 2),
  (5, 2, 2, 6),
  (5, 6, 4, 7),
  (6, 6, 3, 9),
  (6, 5, 2, 1);

  --SELECT Klasse.Bez, Lernender.Vorname, Lernender.Nachname FROM LeIstInKl
  --INNER JOIN Lernender ON LeIstInKl.fk_LernenderId = Lernender.LernenderId
  --INNER JOIN Klasse ON LeIstInKl.fk_KlasseId = Klasse.KlasseId
  --ORDER BY Klasse.Bez, Lernender.Nachname,Lernender.Vorname;

--SELECT Klasse.Bez AS Bez, CONCAT( Lehrperson.Vorname, ' ', Lehrperson.Nachname) AS KLP FROM Klasse
--INNER JOIN Lehrperson ON Klasse.fk_LehrpersonId = Lehrperson.LehrpersonId
--ORDER BY Klasse.Bez;

--SELECT  Klasse.Bez AS Bez, COUNT(Klasse.KlasseId) AS Anzahl FROM LeIstInKl
--INNER JOIN Klasse ON LeIstInKl.fk_KlasseId = Klasse.KlasseId
--INNER JOIN Lernender ON LeIstInKl.fk_LernenderId = Lernender.LernenderId
--GROUP BY Klasse.Bez
--ORDER BY Klasse.Bez;

--SELECT Lehrperson.Vorname AS Vorname, Lehrperson.Nachname AS Nachname, COUNT(Fach.FachId) AS Anzahl FROM KlHatFa
--INNER JOIN Lehrperson ON KlHatFa.fk_LehrpersonId = Lehrperson.LehrpersonId
--INNER JOIN Fach ON KlHatFa.fk_FachId = Fach.FachId
--GROUP BY Lehrperson.LehrpersonId, Lehrperson.Vorname, Lehrperson.Nachname
--ORDER BY Anzahl DESC;

--SELECT Klasse.Bez, Fach.KurzBez AS KurzBez, Fach.LangBez FROM KlHatFa
--INNER JOIN Fach ON KlHatFa.fk_FachId = Fach.FachId
--INNER JOIN Klasse ON KlHatFa.fk_KlasseId = Klasse.KlasseId
--WHERE Klasse.Bez LIKE 'INF2%'
--GROUP BY Klasse.Bez, Fach.KurzBez, Fach.LangBez
--ORDER BY Klasse.Bez, Fach.KurzBez

--SELECT Klasse.Bez, Fach.KurzBez, Fach.LangBez AS Fach, CONCAT(Lehrperson.Vorname, ' ', Lehrperson.Nachname), Raum.Bez FROM KlHatFa 
--INNER JOIN Klasse ON KlHatFa.fk_KlasseId = Klasse.KlasseId
--INNER JOIN Fach ON KlHatFa.fk_FachId = Fach.FachId
--INNER JOIN Lehrperson ON KlHatFa.fk_LehrpersonId = Lehrperson.LehrpersonId
--INNER JOIN Raum ON KlHatFa.fk_RaumId = Raum.RaumId
--WHERE Klasse.Bez = 'MMA1a'
--ORDER BY Fach.KurzBez

--SELECT Lehrperson.Vorname, Lehrperson.Nachname FROM Lehrperson
--LEFT JOIN Klasse ON Lehrperson.LehrpersonId = Klasse.fk_LehrpersonId
--WHERE Klasse.fk_LehrpersonId is NULL
--ORDER BY Lehrperson.Nachname, Lehrperson.Vorname

--SELECT Klasse.Bez, Lehrperson.Vorname, Lehrperson.Nachname FROM KlHatFa
----INNER JOIN Lehrperson ON KlHatFa.fk_LehrpersonId = Lehrperson.LehrpersonId
--INNER JOIN Fach ON KlHatFa.fk_FachId = Fach.FachId
--INNER JOIN Klasse ON KlHatFa.fk_KlasseId = Klasse.KlasseId
--INNER JOIN Lehrperson ON Klasse.fk_LehrpersonId = Lehrperson.LehrpersonId
--GROUP BY Klasse.Bez, Lehrperson.Vorname, Lehrperson.Nachname

SELECT Klasse.Bez, Lehrperson.Vorname, Lehrperson.Nachname FROM Lehrperson
INNER JOIN Klasse ON Lehrperson.LehrpersonId = Klasse.fk_LehrpersonId
LEFT JOIN KlHatFa ON Lehrperson.LehrpersonId = KlHatFa.fk_LehrpersonId AND Klasse.KlasseId = KlHatFa.fk_KlasseId
WHERE KlHatFa.KlHatFaId IS NULL
ORDER BY Klasse.Bez










