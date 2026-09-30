"""
Projeto: Análise de Dados com Python
Arquivo: 02_etl_vendas.py

Objetivo:
    Realizar a limpeza, transformação e validação dos dados
    da camada Raw e gerar a base tratada.
"""

import os

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine


# ============================================================
# CONFIGURAÇÃO
# ============================================================

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")


# ============================================================
# CONEXÃO COM O POSTGRESQL
# ============================================================

connection_url = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(connection_url)


# ============================================================
# LEITURA DA CAMADA RAW
# ============================================================

query = """
SELECT *
FROM raw_vendas;
"""

df = pd.read_sql(query, engine)

print("=" * 60)
print("INÍCIO DO PROCESSO DE ETL")
print("=" * 60)

print(f"\nBanco utilizado: {DB_NAME}")
print(f"Usuário: {DB_USER}")
print(f"Registros recebidos da Raw: {len(df)}")

print("\nColunas recebidas:")
print(df.columns.tolist())


# ============================================================
# PADRONIZAÇÃO DOS NOMES DAS COLUNAS
# ============================================================

df.columns = (
    df.columns
    .str.strip()
    .str.lower()
)


# ============================================================
# LIMPEZA DE ESPAÇOS EM CAMPOS DE TEXTO
# ============================================================

colunas_texto = [
    "id_venda",
    "filial",
    "cidade",
    "tipo_cliente",
    "genero",
    "linha_produto",
    "forma_pagamento",
]

for coluna in colunas_texto:
    df[coluna] = (
        df[coluna]
        .astype("string")
        .str.strip()
    )


print(f"\nApós tratamento dos textos: {len(df)} registros")


# ============================================================
# CONVERSÃO DE TIPOS NUMÉRICOS
# ============================================================

colunas_numericas = [
    "preco_unitario",
    "quantidade",
    "imposto",
    "valor_total",
    "custo_mercadoria",
    "margem_percentual",
    "receita_bruta",
    "avaliacao",
]

for coluna in colunas_numericas:
    df[coluna] = pd.to_numeric(
        df[coluna],
        errors="coerce",
    )


print("\nValores nulos após conversão numérica:")

nulos_numericos = df[colunas_numericas].isnull().sum()

print(nulos_numericos[nulos_numericos > 0])


# ============================================================
# CONVERSÃO DE DATA
# ============================================================

df["data_venda"] = pd.to_datetime(
    df["data_venda"],
    errors="coerce",
    dayfirst=False,
)

print(
    "\nNulos em data_venda:",
    df["data_venda"].isna().sum(),
)


# ============================================================
# CONVERSÃO DE HORA
# ============================================================

df["hora_venda"] = pd.to_datetime(
    df["hora_venda"],
    format="%I:%M:%S %p",
    errors="coerce",
).dt.time


print(
    "Nulos em hora_venda:",
    df["hora_venda"].isna().sum(),
)


# ============================================================
# VERIFICAÇÃO DE VALORES NULOS
# ============================================================

print("\nValores nulos antes do tratamento:")

nulos = df.isnull().sum()

print(nulos[nulos > 0])


# ============================================================
# VERIFICAÇÃO DE DUPLICIDADES
# ============================================================

duplicados = df.duplicated(
    subset=["id_venda"]
).sum()

print(
    f"\nVendas duplicadas encontradas: {duplicados}"
)


# ============================================================
# REMOÇÃO DE DUPLICIDADES
# ============================================================

df = df.drop_duplicates(
    subset=["id_venda"],
    keep="first",
)

print(
    f"Após remoção de duplicidades: {len(df)} registros"
)


# ============================================================
# TRATAMENTO DE VALORES AUSENTES
# ============================================================

colunas_criticas = [
    "id_venda",
    "filial",
    "cidade",
    "linha_produto",
    "preco_unitario",
    "quantidade",
    "valor_total",
    "data_venda",
    "hora_venda",
    "forma_pagamento",
]

antes = len(df)

df = df.dropna(
    subset=colunas_criticas,
)

depois = len(df)

print(
    "\nRegistros removidos por ausência "
    f"de dados críticos: {antes - depois}"
)

