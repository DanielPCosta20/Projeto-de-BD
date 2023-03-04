-- 1)

SELECT dia_semana, concelho, SUM(unidades) AS Total_unidades
FROM Vendas
WHERE CAST(CONCAT(ano, '-', mes, '-', dia_mes) AS DATE) BETWEEN '2022-01-01' AND '2022-03-13'
GROUP BY GROUPING SETS ((dia_semana), (concelho), ());

-- 2)

SELECT concelho, cat, dia_semana, SUM(unidades) AS Total_unidades
FROM Vendas
WHERE distrito = 'Lisboa'
GROUP BY GROUPING SETS ((concelho), (cat), (dia_semana), ());