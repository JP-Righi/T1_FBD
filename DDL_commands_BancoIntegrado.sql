CREATE DATABASE olimpiadasIntegrado;
USE olimpiadasIntegrado;

CREATE TABLE Paises (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) UNIQUE,
    noc VARCHAR(10)
);

CREATE TABLE Esportes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) UNIQUE
);

CREATE TABLE Modalidades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) UNIQUE,
    esporte_id INT,
    FOREIGN KEY (esporte_id) REFERENCES Esportes(id)
);

CREATE TABLE Eventos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ano INT,
    estacao VARCHAR(10),
    cidade VARCHAR(50)
);

CREATE TABLE Atletas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    sexo VARCHAR(10),
    nascimento INT,
    pais_id INT,
    FOREIGN KEY (pais_id) REFERENCES Paises(id)
);

CREATE TABLE Participacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    atleta_id INT,
    evento_id INT,
    modalidade_id INT,
    pais_id INT,
    idade INT,
    altura FLOAT,
    peso FLOAT,
    medalha VARCHAR(255),
    FOREIGN KEY (atleta_id) REFERENCES Atletas(id),
    FOREIGN KEY (evento_id) REFERENCES Eventos(id),
    FOREIGN KEY (modalidade_id) REFERENCES Modalidades(id),
    FOREIGN KEY (pais_id) REFERENCES Paises(id)
);
