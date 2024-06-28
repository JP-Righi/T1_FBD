-- Inserir países do seu banco de dados
INSERT INTO Paises (nome, noc)
SELECT DISTINCT nome, noc FROM olympic_korean_athletes.Times;

-- Inserir esportes do seu banco de dados
INSERT INTO Esportes (nome)
SELECT DISTINCT nome FROM olympic_korean_athletes.Esportes;

-- Inserir modalidades do seu banco de dados, relacionando com esportes
INSERT INTO Modalidades (nome, esporte_id)
SELECT DISTINCT m.nome, m.esporte_id
FROM olympic_korean_athletes.Modalidades m;

-- Inserir eventos do seu banco de dados
INSERT INTO Eventos (ano, estacao, cidade)
SELECT DISTINCT ano, estacao, cidade FROM olympic_korean_athletes.Olimpiadas;

-- Inserir atletas do seu banco de dados
INSERT INTO Atletas (id, nome, sexo, nascimento, pais_id)
SELECT DISTINCT a.id, a.nome, a.sexo, NULL, p.id
FROM olympic_korean_athletes.Atletas a
JOIN Paises p ON p.noc = 'KOR';

-- Inserir participações do seu banco de dados
INSERT INTO Participacao (atleta_id, evento_id, modalidade_id, pais_id, idade, altura, peso, medalha)
SELECT p.atleta_id, p.olimpiada_id, p.modalidade_id, p.time_id, p.idade, p.altura, p.peso, p.medalha
FROM olympic_korean_athletes.Participacao p
-- JOIN olympic_korean_athletes.Atletas a ON a.id = p.atleta_id
-- JOIN olympic_korean_athletes.Olimpiadas o ON o.id = p.olimpiada_id
-- JOIN Eventos e ON e.ano = o.ano AND e.estacao = o.estacao AND e.cidade = o.cidade
-- JOIN Modalidades m ON m.id = p.modalidade_id;
