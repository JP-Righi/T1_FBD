drop database if exists olimpiadasGrecia;
create database olimpiadasGrecia;
use olimpiadasGrecia;
create table PAIS (
ID_PAIS int,
pais varchar (50),
primary key (ID_PAIS));
create table MODALIDADE (
ID_MODA int,
modalidade varchar (50),
primary key (ID_MODA));
create table EVENTO (
ID_EVENTO int,
ano int,
sede varchar(50),
primary key (ID_EVENTO));
create table ATLETA (
ID_ATLETA int,
nome varchar(50),
sexo varchar(2),
nascimento int,
modalidade int not null,
pais int not null,
primary key (ID_ATLETA),
foreign key (modalidade) references Modalidade (ID_MODA),
foreign key (pais) references Pais (ID_PAIS));
create table PREMIACAO (
atleta int not null,
evento int not null,
medalha varchar(10),
foreign key (atleta) references Atleta (ID_ATLETA),
foreign key (evento) references Evento (ID_EVENTO));

insert into PAIS values (1, 'Greece');

-- modalidades 
insert into MODALIDADE values (1, 'Athletics Generic');
insert into MODALIDADE values (2, 'Artistic Gymnastics Generic');
insert into MODALIDADE values (3, 'Water Polo Men''s Water Polo');
insert into MODALIDADE values (4, 'Sailing Generic');
insert into MODALIDADE values (5, 'Football Men''s Football');
insert into MODALIDADE values (6, 'Basketball Women''s Basketball');
insert into MODALIDADE values (7, 'Basketball Men''s Basketball');
insert into MODALIDADE values (8, 'Baseball Men''s Baseball');
insert into MODALIDADE values (9, 'Handball Women''s Handball');
insert into MODALIDADE values (10, 'Artistic Swimming Generic');
insert into MODALIDADE values (11, 'Rhythmic Gymnastics Women''s Individual');
insert into MODALIDADE values (12, 'Fencing Generic');
insert into EVENTO values (1, 1896, 'Athens');
insert into EVENTO values (2, 1968, 'Mexico City');
insert into EVENTO values (3, 1972, 'Munich');
insert into EVENTO values (4, 1980, 'Moscow');
insert into EVENTO values (5, 1996, 'Atlanta');
insert into EVENTO values (6, 2000, 'Sydney');
insert into EVENTO values (7, 2004, 'Athens');
insert into EVENTO values (8, 2008, 'Beijing');
insert into EVENTO values (9, 2020, 'Tokyo');


insert into ATLETA values (1, 'Emmanouil Karalis', 'M', 1999, 1, 1);
insert into ATLETA values (2, 'Christos Frantzeskakis', 'M', 2000, 1, 1);
insert into ATLETA values (3, 'Maria Karastamati', 'F', 1984, 1, 1);
insert into ATLETA values (4, 'Constantina Margariti', 'F', 1980, 2, 1);
insert into ATLETA values (5, 'Simeon Georgaras', 'M', 1973, 3, 1);
insert into ATLETA values (6, 'Georgios Theodorakopoulos', 'M', 1944, 3, 1);
insert into ATLETA values (7, 'Andreas Papadopoulos', 'M', 1982, 4, 1);
insert into ATLETA values (8, 'Miltiadis Sapanis', 'M', 1776, 5, 1);
insert into ATLETA values (9, 'Dimitra Kalentzou', 'F', 1978, 6, 1);
insert into ATLETA values (10, 'Antonios Fotsis', 'M', 1981, 7, 1);
insert into ATLETA values (11, 'Nikolaos Zisis', 'M', 1983, 7, 1);
insert into ATLETA values (12, 'Georgios Kontogouris', 'M', 1980, 4, 1);
insert into ATLETA values (13, 'Georgios Printezis', 'M', 1985, 7, 1);
insert into ATLETA values (14, 'Laurence Heisler', 'M', 1969, 8, 1);
insert into ATLETA values (15, 'Erik Daniel Pappas', 'M', 1966, 8, 1);
insert into ATLETA values (16, 'Ioanna Fotiadou', 'F', 1977, 9, 1);
insert into ATLETA values (17, 'Apostolia Ioannou', 'F', 1979, 10, 1);
insert into ATLETA values (18, 'Georgia Lara', 'F', 1980, 3, 1);
insert into ATLETA values (19, 'Eftychia Karagianni', 'F', 1973, 3, 1);
insert into ATLETA values (20, 'Ioannis Thomakos', 'F', 1977, 3, 1);
insert into ATLETA values (21, 'Charikleia Pantazi', 'F', 1975, 11, 1);
insert into ATLETA values (22, 'Aristidis Rapanakis', 'M', 1954, 4, 1);
insert into ATLETA values (23, 'Ioannis Georgiadis', 'M', 1874, 12, 1);
insert into ATLETA values (24, 'Ioannis Mitropoulos', 'M', 1873, 12, 1);

-- premiacao
insert into PREMIACAO values (1, 9, null);
insert into PREMIACAO values (2, 9, null);
insert into PREMIACAO values (3, 7, null);
insert into PREMIACAO values (4, 5, null);
insert into PREMIACAO values (5, 5, null);
insert into PREMIACAO values (6, 2, null);
insert into PREMIACAO values (6, 3, null);
insert into PREMIACAO values (7, 8, null);
insert into PREMIACAO values (8, 7, null);
insert into PREMIACAO values (9, 7, null);
insert into PREMIACAO values (10, 7, null);
insert into PREMIACAO values (10, 8, null);
insert into PREMIACAO values (11, 7, null);
insert into PREMIACAO values (11, 8, null);
insert into PREMIACAO values (12, 7, null);
insert into PREMIACAO values (13, 8, null);
insert into PREMIACAO values (14, 7, null);
insert into PREMIACAO values (15, 7, null);
insert into PREMIACAO values (16, 7, null);
insert into PREMIACAO values (17, 7, null);
insert into PREMIACAO values (18, 7, 'Silver');
insert into PREMIACAO values (18, 8, null);
insert into PREMIACAO values (19, 7, 'Silver');
insert into PREMIACAO values (20, 6, null);
insert into PREMIACAO values (20, 7, null);
insert into PREMIACAO values (20, 8, null);
insert into PREMIACAO values (21, 6, 'Silver');
insert into PREMIACAO values (22, 4, 'Bronze');
insert into PREMIACAO values (23, 1, 'Gold');
insert into PREMIACAO values (24, 1, 'Gold');