print(
    f"Após tratamento de nulos: {len(df)} registros"
)


# ============================================================
# VALIDAÇÕES DE REGRAS DE NEGÓCIO
# ============================================================

print("\n" + "=" * 60)
print("VALIDAÇÃO DAS REGRAS DE NEGÓCIO")
print("=" * 60)

antes = len(df)

df = df[df["preco_unitario"] >= 0]

print(
    f"Após preço unitário >= 0: {len(df)}"
)

df = df[df["quantidade"] > 0]

print(
    f"Após quantidade > 0: {len(df)}"
)

df = df[df["imposto"] >= 0]

print(
    f"Após imposto >= 0: {len(df)}"
)

df = df[df["valor_total"] >= 0]

print(
    f"Após valor total >= 0: {len(df)}"
)

df = df[df["custo_mercadoria"] >= 0]

print(
    f"Após custo da mercadoria >= 0: {len(df)}"
)

df = df[df["receita_bruta"] >= 0]

print(
    f"Após receita bruta >= 0: {len(df)}"
)

df = df[
    (df["avaliacao"] >= 0)
    & (df["avaliacao"] <= 10)
]

print(
    f"Após avaliação entre 0 e 10: {len(df)}"
)


# ============================================================
# COLUNAS DERIVADAS
# ============================================================

dias_semana = {
    0: "segunda-feira",
    1: "terça-feira",
    2: "quarta-feira",
    3: "quinta-feira",
    4: "sexta-feira",
    5: "sábado",
    6: "domingo",
}

df["dia_semana"] = df["data_venda"].dt.dayofweek.map(
    dias_semana
)

df["mes_venda"] = df["data_venda"].dt.month

df["ano_venda"] = df["data_venda"].dt.year

df["ticket_medio_item"] = (
    df["valor_total"] / df["quantidade"]
)


# ============================================================
# ARREDONDAMENTO DOS VALORES MONETÁRIOS
# ============================================================

colunas_monetarias = [
    "preco_unitario",
    "imposto",
    "valor_total",
    "custo_mercadoria",
    "margem_percentual",
    "receita_bruta",
    "ticket_medio_item",
]

for coluna in colunas_monetarias:
    df[coluna] = df[coluna].round(2)


# ============================================================
# ORGANIZAÇÃO DAS COLUNAS
# ============================================================

colunas_finais = [
    "id_venda",
    "filial",
    "cidade",
    "tipo_cliente",
    "genero",
    "linha_produto",
    "preco_unitario",
    "quantidade",
    "imposto",
    "valor_total",
    "data_venda",
    "hora_venda",
    "forma_pagamento",
    "custo_mercadoria",
    "margem_percentual",
    "receita_bruta",
    "avaliacao",
    "dia_semana",
    "mes_venda",
    "ano_venda",
    "ticket_medio_item",
]

df = df[colunas_finais]


# ============================================================
# VERIFICAÇÃO FINAL
# ============================================================

print("\n" + "=" * 60)
print("VERIFICAÇÃO DA BASE TRATADA")
print("=" * 60)

print(
    f"\nQuantidade final de registros: {len(df)}"
)

print(
    f"Quantidade final de colunas: {len(df.columns)}"
)

print("\nTipos de dados:")
print(df.dtypes)

print("\nValores nulos:")
print(df.isnull().sum())

print("\nPrimeiros registros:")
print(df.head())


# ============================================================
# SALVAMENTO
# ============================================================

os.makedirs(
    "data/processed",
    exist_ok=True,
)

caminho_saida = (
    "data/processed/vendas_tratadas.csv"
)

df.to_csv(
    caminho_saida,
    index=False,
    encoding="utf-8",
)


# ============================================================
# CARGA DA CAMADA TRATADA NO POSTGRESQL
# ============================================================

df.to_sql(
    "vendas",
    engine,
    schema="tratado",
    if_exists="replace",
    index=False,
)

print("\nDados carregados na tabela tratado.vendas:")
print(f"Registros carregados: {len(df)}")

print("\n" + "=" * 60)

print(
    f"Base tratada salva em: {caminho_saida}"
)

print("=" * 60)