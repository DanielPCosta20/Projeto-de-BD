DROP VIEW Vendas;
CREATE VIEW Vendas(ean, cat, ano, trimestre, mes, dia_mes, dia_semana, distrito, concelho, unidades)
AS SELECT  ean, cat, 
        EXTRACT(YEAR FROM instante) as ano, 
        EXTRACT(QUARTER FROM instante) as trimestre,
        EXTRACT(MONTH FROM instante) as mes,
        EXTRACT(DAY FROM instante) as dia_mes, 
        EXTRACT(DOW FROM instante) as dia_semana, 
        distrito, concelho, unidades 
        FROM evento_reposicao NATURAL JOIN produto INNER JOIN categoria ON produto.cat = categoria.nome
        NATURAL JOIN instalada_em INNER JOIN ponto_de_retalho ON instalada_em.local = ponto_de_retalho.nome;