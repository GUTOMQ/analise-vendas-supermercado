-- ============================================================
-- PROJETO: ANÁLISE DE VENDAS DE SUPERMERCADO
-- ARQUIVO: 03_consultas.sql
-- DESCRIÇÃO: Consultas SQL e indicadores de negócio
-- ============================================================


-- ============================================================
-- 1. VISUALIZAÇÃO DOS DADOS
-- ============================================================

SELECT *
FROM raw.vendas
LIMIT 10;


-- ============================================================
-- 2. QUANTIDADE TOTAL DE REGISTROS
-- ============================================================

SELECT
    COUNT(*) AS total_registros
FROM raw.vendas;


-- ============================================================
-- 3. QUANTIDADE DE VENDAS
-- ============================================================

SELECT
    COUNT("Invoice ID") AS total_vendas
FROM raw.vendas;


-- ============================================================
-- 4. FILTRO POR FILIAL
-- ============================================================

SELECT *
FROM raw.vendas
WHERE "Branch" = 'Alex';


-- ============================================================
-- 5. FILTRO POR TIPO DE CLIENTE
-- ============================================================

SELECT *
FROM raw.vendas
WHERE "Customer type" = 'Member';


-- ============================================================
-- 6. FATURAMENTO TOTAL
-- ============================================================

SELECT
    SUM("Sales"::NUMERIC) AS faturamento_total
FROM raw.vendas;


-- ============================================================
-- 7. TICKET MÉDIO
-- ============================================================

SELECT
    AVG("Sales"::NUMERIC) AS ticket_medio
FROM raw.vendas;


-- ============================================================
-- 8. QUANTIDADE TOTAL DE ITENS VENDIDOS
-- ============================================================

SELECT
    SUM("Quantity"::INTEGER) AS total_itens
FROM raw.vendas;


-- ============================================================
-- 9. FATURAMENTO POR FILIAL
-- ============================================================

SELECT
    "Branch" AS filial,
    COUNT(*) AS quantidade_vendas,
    SUM("Sales"::NUMERIC) AS faturamento
FROM raw.vendas
GROUP BY "Branch"
ORDER BY faturamento DESC;


-- ============================================================
-- 10. TICKET MÉDIO POR FILIAL
-- ============================================================

SELECT
    "Branch" AS filial,
    AVG("Sales"::NUMERIC) AS ticket_medio
FROM raw.vendas
GROUP BY "Branch"
ORDER BY ticket_medio DESC;


-- ============================================================
-- 11. FATURAMENTO POR CIDADE
-- ============================================================

SELECT
    "City" AS cidade,
    SUM("Sales"::NUMERIC) AS faturamento
FROM raw.vendas
GROUP BY "City"
ORDER BY faturamento DESC;


-- ============================================================
-- 12. FATURAMENTO POR LINHA DE PRODUTO
-- ============================================================

SELECT
    "Product line" AS linha_produto,
    SUM("Sales"::NUMERIC) AS faturamento
FROM raw.vendas
GROUP BY "Product line"
ORDER BY faturamento DESC;


-- ============================================================
-- 13. QUANTIDADE DE VENDAS POR LINHA DE PRODUTO
-- ============================================================

SELECT
    "Product line" AS linha_produto,
    COUNT(*) AS quantidade_vendas
FROM raw.vendas
GROUP BY "Product line"
ORDER BY quantidade_vendas DESC;


-- ============================================================
-- 14. QUANTIDADE VENDIDA POR LINHA DE PRODUTO
-- ============================================================

SELECT
    "Product line" AS linha_produto,
    SUM("Quantity"::INTEGER) AS quantidade_itens
FROM raw.vendas
GROUP BY "Product line"
ORDER BY quantidade_itens DESC;


-- ============================================================
-- 15. FORMAS DE PAGAMENTO
-- ============================================================

SELECT
    "Payment" AS forma_pagamento,
    COUNT(*) AS quantidade_vendas
FROM raw.vendas
GROUP BY "Payment"
ORDER BY quantidade_vendas DESC;


-- ============================================================
-- 16. FATURAMENTO POR FORMA DE PAGAMENTO
-- ============================================================

SELECT
    "Payment" AS forma_pagamento,
    SUM("Sales"::NUMERIC) AS faturamento
FROM raw.vendas
GROUP BY "Payment"
ORDER BY faturamento DESC;


-- ============================================================
-- 17. AVALIAÇÃO MÉDIA DOS CLIENTES
-- ============================================================

SELECT
    AVG("Rating"::NUMERIC) AS avaliacao_media
FROM raw.vendas;


