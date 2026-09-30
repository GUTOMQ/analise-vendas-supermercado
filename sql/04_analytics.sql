-- ============================================================
-- PROJETO: SUPERMARKET SALES
-- ARQUIVO: 04_analytics.sql
-- DESCRIÇÃO: Criação da camada Analytics
-- FONTE: tratado.vendas
-- ============================================================


-- ============================================================
-- 1. KPIs GERAIS
-- ============================================================

DROP TABLE IF EXISTS analytics.kpis_gerais;

CREATE TABLE analytics.kpis_gerais AS
SELECT
    COUNT(*) AS total_vendas,
    SUM(quantidade) AS total_unidades,
    SUM(valor_total) AS faturamento_total,
    AVG(valor_total) AS ticket_medio,
    MIN(valor_total) AS menor_venda,
    MAX(valor_total) AS maior_venda,
    MIN(data_venda) AS primeira_data,
    MAX(data_venda) AS ultima_data
FROM tratado.vendas;


-- ============================================================
-- 2. VENDAS POR FILIAL
-- ============================================================

DROP TABLE IF EXISTS analytics.vendas_por_filial;

CREATE TABLE analytics.vendas_por_filial AS
SELECT
    filial,
    cidade,
    COUNT(*) AS quantidade_vendas,
    SUM(quantidade) AS unidades_vendidas,
    SUM(valor_total) AS faturamento,
    AVG(valor_total) AS ticket_medio
FROM tratado.vendas
GROUP BY
    filial,
    cidade;


-- ============================================================
-- 3. VENDAS POR PRODUTO
-- ============================================================

DROP TABLE IF EXISTS analytics.vendas_por_produto;

CREATE TABLE analytics.vendas_por_produto AS
SELECT
    linha_produto,
    COUNT(*) AS quantidade_vendas,
    SUM(quantidade) AS unidades_vendidas,
    SUM(valor_total) AS faturamento,
    AVG(valor_total) AS ticket_medio
FROM tratado.vendas
GROUP BY linha_produto;


-- ============================================================
-- 4. VENDAS POR MÊS
-- ============================================================

DROP TABLE IF EXISTS analytics.vendas_por_mes;

CREATE TABLE analytics.vendas_por_mes AS
SELECT
    DATE_TRUNC('month', data_venda)::date AS mes,
    COUNT(*) AS quantidade_vendas,
    SUM(quantidade) AS unidades_vendidas,
    SUM(valor_total) AS faturamento,
    AVG(valor_total) AS ticket_medio
FROM tratado.vendas
GROUP BY DATE_TRUNC('month', data_venda)::date
ORDER BY mes;


-- ============================================================
-- 5. VENDAS POR PAGAMENTO
-- ============================================================

DROP TABLE IF EXISTS analytics.vendas_por_pagamento;

CREATE TABLE analytics.vendas_por_pagamento AS
SELECT
    forma_pagamento,
    COUNT(*) AS quantidade_vendas,
    SUM(valor_total) AS faturamento,
    AVG(valor_total) AS ticket_medio
FROM tratado.vendas
GROUP BY forma_pagamento;


-- ============================================================
-- 6. VENDAS POR TIPO DE CLIENTE
-- ============================================================

DROP TABLE IF EXISTS analytics.vendas_por_cliente;

CREATE TABLE analytics.vendas_por_cliente AS
SELECT
    tipo_cliente,
    COUNT(*) AS quantidade_vendas,
    SUM(quantidade) AS unidades_vendidas,
    SUM(valor_total) AS faturamento,
    AVG(valor_total) AS ticket_medio
FROM tratado.vendas
GROUP BY tipo_cliente;


-- ============================================================
-- 7. VENDAS POR GÊNERO
-- ============================================================

DROP TABLE IF EXISTS analytics.vendas_por_genero;

CREATE TABLE analytics.vendas_por_genero AS
SELECT
    genero,
    COUNT(*) AS quantidade_vendas,
    SUM(quantidade) AS unidades_vendidas,
    SUM(valor_total) AS faturamento,
    AVG(valor_total) AS ticket_medio
FROM tratado.vendas
GROUP BY genero;


-- ============================================================
-- 8. VENDAS POR CIDADE
-- ============================================================

DROP TABLE IF EXISTS analytics.vendas_por_cidade;

CREATE TABLE analytics.vendas_por_cidade AS
SELECT
    cidade,
    COUNT(*) AS quantidade_vendas,
    SUM(quantidade) AS unidades_vendidas,
    SUM(valor_total) AS faturamento,
    AVG(valor_total) AS ticket_medio
FROM tratado.vendas
GROUP BY cidade;


-- ============================================================
-- 9. VENDAS POR DIA DA SEMANA
-- ============================================================

DROP TABLE IF EXISTS analytics.vendas_por_dia_semana;

CREATE TABLE analytics.vendas_por_dia_semana AS
SELECT
    dia_semana,
    EXTRACT(ISODOW FROM data_venda) AS numero_dia,
    COUNT(*) AS quantidade_vendas,
    SUM(quantidade) AS unidades_vendidas,
    SUM(valor_total) AS faturamento
FROM tratado.vendas
GROUP BY
    dia_semana,
    EXTRACT(ISODOW FROM data_venda)
ORDER BY numero_dia;


-- ============================================================
-- 10. AVALIAÇÃO POR PRODUTO
-- ============================================================

DROP TABLE IF EXISTS analytics.avaliacao_por_produto;

CREATE TABLE analytics.avaliacao_por_produto AS
SELECT
    linha_produto,
    ROUND(AVG(avaliacao)::numeric, 2) AS avaliacao_media,
    COUNT(*) AS quantidade_vendas
FROM tratado.vendas
GROUP BY linha_produto;


-- ============================================================
-- 11. INDICADORES DE IMPOSTOS
-- ============================================================

DROP TABLE IF EXISTS analytics.indicadores_impostos;

CREATE TABLE analytics.indicadores_impostos AS
SELECT
    SUM(imposto) AS imposto_total,
    AVG(imposto) AS imposto_medio,
    MIN(imposto) AS menor_imposto,
    MAX(imposto) AS maior_imposto
FROM tratado.vendas;


-- ============================================================
-- 12. RECEITA POR PRODUTO
-- ============================================================

DROP TABLE IF EXISTS analytics.receita_por_produto;

CREATE TABLE analytics.receita_por_produto AS
SELECT
    linha_produto,
    SUM(receita_bruta) AS receita_bruta,
    SUM(custo_mercadoria) AS custo_mercadoria,
    SUM(valor_total) AS faturamento
FROM tratado.vendas
GROUP BY linha_produto;


-- ============================================================
-- 13. MAIORES VENDAS
-- ============================================================

DROP TABLE IF EXISTS analytics.maiores_vendas;

CREATE TABLE analytics.maiores_vendas AS
SELECT
    id_venda,
    filial,
    cidade,
    linha_produto,
    valor_total AS valor_venda,
    quantidade
FROM tratado.vendas
ORDER BY valor_total DESC
LIMIT 10;
