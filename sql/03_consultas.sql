-- ============================================================
-- PROJETO: ANÁLISE DE VENDAS DE SUPERMERCADO
-- ARQUIVO: 03_consultas.sql
-- DESCRIÇÃO: Consultas SQL e indicadores de negócio
-- ============================================================


-- ============================================================
-- 1. VISUALIZAÇÃO DOS DADOS
-- ============================================================

SELECT *
FROM raw_vendas
LIMIT 10;


-- ============================================================
-- 2. QUANTIDADE TOTAL DE REGISTROS
-- ============================================================

SELECT
    COUNT(*) AS total_registros
FROM raw_vendas;


-- ============================================================
-- 3. QUANTIDADE DE VENDAS
-- ============================================================

SELECT
    COUNT(id_venda) AS total_vendas
FROM raw_vendas;


-- ============================================================
-- 4. FILTRO POR FILIAL
-- ============================================================

SELECT *
FROM raw_vendas
WHERE filial = 'A';


-- ============================================================
-- 5. FILTRO POR TIPO DE CLIENTE
-- ============================================================

SELECT *
FROM raw_vendas
WHERE tipo_cliente = 'Member';


-- ============================================================
-- 6. FATURAMENTO TOTAL
-- ============================================================

SELECT
    SUM(valor_total::NUMERIC) AS faturamento_total
FROM raw_vendas;


-- ============================================================
-- 7. TICKET MÉDIO
-- ============================================================

SELECT
    AVG(valor_total::NUMERIC) AS ticket_medio
FROM raw_vendas;


-- ============================================================
-- 8. QUANTIDADE TOTAL DE ITENS VENDIDOS
-- ============================================================

SELECT
    SUM(quantidade::INTEGER) AS total_itens
FROM raw_vendas;


-- ============================================================
-- 9. FATURAMENTO POR FILIAL
-- ============================================================

SELECT
    filial,
    COUNT(*) AS quantidade_vendas,
    SUM(valor_total::NUMERIC) AS faturamento
FROM raw_vendas
GROUP BY filial
ORDER BY faturamento DESC;


-- ============================================================
-- 10. TICKET MÉDIO POR FILIAL
-- ============================================================

SELECT
    filial,
    AVG(valor_total::NUMERIC) AS ticket_medio
FROM raw_vendas
GROUP BY filial
ORDER BY ticket_medio DESC;


-- ============================================================
-- 11. FATURAMENTO POR CIDADE
-- ============================================================

SELECT
    cidade,
    SUM(valor_total::NUMERIC) AS faturamento
FROM raw_vendas
GROUP BY cidade
ORDER BY faturamento DESC;


-- ============================================================
-- 12. FATURAMENTO POR LINHA DE PRODUTO
-- ============================================================

SELECT
    linha_produto,
    SUM(valor_total::NUMERIC) AS faturamento
FROM raw_vendas
GROUP BY linha_produto
ORDER BY faturamento DESC;


-- ============================================================
-- 13. QUANTIDADE DE VENDAS POR LINHA DE PRODUTO
-- ============================================================

SELECT
    linha_produto,
    COUNT(*) AS quantidade_vendas
FROM raw_vendas
GROUP BY linha_produto
ORDER BY quantidade_vendas DESC;


-- ============================================================
-- 14. QUANTIDADE VENDIDA POR LINHA DE PRODUTO
-- ============================================================

SELECT
    linha_produto,
    SUM(quantidade::INTEGER) AS quantidade_itens
FROM raw_vendas
GROUP BY linha_produto
ORDER BY quantidade_itens DESC;


-- ============================================================
-- 15. FORMAS DE PAGAMENTO
-- ============================================================

SELECT
    forma_pagamento,
    COUNT(*) AS quantidade_vendas
FROM raw_vendas
GROUP BY forma_pagamento
ORDER BY quantidade_vendas DESC;


-- ============================================================
-- 16. FATURAMENTO POR FORMA DE PAGAMENTO
-- ============================================================

SELECT
    forma_pagamento,
    SUM(valor_total::NUMERIC) AS faturamento
FROM raw_vendas
GROUP BY forma_pagamento
ORDER BY faturamento DESC;


-- ============================================================
-- 17. AVALIAÇÃO MÉDIA DOS CLIENTES
-- ============================================================

