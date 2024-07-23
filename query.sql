-- 1) Obter a média de altura e peso dos atletas que participaram  em eventos de cada esporte, agrupado por esporte:
SELECT es.nome AS esporte, ROUND(AVG(p.altura),2) AS media_altura, ROUND(AVG(p.peso),2) AS media_peso
FROM Participacao p
JOIN Modalidades m ON p.modalidade_id = m.id
JOIN Esportes es ON m.esporte_id = es.id
GROUP BY es.nome; 

-- 2) Listar TOP 3 eventos com mais medalhas de ouro, mostrando a quantidade das outras premiações atletas
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