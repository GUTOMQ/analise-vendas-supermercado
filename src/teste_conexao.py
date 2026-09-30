import os

import psycopg2
from dotenv import load_dotenv


# Carrega as variáveis do arquivo .env
load_dotenv()


def main():
    """Testa a conexão com o banco PostgreSQL."""

    try:
        conexao = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            database=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
        )

        print("=" * 60)
        print("CONEXÃO REALIZADA COM SUCESSO!")
        print("=" * 60)
        print(f"Banco de dados: {os.getenv('DB_NAME')}")
        print(f"Host: {os.getenv('DB_HOST')}")
        print(f"Porta: {os.getenv('DB_PORT')}")

        conexao.close()

        print("\nConexão encerrada.")

    except psycopg2.Error as erro:
        print("=" * 60)
        print("ERRO AO CONECTAR AO BANCO")
        print("=" * 60)
        print(erro)


if __name__ == "__main__":
    main()
