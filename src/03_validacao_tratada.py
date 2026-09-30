"""
Projeto: Análise de Dados com Python
Arquivo: 03_validacao_tratada.py

Objetivo:
    Validar a estrutura e a qualidade da base tratada
    antes da etapa de análise estatística.
"""

import pandas as pd


# ============================================================
# LEITURA DA BASE TRATADA
# ============================================================

caminho = "data/processed/vendas_tratadas.csv"

df = pd.read_csv(caminho)


# ============================================================
# INFORMAÇÕES GERAIS
# ============================================================

print("=" * 60)
print("VALIDAÇÃO DA BASE TRATADA")
print("=" * 60)

print("\nDimensão:")
print(df.shape)

print("\nColunas:")
print(df.columns.tolist())

print("\nTipos de dados antes da conversão:")
print(df.dtypes)


# ============================================================
# CONVERSÃO PARA VALIDAÇÃO
# ============================================================

df["data_venda"] = pd.to_datetime(
    df["data_venda"],
    errors="coerce",
)

df["hora_venda"] = pd.to_datetime(
    df["hora_venda"],
    format="%H:%M:%S",
    errors="coerce",
).dt.time


# ============================================================
# VALORES NULOS
# ============================================================

print("\nValores nulos:")
print(df.isnull().sum())


# ============================================================
# DUPLICIDADES
# ============================================================

print("\nDuplicidades pelo ID da venda:")

duplicidades = df["id_venda"].duplicated().sum()

print(duplicidades)


# ============================================================
# ESTATÍSTICAS
# ============================================================

print("\nEstatísticas descritivas:")

print(
    df[
        [
            "preco_unitario",
            "quantidade",
            "imposto",
            "valor_total",
            "custo_mercadoria",
            "receita_bruta",
            "avaliacao",
            "ticket_medio_item",
        ]
    ].describe()
)


# ============================================================
# VALIDAÇÕES DE REGRAS
# ============================================================

print("\nValores inválidos:")

print(
    "Preço unitário < 0:",
    (df["preco_unitario"] < 0).sum(),
)

print(
    "Quantidade <= 0:",
    (df["quantidade"] <= 0).sum(),
)

print(
    "Valor total < 0:",
    (df["valor_total"] < 0).sum(),
)

print(
    "Avaliação fora de 0-10:",
    (
        (df["avaliacao"] < 0)
        | (df["avaliacao"] > 10)
    ).sum(),
)


# ============================================================
# DISTRIBUIÇÃO POR FILIAL
# ============================================================

print("\nQuantidade de vendas por filial:")

print(
    df["filial"]
    .value_counts()
)


# ============================================================
# DISTRIBUIÇÃO POR DIA DA SEMANA
# ============================================================

print("\nQuantidade de vendas por dia da semana:")

print(
    df["dia_semana"]
    .value_counts()
)


print("\n" + "=" * 60)
print("VALIDAÇÃO CONCLUÍDA")
print("=" * 60)
