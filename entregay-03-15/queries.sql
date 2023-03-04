
/* Qual o nome do retalhista (ou retalhistas) responsáveis pela reposição do maior número de
categorias? */


SELECT name
FROM responsavel_por INNER JOIN retalhista ON responsavel_por.tin = retalhista.tin 
GROUP BY name 
HAVING COUNT(nome_cat) >= ALL
		(SELECT COUNT(nome_cat)
		 FROM responsavel_por NATURAL JOIN retalhista
		 GROUP BY name)


/*Qual o nome do ou dos retalhistas que são responsáveis por todas as categorias simples?*/

SELECT name 
FROM (
    SELECT * 
    FROM responsavel_por p INNER JOIN categoria c ON p.nome_cat = c.nome
    WHERE nome_cat IN ( SELECT * FROM categoria_simples)
) AS aux NATURAL JOIN retalhista
GROUP BY name;

/*Quais os produtos (ean) que nunca foram repostos*/

SELECT  ean
FROM    produto
WHERE   ean not in (
                    SELECT  planograma.ean
                    FROM    planograma INNER JOIN evento_reposicao ON planograma.ean = evento_reposicao.ean);

/*Quais os produtos (ean) que foram repostos sempre pelo mesmo retalhista?*/

SELECT  planograma.ean 
FROM    planograma INNER JOIN evento_reposicao ON planograma.ean = evento_reposicao.ean
GROUP BY planograma.ean 
HAVING COUNT(DISTINCT tin) = 1;