"""
Projeto: Análise de Dados com Python
Arquivo: 03_estatistica.py

Objetivo:
    Realizar a análise estatística da base tratada,
    responder às perguntas de negócio e gerar gráficos.
"""

import os

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns


# ============================================================
# CONFIGURAÇÕES
# ============================================================

ARQUIVO = "data/processed/vendas_tratadas.csv"
PASTA_RESULTADOS = "resultados"

os.makedirs(
    PASTA_RESULTADOS,
    exist_ok=True,
)

sns.set_theme(style="whitegrid")


# ============================================================
# LEITURA DA BASE
# ============================================================

df = pd.read_csv(ARQUIVO)

df["data_venda"] = pd.to_datetime(
    df["data_venda"],
    errors="coerce",
)


# ============================================================
# INFORMAÇÕES GERAIS
# ============================================================

print("=" * 70)
print("ANÁLISE ESTATÍSTICA E PERGUNTAS DE NEGÓCIO")
print("=" * 70)

print(f"\nQuantidade de vendas: {len(df)}")
print(f"Quantidade de colunas: {len(df.columns)}")


# ============================================================
# 1. QUAL FILIAL APRESENTOU O MAIOR FATURAMENTO?
# ============================================================

faturamento_filial = (
    df.groupby("filial")["valor_total"]
    .sum()
    .sort_values(ascending=False)
)

maior_faturamento_filial = faturamento_filial.idxmax()
valor_maior_faturamento = faturamento_filial.max()

print("\n1. FILIAL COM MAIOR FATURAMENTO")
print(f"Filial: {maior_faturamento_filial}")
print(f"Faturamento: R$ {valor_maior_faturamento:,.2f}")


# ============================================================
# 2. QUAL FILIAL REALIZOU A MAIOR QUANTIDADE DE VENDAS?
# ============================================================

quantidade_vendas_filial = (
    df["filial"]
    .value_counts()
    .sort_values(ascending=False)
)

maior_quantidade_filial = quantidade_vendas_filial.idxmax()
quantidade_maior_filial = quantidade_vendas_filial.max()

print("\n2. FILIAL COM MAIOR QUANTIDADE DE VENDAS")
print(f"Filial: {maior_quantidade_filial}")
print(f"Quantidade: {quantidade_maior_filial}")


# ============================================================
# 3. QUAL LINHA DE PRODUTO APRESENTOU O MAIOR FATURAMENTO?
# ============================================================

faturamento_produto = (
    df.groupby("linha_produto")["valor_total"]
    .sum()
    .sort_values(ascending=False)
)

maior_faturamento_produto = faturamento_produto.idxmax()
valor_maior_produto = faturamento_produto.max()

print("\n3. LINHA DE PRODUTO COM MAIOR FATURAMENTO")
print(f"Linha de produto: {maior_faturamento_produto}")
print(f"Faturamento: R$ {valor_maior_produto:,.2f}")


# ============================================================
# 4. QUAL LINHA DE PRODUTO RECEBEU A MELHOR AVALIAÇÃO MÉDIA?
# ============================================================

avaliacao_produto = (
    df.groupby("linha_produto")["avaliacao"]
    .mean()
    .sort_values(ascending=False)
)

melhor_avaliacao_produto = avaliacao_produto.idxmax()
valor_melhor_avaliacao = avaliacao_produto.max()

print("\n4. LINHA DE PRODUTO COM MELHOR AVALIAÇÃO MÉDIA")
print(f"Linha de produto: {melhor_avaliacao_produto}")
print(f"Avaliação média: {valor_melhor_avaliacao:.2f}")


# ============================================================
# 5. QUAL FOI A FORMA DE PAGAMENTO MAIS UTILIZADA?
# ============================================================

formas_pagamento = (
    df["forma_pagamento"]
    .value_counts()
    .sort_values(ascending=False)
)

forma_mais_utilizada = formas_pagamento.idxmax()
quantidade_forma = formas_pagamento.max()

print("\n5. FORMA DE PAGAMENTO MAIS UTILIZADA")
print(f"Forma de pagamento: {forma_mais_utilizada}")
print(f"Quantidade: {quantidade_forma}")


# ============================================================
# 6. QUAL FOI O VALOR MÉDIO DAS VENDAS?
# ============================================================

valor_medio_vendas = df["valor_total"].mean()

print("\n6. VALOR MÉDIO DAS VENDAS")
print(f"Valor médio: R$ {valor_medio_vendas:,.2f}")


# ============================================================
# 7. QUAL FOI A MAIOR VENDA REGISTRADA?
# ============================================================

indice_maior_venda = df["valor_total"].idxmax()

maior_venda = df.loc[indice_maior_venda]

print("\n7. MAIOR VENDA REGISTRADA")
print(f"ID da venda: {maior_venda['id_venda']}")
print(f"Valor: R$ {maior_venda['valor_total']:,.2f}")
print(f"Filial: {maior_venda['filial']}")
print(f"Linha de produto: {maior_venda['linha_produto']}")


