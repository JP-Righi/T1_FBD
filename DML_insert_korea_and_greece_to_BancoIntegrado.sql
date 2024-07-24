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


INSERT INTO Paises (nome, noc) VALUES ('Greece', 'GRE');


-- Insere novos eventos da Grécia, garantindo que não haja duplicatas
INSERT INTO Eventos (ano, estacao, cidade)
SELECT DISTINCT ano, 'Summer', sede 
FROM olimpiadasGrecia.EVENTO g
WHERE NOT EXISTS (
    SELECT 1 
    FROM Eventos e 
    WHERE e.ano = g.ano AND e.estacao = 'Summer' AND e.cidade = g.sede
);




-- Adicionar modalidades do banco da Grécia ao banco integrado

-- Fencing Generic
INSERT INTO Modalidades (nome, esporte_id)
SELECT 'Fencing Generic', e.id
FROM Esportes e
WHERE e.nome = 'Fencing'
AND NOT EXISTS (
    SELECT 1 FROM Modalidades m WHERE m.nome = 'Fencing Generic'
);

-- Artistic Swimming Generic
INSERT INTO Modalidades (nome, esporte_id)
SELECT 'Artistic Swimming Generic', e.id
FROM Esportes e
WHERE e.nome = 'Swimming'
AND NOT EXISTS (
    SELECT 1 FROM Modalidades m WHERE m.nome = 'Artistic Swimming Generic'
);

-- Athletics Generic
INSERT INTO Modalidades (nome, esporte_id)
SELECT 'Athletics Generic', e.id
FROM Esportes e
WHERE e.nome = 'Athletics'
AND NOT EXISTS (
    SELECT 1 FROM Modalidades m WHERE m.nome = 'Athletics Generic'
);

-- Artistic Gymnastics Generic
INSERT INTO Modalidades (nome, esporte_id)
SELECT 'Artistic Gymnastics Generic', e.id
FROM Esportes e
WHERE e.nome = 'Gymnastics'
AND NOT EXISTS (
    SELECT 1 FROM Modalidades m WHERE m.nome = 'Artistic Gymnastics Generic'
);

-- Sailing Generic
INSERT INTO Modalidades (nome, esporte_id)
SELECT 'Sailing Generic', e.id
FROM Esportes e
WHERE e.nome = 'Sailing'
AND NOT EXISTS (
    SELECT 1 FROM Modalidades m WHERE m.nome = 'Sailing Generic'
);
	


-- Para inserir os atletas da Grécia corretamente
INSERT INTO Atletas (nome, sexo, nascimento, pais_id)
SELECT g.nome, g.sexo, g.nascimento, pi.id
FROM olimpiadasGrecia.ATLETA g
JOIN Paises pi ON pi.nome = 'Greece';



-- Inserindo participações da Grécia, relacionando atletas corretamente com as modalidades em que participam
INSERT INTO Participacao (atleta_id, evento_id, modalidade_id, pais_id, idade, altura, peso, medalha)
SELECT a.id, e.id, m.id, a.pais_id, NULL, NULL, NULL, pr.medalha
FROM olimpiadasGrecia.PREMIACAO pr
JOIN Atletas a ON a.nome = (SELECT nome FROM olimpiadasGrecia.ATLETA ag WHERE ag.ID_ATLETA = pr.atleta)
JOIN Eventos e ON e.ano = (SELECT ano FROM olimpiadasGrecia.EVENTO eg WHERE eg.ID_EVENTO = pr.evento)
    AND e.cidade = (SELECT sede FROM olimpiadasGrecia.EVENTO eg WHERE eg.ID_EVENTO = pr.evento)
JOIN olimpiadasGrecia.MODALIDADE mg ON mg.ID_MODA = (SELECT modalidade FROM olimpiadasGrecia.ATLETA ag WHERE ag.ID_ATLETA = pr.atleta)
JOIN Modalidades m ON m.nome = mg.modalidade;

UPDATE Participacao p
JOIN Atletas a ON p.atleta_id = a.id
JOIN Eventos e ON p.evento_id = e.id
SET p.idade = (e.ano - a.nascimento)
WHERE a.pais_id IN( SELECT pa.id 
					FROM paises pa 
					WHERE pa.noc = "GRE"
); 

use olimpiadasintegrado;
UPDATE olimpiadasintegrado.atletas a
JOIN (
    SELECT p.atleta_id, e.ano - p.idade AS ano_nascimento
    FROM Participacao p
    JOIN Eventos e ON p.evento_id = e.id
    WHERE p.idade IS NOT NULL
) sub ON a.id = sub.atleta_id
SET a.nascimento = sub.ano_nascimento; 


