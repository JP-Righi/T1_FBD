use olimpiadasintegrado;
UPDATE olimpiadasintegrado.atletas a
JOIN (
    SELECT p.atleta_id, e.ano - p.idade AS ano_nascimento
    FROM Participacao p
    JOIN Eventos e ON p.evento_id = e.id
    WHERE p.idade IS NOT NULL
) sub ON a.id = sub.atleta_id
SET a.nascimento = sub.ano_nascimento;