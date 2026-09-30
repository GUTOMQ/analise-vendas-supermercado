import os
from pathlib import Path

from dotenv import load_dotenv
from sqlalchemy import create_engine


BASE_DIR = Path(__file__).resolve().parent.parent
ENV_FILE = BASE_DIR / ".env"

load_dotenv(ENV_FILE)


DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")


print("Arquivo .env:", ENV_FILE)
print(".env existe:", ENV_FILE.exists())
print("DB_HOST:", DB_HOST)
print("DB_PORT:", DB_PORT)
print("DB_NAME:", DB_NAME)
print("DB_USER:", DB_USER)
print("Senha carregada:", DB_PASSWORD is not None)
print("Tamanho da senha:", len(DB_PASSWORD) if DB_PASSWORD else 0)


def get_engine():
    """Retorna uma conexão SQLAlchemy com o PostgreSQL."""

    return create_engine(
        "postgresql+psycopg2://",
        connect_args={
            "host": DB_HOST,
            "port": DB_PORT,
            "dbname": DB_NAME,
            "user": DB_USER,
            "password": DB_PASSWORD,
        },
    )
