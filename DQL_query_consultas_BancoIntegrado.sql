-- 1) Obter a média de altura e peso dos atletas que participaram  em eventos de cada esporte, agrupado por esporte:
SELECT es.nome AS esporte, ROUND(AVG(p.altura),2) AS media_altura, ROUND(AVG(p.peso),2) AS media_peso
FROM Participacao p
JOIN Modalidades m ON p.modalidade_id = m.id
JOIN Esportes es ON m.esporte_id = es.id
GROUP BY es.nome; 

-- 2) Listar TOP 3 eventos com mais medalhas de ouro, mostrando a quantidade das outras premiações 
SELECT e.ano, e.cidade, SUM(CASE WHEN p.medalha = 'Gold' THEN 1 ELSE 0 END) AS ouro_count,
						SUM(CASE WHEN p.medalha = 'Silver' THEN 1 ELSE 0 END) AS prata_count,
						SUM(CASE WHEN p.medalha = 'Bronze' THEN 1 ELSE 0 END) AS bronze_count
FROM Eventos e 
LEFT JOIN Participacao p ON e.id = p.evento_id
GROUP BY e.ano, e.cidade
ORDER BY ouro_count DESC, prata_count DESC, bronze_count DESC
LIMIT 3; -- SELECIONA TOP 3

-- 3) Listar participantes, ano, cidade e país de atletas que ganharam mais de uma medalha no mesmo evento
SELECT 
    a.nome AS Atleta,
    p.nome AS Pais,
    e.ano AS Ano,
    e.cidade AS Cidade,
    COUNT(pr.medalha) AS NumeroDeMedalhas
FROM Participacao pr
JOIN Atletas a ON pr.atleta_id = a.id
JOIN Paises p ON a.pais_id = p.id
JOIN Eventos e ON pr.evento_id = e.id
GROUP BY a.nome, p.nome, e.ano, e.cidade
HAVING NumeroDeMedalhas > 1
ORDER BY NumeroDeMedalhas DESC, a.nome, e.ano, e.cidade;


-- 4) Listar os 100 atletas mais jovens a ganharem medalhas de ouro. 
-- Mostre também ano de nascimento, idade no evento, noc, e modalidade.
SELECT a.nome AS atleta, a.nascimento, p.idade, pa.noc,  m.nome AS modalidade
FROM Atletas a
JOIN Participacao p ON a.id = p.atleta_id
JOIN Modalidades m ON p.modalidade_id = m.id
JOIN Paises pa ON pa.id = a.pais_id
WHERE p.medalha = 'Gold'
ORDER BY p.idade ASC
LIMIT 100;

-- 5) Listar as modalidades em que o atleta com mais medalhas de
-- ouro participou, incluindo o total de medalhas de ouro ganhas:
WITH AtletaMaisMedalhas AS (
	SELECT a.id AS atleta_id, COUNT(p.medalha) AS total_ouro
	FROM Participacao p
	JOIN Atletas a ON p.atleta_id = a.id
	WHERE p.medalha = 'Gold'
	GROUP BY a.id
	ORDER BY total_ouro DESC
	LIMIT 1
)
SELECT m.nome AS modalidade, COUNT(p.medalha) AS total_ouro, a.nome as atleta_nome
FROM Participacao p
JOIN Modalidades m ON p.modalidade_id = m.id
JOIN AtletaMaisMedalhas am ON p.atleta_id = am.atleta_id
JOIN atletas a on a.id = am.atleta_id
WHERE p.medalha = 'Gold'
GROUP BY m.nome, a.nome;








-- 6) Listar quantas medalhas e cada tipo foi ganha por cada país
SELECT 
    p.nome AS pais, 
    COUNT(part.medalha) AS total_medalhas,
    SUM(CASE WHEN part.medalha = 'Gold' THEN 1 ELSE 0 END) AS ouros,
    SUM(CASE WHEN part.medalha = 'Silver' THEN 1 ELSE 0 END) AS pratas,
    SUM(CASE WHEN part.medalha = 'Bronze' THEN 1 ELSE 0 END) AS bronzes
FROM 
    Participacao part
JOIN 
    Paises p ON part.pais_id = p.id
GROUP BY 
    p.nome
ORDER BY 
    total_medalhas DESC;


-- 7) Listar a quantidade total de participações que ocorreu em cada evento
SELECT e.ano, e.cidade, COUNT(part.id) AS total_participacoes
FROM Participacao part
JOIN Eventos e ON part.evento_id = e.id
GROUP BY e.ano, e.cidade
ORDER BY total_participacoes DESC;


-- 8) Listar a média de idade dos atletas de cada modalidade
SELECT m.nome AS modalidade, ROUND(AVG(part.idade),2) AS media_idade
FROM Participacao part
JOIN Modalidades m ON part.modalidade_id = m.id
GROUP BY m.nome
ORDER BY media_idade ASC;


-- 9) Listar a média de idade dos atletas que foram medalhistas em cada evento
SELECT e.ano, e.cidade, ROUND(AVG(part.idade), 2) AS media_idade
FROM Participacao part
JOIN Eventos e ON part.evento_id = e.id
WHERE part.medalha IS NOT NULL
GROUP BY e.ano, e.cidade
ORDER BY e.ano;

-- 10) Listar o total de medalhas ganhar em cada esporte,
-- e a distribuição delas entre ouro, prata e bronze
SELECT 
    esp.nome AS esporte, 
    COUNT(part.medalha) AS total_medalhas,
    SUM(CASE WHEN part.medalha = 'Gold' THEN 1 ELSE 0 END) AS ouros,
    SUM(CASE WHEN part.medalha = 'Silver' THEN 1 ELSE 0 END) AS pratas,
    SUM(CASE WHEN part.medalha = 'Bronze' THEN 1 ELSE 0 END) AS bronzes
