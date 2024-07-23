UPDATE Participacao p
JOIN Atletas a ON p.atleta_id = a.id
JOIN Eventos e ON p.evento_id = e.id
SET p.idade = (e.ano - a.nascimento)
WHERE a.pais_id IN( SELECT pa.id 
					FROM paises pa 
					WHERE pa.noc = "GRE"
);