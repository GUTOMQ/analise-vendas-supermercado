from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent

ARQUIVO_CSV = (
    BASE_DIR
    / "data"
    / "raw"
    / "supermarket_sales.csv"
)


def main():
    """Realiza leitura e inspeção inicial do CSV."""

    df = pd.read_csv(ARQUIVO_CSV)

    print("=" * 60)
    print("DIMENSÕES DO DATASET")
    print("=" * 60)
    print(f"Linhas: {df.shape[0]}")
    print(f"Colunas: {df.shape[1]}")

    print("\n" + "=" * 60)
    print("PRIMEIRAS LINHAS")
    print("=" * 60)
    print(df.head())

    print("\n" + "=" * 60)
    print("NOMES DAS COLUNAS")
    print("=" * 60)
    print(df.columns.tolist())

    print("\n" + "=" * 60)
    print("TIPOS DOS DADOS")
    print("=" * 60)
    print(df.dtypes)

    print("\n" + "=" * 60)
    print("VALORES AUSENTES")
    print("=" * 60)
    print(df.isnull().sum())

    print("\n" + "=" * 60)
    print("DUPLICIDADES")
    print("=" * 60)
    print(f"Registros duplicados: {df.duplicated().sum()}")

    print("\n" + "=" * 60)
    print("ESTATÍSTICAS INICIAIS")
    print("=" * 60)
    print(df.describe(include="all"))


if __name__ == "__main__":
    main()