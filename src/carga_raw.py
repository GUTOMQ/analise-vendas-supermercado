from pathlib import Path

import pandas as pd

from config import get_engine


BASE_DIR = Path(__file__).resolve().parent.parent
CSV_PATH = BASE_DIR / "data" / "raw" / "supermarket_sales.csv"


def carregar_raw():
    """Carrega o CSV original para a tabela raw.vendas."""

    print(f"Lendo arquivo: {CSV_PATH}")
    print(f"Arquivo existe: {CSV_PATH.exists()}")

    df = pd.read_csv(CSV_PATH, dtype=str)

    print(f"CSV carregado: {len(df)} registros")
    print(f"Colunas encontradas: {list(df.columns)}")

    engine = get_engine()

    df.to_sql(
        name="vendas",
        con=engine,
        schema="raw",
        if_exists="append",
        index=False,
    )

    print(f"{len(df)} registros carregados na camada Raw.")


if __name__ == "__main__":
    carregar_raw()