FROM Participacao part
JOIN Modalidades m ON part.modalidade_id = m.id
JOIN Esportes esp ON m.esporte_id = esp.id
GROUP BY esp.nome
ORDER BY total_medalhas DESC;


-- 11) Listar os atletas com mais medalhas por evento e por qual país competiram
SELECT distinct e.ano, e.cidade, a.nome AS atleta, p.noc as pais,
    COUNT(part.medalha) AS total_medalhas
FROM Participacao part
JOIN Eventos e ON part.evento_id = e.id
JOIN Atletas a ON part.atleta_id = a.id
JOIN Paises p ON p.id = part.pais_id
GROUP BY e.ano, e.cidade, a.nome , p.noc
ORDER BY total_medalhas DESC
LIMIT 10;

-- 12) Listar as modalidades com a maior proporção de medalhas de ouro em relação ao nº de participações;
SELECT m.nome AS modalidade, 
    (SUM(CASE WHEN part.medalha = 'Gold' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS proporcao_ouro
FROM Participacao part
JOIN Modalidades m ON part.modalidade_id = m.id
GROUP BY m.nome
ORDER BY proporcao_ouro DESC;


-- 13) Análise de Participações e Medalhas por Modalidade e Sexo
SELECT 
    m.nome AS modalidade, 
    a.sexo, 
    COUNT(*) AS participacoes,
    COUNT(part.medalha) AS total_medalhas,
    SUM(CASE WHEN part.medalha = 'Gold' THEN 1 ELSE 0 END) AS ouros,
    SUM(CASE WHEN part.medalha = 'Silver' THEN 1 ELSE 0 END) AS pratas,
    SUM(CASE WHEN part.medalha = 'Bronze' THEN 1 ELSE 0 END) AS bronzes
FROM Participacao part
JOIN Modalidades m ON part.modalidade_id = m.id
JOIN Atletas a ON part.atleta_id = a.id
GROUP BY m.nome, a.sexo
ORDER BY participacoes DESC, total_medalhas DESC;


-- 14) Listar o total de medalhistas por país usando subconsulta no FROM
SELECT p.nome AS pais, medalhas_por_pais.total_medalhas, medalhas_por_pais.total_ouros,
    medalhas_por_pais.total_pratas, medalhas_por_pais.total_bronzes,
    COUNT(DISTINCT a.id) AS total_atletas_medalhistas
FROM 
    (SELECT 
        part.pais_id, COUNT(part.medalha) AS total_medalhas,
        SUM(CASE WHEN part.medalha = 'Gold' THEN 1 ELSE 0 END) AS total_ouros,
        SUM(CASE WHEN part.medalha = 'Silver' THEN 1 ELSE 0 END) AS total_pratas,
        SUM(CASE WHEN part.medalha = 'Bronze' THEN 1 ELSE 0 END) AS total_bronzes
     FROM Participacao part
     WHERE part.medalha IS NOT NULL
     GROUP BY part.pais_id
    ) AS medalhas_por_pais
JOIN Paises p ON medalhas_por_pais.pais_id = p.id
JOIN Participacao part ON p.id = part.pais_id
JOIN Atletas a ON part.atleta_id = a.id
WHERE part.medalha IS NOT NULL
GROUP BY p.nome, medalhas_por_pais.total_medalhas, medalhas_por_pais.total_ouros, medalhas_por_pais.total_pratas, medalhas_por_pais.total_bronzes
ORDER BY medalhas_por_pais.total_medalhas DESC;



-- 15) Listar os atletas com mais medalhas por modalidade
SELECT m.nome AS modalidade, a.nome AS atleta, p.noc as país, total_medalhas
FROM 
    (SELECT part.modalidade_id, part.atleta_id, COUNT(part.medalha) AS total_medalhas
     FROM Participacao part
     WHERE part.medalha IS NOT NULL
     GROUP BY part.modalidade_id, part.atleta_id
    ) AS atleta_medalhas
JOIN Modalidades m ON atleta_medalhas.modalidade_id = m.id
JOIN Atletas a ON atleta_medalhas.atleta_id = a.id
JOIN Paises p ON p.id = a.pais_id
WHERE (atleta_medalhas.modalidade_id, atleta_medalhas.total_medalhas) IN
    (SELECT modalidade_id, MAX(total_medalhas)
     FROM 
        (SELECT part.modalidade_id,part.atleta_id, COUNT(part.medalha) AS total_medalhas
         FROM Participacao part
         WHERE part.medalha IS NOT NULL
         GROUP BY part.modalidade_id, part.atleta_id
        ) AS subquery
     GROUP BY modalidade_id
    )
ORDER BY modalidade, total_medalhas DESC;



-- 16) Listar o número de participações por país em Olimpíadas de Verão e Inverno
SELECT 
    p.nome AS pais,
    (SELECT COUNT(*) 
     FROM Participacao part 
     JOIN Eventos e ON part.evento_id = e.id 
     WHERE part.pais_id = p.id AND e.estacao = 'Summer') AS participacoes_verao,
    (SELECT COUNT(*) 
     FROM Participacao part 
     JOIN Eventos e ON part.evento_id = e.id 
     WHERE part.pais_id = p.id AND e.estacao = 'Winter') AS participacoes_inverno
FROM 
    Paises p
ORDER BY 
    participacoes_verao DESC, participacoes_inverno DESC;