SELECT
    AVG(avaliacao::NUMERIC) AS avaliacao_media
FROM raw_vendas;


-- ============================================================
-- 18. AVALIAÇÃO MÉDIA POR FILIAL
-- ============================================================

SELECT
    filial,
    AVG(avaliacao::NUMERIC) AS avaliacao_media
FROM raw_vendas
GROUP BY filial
ORDER BY avaliacao_media DESC;


-- ============================================================
-- 19. FATURAMENTO POR TIPO DE CLIENTE
-- ============================================================

SELECT
    tipo_cliente,
    COUNT(*) AS quantidade_vendas,
    SUM(valor_total::NUMERIC) AS faturamento
FROM raw_vendas
GROUP BY tipo_cliente
ORDER BY faturamento DESC;


-- ============================================================
-- 20. FATURAMENTO POR GÊNERO
-- ============================================================

SELECT
    genero,
    COUNT(*) AS quantidade_vendas,
    SUM(valor_total::NUMERIC) AS faturamento
FROM raw_vendas
GROUP BY genero
ORDER BY faturamento DESC;


-- ============================================================
-- 21. PREÇO UNITÁRIO MÉDIO POR LINHA DE PRODUTO
-- ============================================================

SELECT
    linha_produto,
    AVG(preco_unitario::NUMERIC) AS preco_medio
FROM raw_vendas
GROUP BY linha_produto
ORDER BY preco_medio DESC;


-- ============================================================
-- 22. RECEITA BRUTA POR LINHA DE PRODUTO
-- ============================================================

SELECT
    linha_produto,
    SUM(receita_bruta::NUMERIC) AS receita_bruta
FROM raw_vendas
GROUP BY linha_produto
ORDER BY receita_bruta DESC;


-- ============================================================
-- 23. CUSTO DE MERCADORIA POR LINHA DE PRODUTO
-- ============================================================

SELECT
    linha_produto,
    SUM(custo_mercadoria::NUMERIC) AS custo_mercadoria
FROM raw_vendas
GROUP BY linha_produto
ORDER BY custo_mercadoria DESC;


-- ============================================================
-- 24. VENDAS COM VALOR ACIMA DA MÉDIA
-- ============================================================

SELECT
    id_venda,
    filial,
    linha_produto,
    valor_total
FROM raw_vendas
WHERE valor_total::NUMERIC > (
    SELECT AVG(valor_total::NUMERIC)
    FROM raw_vendas
)
ORDER BY valor_total::NUMERIC DESC;


-- ============================================================
-- 25. MAIORES VENDAS
-- ============================================================

SELECT
    id_venda,
    filial,
    cidade,
    linha_produto,
    valor_total
FROM raw_vendas
ORDER BY valor_total::NUMERIC DESC
LIMIT 10;


-- ============================================================
-- 26. MENORES VENDAS
-- ============================================================

SELECT
    id_venda,
    filial,
    cidade,
    linha_produto,
    valor_total
FROM raw_vendas
ORDER BY valor_total::NUMERIC
LIMIT 10;


-- ============================================================
-- 27. VALOR MÉDIO DE IMPOSTO
-- ============================================================

SELECT
    AVG(imposto::NUMERIC) AS imposto_medio
FROM raw_vendas;


-- ============================================================
-- 28. IMPOSTO TOTAL
-- ============================================================

SELECT
    SUM(imposto::NUMERIC) AS imposto_total
FROM raw_vendas;


-- ============================================================
-- 29. VERIFICAÇÃO DE DUPLICIDADES
-- ============================================================

SELECT
    id_venda,
    COUNT(*) AS quantidade
FROM raw_vendas
GROUP BY id_venda
HAVING COUNT(*) > 1;


-- ============================================================
-- 30. VERIFICAÇÃO DE VALORES INVÁLIDOS
-- ============================================================

SELECT *
FROM raw_vendas
WHERE preco_unitario::NUMERIC < 0
   OR quantidade::INTEGER <= 0
   OR imposto::NUMERIC < 0
   OR valor_total::NUMERIC < 0
   OR custo_mercadoria::NUMERIC < 0
   OR receita_bruta::NUMERIC < 0
   OR avaliacao::NUMERIC < 0
   OR avaliacao::NUMERIC > 10;
