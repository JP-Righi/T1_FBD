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
insert into PAIS values (1, 'Grécia');
insert into MODALIDADE values (1, 'Atletismo');
insert into MODALIDADE values (2, 'Ginástica Artística');
insert into MODALIDADE values (3, 'Polo Aquático');
insert into MODALIDADE values (4, 'Navegação');
insert into MODALIDADE values (5, 'Futebol');
insert into MODALIDADE values (6, 'Basquete Feminino');
insert into MODALIDADE values (7, 'Basquete Masculino');
insert into MODALIDADE values (8, 'Beisebol');
insert into MODALIDADE values (9, 'Handebol');
insert into MODALIDADE values (10, 'Natação Artística');
insert into MODALIDADE values (11, 'Ginástica Rítmica');
insert into MODALIDADE values (12, 'Esgrima');
insert into EVENTO values (1, 1896, 'Atenas');
insert into EVENTO values (2,1968, 'Cidade do México');
insert into EVENTO values (3,1972, 'Munique');
insert into EVENTO values (4, 1980, 'Moscou');
insert into EVENTO values (5, 1996, 'Atlanta');
insert into EVENTO values (6, 2000, 'Sydney');
insert into EVENTO values (7, 2004, 'Atenas');
insert into EVENTO values (8, 2008,'Beijing');
insert into EVENTO values (9, 2020, 'Tóquio');
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
insert into PREMIACAO values (1, 9, 'n/a');
insert into PREMIACAO values (2, 9, 'n/a');
insert into PREMIACAO values (3, 7, 'n/a');
insert into PREMIACAO values (4, 5, 'n/a');
insert into PREMIACAO values (5, 5, 'n/a');
insert into PREMIACAO values (6, 2, 'n/a');
insert into PREMIACAO values (6, 3, 'n/a');
insert into PREMIACAO values (7, 8, 'n/a');
insert into PREMIACAO values (8, 7, 'n/a');
insert into PREMIACAO values (9, 7, 'n/a');
insert into PREMIACAO values (10, 7, 'n/a');
insert into PREMIACAO values (10, 8, 'n/a');
insert into PREMIACAO values (11, 7, 'n/a');
insert into PREMIACAO values (11, 8, 'n/a');
insert into PREMIACAO values (12, 7, 'n/a');
insert into PREMIACAO values (13, 8, 'n/a');
insert into PREMIACAO values (14, 7, 'n/a');
insert into PREMIACAO values (15, 7, 'n/a');
insert into PREMIACAO values (16, 7, 'n/a');
insert into PREMIACAO values (17, 7, 'n/a');
insert into PREMIACAO values (18, 7, 'Prata');
insert into PREMIACAO values (18, 8, 'n/a');
insert into PREMIACAO values (19, 7, 'Prata');
insert into PREMIACAO values (20, 6, 'n/a');
insert into PREMIACAO values (20, 7, 'n/a');
insert into PREMIACAO values (20, 8, 'n/a');
insert into PREMIACAO values (21, 6, 'Prata');
insert into PREMIACAO values (22, 4, 'Bronze');
insert into PREMIACAO values (23, 1, 'Ouro');
insert into PREMIACAO values (24, 1, 'Ouro');