# ============================================================
# 8. EM QUAL DIA DA SEMANA OCORREU A MAIOR QUANTIDADE
#    DE VENDAS?
# ============================================================

vendas_dia_semana = (
    df["dia_semana"]
    .value_counts()
)

dia_maior_quantidade = vendas_dia_semana.idxmax()
quantidade_maior_dia = vendas_dia_semana.max()

print("\n8. DIA DA SEMANA COM MAIOR QUANTIDADE DE VENDAS")
print(f"Dia: {dia_maior_quantidade}")
print(f"Quantidade: {quantidade_maior_dia}")


# ============================================================
# ESTATÍSTICAS DESCRITIVAS
# ============================================================

estatisticas = (
    df[
        [
            "preco_unitario",
            "quantidade",
            "imposto",
            "valor_total",
            "custo_mercadoria",
            "receita_bruta",
            "avaliacao",
        ]
    ]
    .describe()
    .round(2)
)

print("\n" + "=" * 70)
print("ESTATÍSTICAS DESCRITIVAS")
print("=" * 70)

print(estatisticas)


# ============================================================
# SALVAR ESTATÍSTICAS
# ============================================================

estatisticas.to_csv(
    f"{PASTA_RESULTADOS}/estatisticas_descritivas.csv"
)


# ============================================================
# GRÁFICO 1 — FATURAMENTO POR FILIAL
# ============================================================

plt.figure(figsize=(8, 5))

faturamento_filial.plot(
    kind="bar",
    color="#2E86C1",
)

plt.title("Faturamento por Filial")
plt.xlabel("Filial")
plt.ylabel("Faturamento (R$)")
plt.xticks(rotation=0)
plt.tight_layout()

plt.savefig(
    f"{PASTA_RESULTADOS}/faturamento_por_filial.png",
    dpi=300,
)

plt.close()


# ============================================================
# GRÁFICO 2 — FATURAMENTO POR LINHA DE PRODUTO
# ============================================================

plt.figure(figsize=(10, 6))

faturamento_produto.sort_values().plot(
    kind="barh",
    color="#28B463",
)

plt.title("Faturamento por Linha de Produto")
plt.xlabel("Faturamento (R$)")
plt.ylabel("Linha de Produto")
plt.tight_layout()

plt.savefig(
    f"{PASTA_RESULTADOS}/faturamento_por_linha_produto.png",
    dpi=300,
)

plt.close()


# ============================================================
# GRÁFICO 3 — FORMAS DE PAGAMENTO
# ============================================================

plt.figure(figsize=(8, 5))

formas_pagamento.plot(
    kind="bar",
    color="#F39C12",
)

plt.title("Formas de Pagamento Mais Utilizadas")
plt.xlabel("Forma de Pagamento")
plt.ylabel("Quantidade de Vendas")
plt.xticks(rotation=0)
plt.tight_layout()

plt.savefig(
    f"{PASTA_RESULTADOS}/formas_pagamento.png",
    dpi=300,
)

plt.close()


# ============================================================
# GRÁFICO 4 — VENDAS POR DIA DA SEMANA
# ============================================================

ordem_dias = [
    "segunda-feira",
    "terça-feira",
    "quarta-feira",
    "quinta-feira",
    "sexta-feira",
    "sábado",
    "domingo",
]

vendas_dia = (
    df["dia_semana"]
    .value_counts()
    .reindex(ordem_dias)
)

plt.figure(figsize=(10, 5))

vendas_dia.plot(
    kind="bar",
    color="#8E44AD",
)

plt.title("Quantidade de Vendas por Dia da Semana")
plt.xlabel("Dia da Semana")
plt.ylabel("Quantidade de Vendas")
plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig(
    f"{PASTA_RESULTADOS}/vendas_por_dia_semana.png",
    dpi=300,
)

plt.close()


# ============================================================
# GRÁFICO 5 — AVALIAÇÃO MÉDIA POR PRODUTO
# ============================================================

plt.figure(figsize=(10, 6))

avaliacao_produto.sort_values().plot(
    kind="barh",
    color="#E74C3C",
)

plt.title("Avaliação Média por Linha de Produto")
plt.xlabel("Avaliação Média")
plt.ylabel("Linha de Produto")
plt.xlim(0, 10)
plt.tight_layout()

plt.savefig(
    f"{PASTA_RESULTADOS}/avaliacao_por_linha_produto.png",
    dpi=300,
)

plt.close()


# ============================================================
# FINALIZAÇÃO
# ============================================================

print("\n" + "=" * 70)
print("ANÁLISE CONCLUÍDA")
print("=" * 70)

print(
    f"\nResultados salvos na pasta: {PASTA_RESULTADOS}/"
)

print("\nArquivos gerados:")

print("- estatisticas_descritivas.csv")
print("- faturamento_por_filial.png")
print("- faturamento_por_linha_produto.png")
print("- formas_pagamento.png")
print("- vendas_por_dia_semana.png")
print("- avaliacao_por_linha_produto.png")
