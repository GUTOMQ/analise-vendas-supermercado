-- ============================================================
-- PROJETO: ANÁLISE DE VENDAS DE SUPERMERCADO
-- ARQUIVO: 02_criar_tabelas.sql
-- DESCRIÇÃO: Criação da tabela da camada Raw
-- ============================================================


-- ============================================================
-- 1. SCHEMA RAW
-- ============================================================

CREATE SCHEMA IF NOT EXISTS raw;


-- ============================================================
-- 2. TABELA RAW
-- ============================================================
-- A camada Raw recebe os dados provenientes do CSV.
-- Os dados são mantidos como texto, preservando a fonte original.
-- A transformação dos tipos ocorre posteriormente na camada
-- Staging.
-- ============================================================

CREATE TABLE IF NOT EXISTS raw.vendas (

    id_venda TEXT,

    filial TEXT,

    cidade TEXT,

    tipo_cliente TEXT,

    genero TEXT,

    linha_produto TEXT,

    preco_unitario TEXT,

    quantidade TEXT,

    imposto TEXT,

    valor_total TEXT,

    data_venda TEXT,

    hora_venda TEXT,

    forma_pagamento TEXT,

    custo_mercadoria TEXT,

    margem_percentual TEXT,

    receita_bruta TEXT,

    avaliacao TEXT
);