-- ============================================================
-- 18. AVALIAÇÃO MÉDIA POR FILIAL
-- ============================================================

SELECT
    "Branch" AS filial,
    AVG("Rating"::NUMERIC) AS avaliacao_media
FROM raw.vendas
GROUP BY "Branch"
ORDER BY avaliacao_media DESC;


-- ============================================================
-- 19. FATURAMENTO POR TIPO DE CLIENTE
-- ============================================================

SELECT
    "Customer type" AS tipo_cliente,
    COUNT(*) AS quantidade_vendas,
    SUM("Sales"::NUMERIC) AS faturamento
FROM raw.vendas
GROUP BY "Customer type"
ORDER BY faturamento DESC;


-- ============================================================
-- 20. FATURAMENTO POR GÊNERO
-- ============================================================

SELECT
    "Gender" AS genero,
    COUNT(*) AS quantidade_vendas,
    SUM("Sales"::NUMERIC) AS faturamento
FROM raw.vendas
GROUP BY "Gender"
ORDER BY faturamento DESC;


-- ============================================================
-- 21. PREÇO UNITÁRIO MÉDIO POR LINHA DE PRODUTO
-- ============================================================

SELECT
    "Product line" AS linha_produto,
    AVG("Unit price"::NUMERIC) AS preco_medio
FROM raw.vendas
GROUP BY "Product line"
ORDER BY preco_medio DESC;


-- ============================================================
-- 22. RECEITA BRUTA POR LINHA DE PRODUTO
-- ============================================================

SELECT
    "Product line" AS linha_produto,
    SUM("gross income"::NUMERIC) AS receita_bruta
FROM raw.vendas
GROUP BY "Product line"
ORDER BY receita_bruta DESC;


-- ============================================================
-- 23. CUSTO DE MERCADORIA POR LINHA DE PRODUTO
-- ============================================================

SELECT
    "Product line" AS linha_produto,
    SUM("cogs"::NUMERIC) AS custo_mercadoria
FROM raw.vendas
GROUP BY "Product line"
ORDER BY custo_mercadoria DESC;


-- ============================================================
-- 24. VENDAS COM VALOR ACIMA DA MÉDIA
-- ============================================================

SELECT
    "Invoice ID" AS id_venda,
    "Branch" AS filial,
    "Product line" AS linha_produto,
    "Sales"::NUMERIC AS valor_total
FROM raw.vendas
WHERE "Sales"::NUMERIC > (
    SELECT AVG("Sales"::NUMERIC)
    FROM raw.vendas
)
ORDER BY "Sales"::NUMERIC DESC;


-- ============================================================
-- 25. MAIORES VENDAS
-- ============================================================

SELECT
    "Invoice ID" AS id_venda,
    "Branch" AS filial,
    "City" AS cidade,
    "Product line" AS linha_produto,
    "Sales"::NUMERIC AS valor_total
FROM raw.vendas
ORDER BY "Sales"::NUMERIC DESC
LIMIT 10;


-- ============================================================
-- 26. MENORES VENDAS
-- ============================================================

SELECT
    "Invoice ID" AS id_venda,
    "Branch" AS filial,
    "City" AS cidade,
    "Product line" AS linha_produto,
    "Sales"::NUMERIC AS valor_total
FROM raw.vendas
ORDER BY "Sales"::NUMERIC
LIMIT 10;


-- ============================================================
-- 27. VALOR MÉDIO DE IMPOSTO
-- ============================================================

SELECT
    AVG("Tax 5%"::NUMERIC) AS imposto_medio
FROM raw.vendas;


-- ============================================================
-- 28. IMPOSTO TOTAL
-- ============================================================

SELECT
    SUM("Tax 5%"::NUMERIC) AS imposto_total
FROM raw.vendas;


-- ============================================================
-- 29. VERIFICAÇÃO DE DUPLICIDADES
-- ============================================================

SELECT
    "Invoice ID" AS id_venda,
    COUNT(*) AS quantidade
FROM raw.vendas
GROUP BY "Invoice ID"
HAVING COUNT(*) > 1;


-- ============================================================
-- 30. VERIFICAÇÃO DE VALORES INVÁLIDOS
-- ============================================================

SELECT *
FROM raw.vendas
WHERE "Unit price"::NUMERIC < 0
   OR "Quantity"::INTEGER <= 0
   OR "Tax 5%"::NUMERIC < 0
   OR "Sales"::NUMERIC < 0
   OR "cogs"::NUMERIC < 0
   OR "gross income"::NUMERIC < 0
   OR "Rating"::NUMERIC < 0
   OR "Rating"::NUMERIC > 10;
