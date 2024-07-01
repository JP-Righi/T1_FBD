INSERT INTO Paises (nome, noc) VALUES ('Greece', 'GRE');


-- Encontra o valor máximo do ID de evento atual
SELECT MAX(id) INTO @max_event_id FROM Eventos;

-- Ajusta o próximo valor de auto-incremento para a tabela de eventos
SET @next_event_id = @max_event_id + 1;
SET @sql = CONCAT('ALTER TABLE Eventos AUTO_INCREMENT = ', @next_event_id);


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
	


-- Para inserir os atletas da Grécia, relacionando com a modalidade e esporte corretos
INSERT INTO Atletas (nome, sexo, nascimento, pais_id)
SELECT g.nome, g.sexo, g.nascimento, pi.id
FROM olimpiadasGrecia.ATLETA g
JOIN Paises pi ON pi.nome = 'Greece';



-- Inserindo participações da Grécia
INSERT INTO Participacao (atleta_id, evento_id, modalidade_id, pais_id, idade, altura, peso, medalha)
SELECT a.id, e.id, m.id, a.pais_id, NULL, NULL, NULL, pr.medalha
FROM olimpiadasGrecia.PREMIACAO pr
JOIN Atletas a ON a.nome = (SELECT nome FROM olimpiadasGrecia.ATLETA ag WHERE ag.ID_ATLETA = pr.atleta)
JOIN Eventos e ON e.ano = (SELECT ano FROM olimpiadasGrecia.EVENTO eg WHERE eg.ID_EVENTO = pr.evento)
    AND e.cidade = (SELECT sede FROM olimpiadasGrecia.EVENTO eg WHERE eg.ID_EVENTO = pr.evento)
JOIN olimpiadasGrecia.MODALIDADE mg ON mg.ID_MODA = (SELECT modalidade FROM olimpiadasGrecia.ATLETA ag WHERE ag.ID_ATLETA = pr.atleta)
JOIN Modalidades m ON m.nome = mg.modalidade





-- JOIN Modalidades m ON m.nome = (SELECT modalidade FROM olimpiadasGrecia.MODALIDADE mg WHERE mg.ID_MODA = (SELECT modalidade from olimpiadasGrecia.ATLETA ag where a.nome = ag.nome));

-- JOIN Modalidades m ON m.nome = (SELECT ag.modalidade FROM olimpiadasGrecia.ATLETA ag)

-- olimpiadasGrecia.MODALIDADE mg WHERE mg.ID_MODA = (SELECT modalidade FROM olimpiadasGrecia.ATLETA aag WHERE aag.ID_ATLETA = pr.atleta));


