📊 Análise de Vendas de Supermercado

Projeto desenvolvido para demonstrar conhecimentos em Python, Pandas, SQL, PostgreSQL, ETL, estatística descritiva, visualização de dados e controle de versão com Git e GitHub.

O projeto implementa um fluxo completo de análise de dados de vendas, desde a ingestão dos dados brutos até a geração de indicadores de negócio e visualizações.

A base utilizada possui 1.000 registros de vendas.

🎯 Objetivo

Construir um pipeline de dados capaz de:

carregar e preservar os dados brutos na camada Raw;

armazenar os dados no PostgreSQL;

realizar limpeza e transformação utilizando Python e Pandas;

converter corretamente os tipos de dados;

identificar valores ausentes e duplicidades;

aplicar regras de validação;

criar colunas derivadas;

armazenar a base tratada;

criar uma camada Analytics com indicadores de negócio;

realizar análise estatística descritiva;

responder perguntas de negócio;

gerar visualizações para facilitar a interpretação dos resultados.

📚 Fonte dos dados

Os dados utilizados são provenientes do dataset público Supermarket Sales, disponibilizado no Kaggle:

Supermarket Sales — Kaggle

https://www.kaggle.com/datasets/faresashraf1001/supermarket-sales

O arquivo original utilizado no projeto é:

data/raw/supermarket_sales.csv

A base possui 1.000 registros e 17 colunas originais.

🛠️ Tecnologias utilizadas

Python

Pandas

NumPy

Matplotlib

Seaborn

PostgreSQL

SQLAlchemy

psycopg2

python-dotenv

pgAdmin

Git

GitHub

🏗️ Arquitetura do projeto

O fluxo foi estruturado seguindo uma abordagem inspirada na Arquitetura Medallion, com separação entre dados brutos, dados tratados e dados analíticos.

CSV original
     │
     ▼
   RAW
     │
     ▼
Python / Pandas
     │
     ▼
  TRATADO
     │
     ├──────────────► data/processed/
     │
     ▼
 ANALYTICS
     │
     ▼
Análise estatística
     │
     ▼
Resultados e gráficos

Camada Raw

A camada Raw preserva os dados provenientes do CSV sem aplicar transformações de negócio.

Tabela:

raw.vendas

Os dados são inicialmente armazenados como texto para preservar a informação original.

Camada Staging

A camada Staging realiza a conversão inicial dos tipos de dados provenientes da Raw.

Schema:

staging

Essa camada permite separar a estrutura original dos dados das etapas posteriores de tratamento.

Camada Tratada

A camada Tratada contém os dados limpos, tipados e validados pelo processo de ETL desenvolvido em Python.

Tabela principal:

tratado.vendas

O processo também gera o arquivo:

data/processed/vendas_tratadas.csv

Camada Analytics

A camada Analytics contém tabelas agregadas utilizadas para responder perguntas de negócio e facilitar consultas analíticas.

Schema:

analytics

📁 Estrutura do projeto
.
├── data/
│   ├── raw/
│   │   └── supermarket_sales.csv
│   └── processed/
│       └── vendas_tratadas.csv
│
├── resultados/
│   ├── estatisticas_descritivas.csv
│   ├── faturamento_por_filial.png
│   ├── faturamento_por_linha_produto.png
│   ├── formas_pagamento.png
│   ├── vendas_por_dia_semana.png
│   └── avaliacao_por_linha_produto.png
│
├── sql/
│   ├── 01_criar_banco.sql
│   ├── 01_schemas.sql
│   ├── 02_criar_tabelas.sql
│   ├── 02_staging.sql
│   ├── 03_consultas.sql
│   └── 04_analytics.sql
│
├── src/
│   ├── 01_leitura_dados.py
│   ├── 02_etl_vendas.py
│   ├── 03_estatistica.py
│   ├── 03_validacao_tratada.py
│   ├── carga_raw.py
│   ├── config.py
│   └── teste_conexao.py
│
├── .gitignore
├── README.md
└── requirements.txt

O arquivo .env, utilizado para armazenar credenciais de acesso ao banco, é mantido fora do versionamento por questões de segurança.

🔄 Processo de ETL

O processo de ETL principal é realizado pelo arquivo:

src/02_etl_vendas.py

Etapas realizadas

Conexão com o PostgreSQL utilizando variáveis de ambiente.

Leitura dos dados da camada Raw.

Padronização dos nomes das colunas.

Limpeza dos campos de texto.

Conversão das colunas numéricas.

Conversão das colunas de data e hora.

Identificação de valores ausentes.

Identificação de duplicidades.

Tratamento dos valores ausentes.

Aplicação das regras de negócio.

Criação de colunas derivadas.

Validação da base final.

Exportação da base tratada para CSV.

Carga dos dados tratados no PostgreSQL.

✅ Validações realizadas

Foram aplicadas as seguintes regras de negócio:

preço unitário maior ou igual a zero;

quantidade maior que zero;

imposto maior ou igual a zero;

valor total maior ou igual a zero;

custo da mercadoria maior ou igual a zero;

receita bruta maior ou igual a zero;

avaliação entre 0 e 10;

verificação de valores nulos;

verificação de duplicidades;

validação de data e hora.

Resultado do tratamento
Indicador	Resultado
Registros recebidos	1.000
Duplicidades encontradas	0
Registros removidos por dados críticos	0
Registros finais	1.000
Colunas finais	21

A base tratada possui 21 colunas, incluindo colunas derivadas para análise temporal e cálculo do ticket médio por item.

🗄️ PostgreSQL

O projeto utiliza PostgreSQL como banco de dados principal.

Os principais schemas são:

raw
staging
tratado
analytics

Tabela Raw
raw.vendas

Armazena os dados originais sem transformação de negócio.

Tabela Tratada
tratado.vendas

Armazena os dados tratados e tipados utilizados nas análises.

A tabela possui chave primária para id_venda e restrições de integridade para validar regras do domínio.

📖 Dicionário de dados — camada Tratada
Coluna	Tipo	Descrição
id_venda	VARCHAR/TEXT	Identificador único da venda
filial	VARCHAR/TEXT	Filial responsável pela venda
cidade	VARCHAR/TEXT	Cidade da filial
tipo_cliente	VARCHAR/TEXT	Tipo do cliente
genero	VARCHAR/TEXT	Gênero informado no registro
linha_produto	VARCHAR/TEXT	Linha do produto
preco_unitario	NUMERIC	Preço unitário do produto
quantidade	INTEGER	Quantidade de produtos vendidos
imposto	NUMERIC	Imposto da venda
valor_total	NUMERIC	Valor total da venda
data_venda	DATE	Data da venda
hora_venda	TIME	Horário da venda
forma_pagamento	VARCHAR/TEXT	Forma de pagamento
custo_mercadoria	NUMERIC	Custo da mercadoria
margem_percentual	NUMERIC	Percentual de margem
receita_bruta	NUMERIC	Receita bruta
avaliacao	NUMERIC	Avaliação atribuída pelo cliente
dia_semana	VARCHAR/TEXT	Dia da semana da venda
mes_venda	INTEGER	Mês da venda
ano_venda	INTEGER	Ano da venda
ticket_medio_item	NUMERIC	Valor da venda dividido pela quantidade
📊 Camada Analytics

A camada Analytics é criada pelo arquivo:

sql/04_analytics.sql

São disponibilizadas as seguintes tabelas analíticas:

analytics.kpis_gerais
analytics.vendas_por_filial
analytics.vendas_por_produto
analytics.vendas_por_mes
analytics.vendas_por_pagamento
analytics.vendas_por_cliente
analytics.vendas_por_genero
analytics.vendas_por_cidade
analytics.vendas_por_dia_semana
analytics.avaliacao_por_produto
analytics.indicadores_impostos
analytics.receita_por_produto
analytics.maiores_vendas

A fonte principal dessas análises é:

tratado.vendas

📈 Perguntas de negócio

A análise responde às oito perguntas propostas na atividade.

1. Qual filial apresentou o maior faturamento?

Giza

Faturamento:

R$ 110.568,71

2. Qual filial realizou a maior quantidade de vendas?

Alex

Quantidade:

340 vendas

3. Qual linha de produto apresentou o maior faturamento?

Food and beverages

Faturamento:

R$ 56.144,86

4. Qual linha de produto recebeu a melhor avaliação média?

Food and beverages

Avaliação média:

7,11

5. Qual foi a forma de pagamento mais utilizada?

Ewallet

Quantidade:

345 vendas

6. Qual foi o valor médio das vendas?
   R$ 322,97
7. Qual foi a maior venda registrada?

ID da venda:

860-79-0874

Valor:

R$ 1.042,65

Filial:

Giza

Linha de produto:

Fashion accessories

8. Em qual dia da semana ocorreu a maior quantidade de vendas?

Sábado

Quantidade:

164 vendas

📊 Estatística descritiva

A análise estatística é realizada pelo arquivo:

src/03_estatistica.py

Foram calculadas estatísticas descritivas para:

preço unitário;

quantidade;

imposto;

valor total;

custo da mercadoria;

receita bruta;

avaliação.

Entre os principais indicadores:

Indicador	Resultado
Quantidade de vendas	1.000
Unidades vendidas	5.510
Faturamento total	R$ 322.966,82
Valor médio das vendas	R$ 322,97
Maior venda	R$ 1.042,65
Avaliação média	6,97
📉 Visualizações

O projeto gera os seguintes gráficos:

faturamento por filial;

faturamento por linha de produto;

formas de pagamento;

vendas por dia da semana;

avaliação média por linha de produto.

Os arquivos são armazenados em:

resultados/

Também é gerado o arquivo:

resultados/estatisticas_descritivas.csv

▶️ Como executar o projeto

1. Criar o ambiente virtual

No terminal:

python -m venv .venv

Ative o ambiente virtual.

No Windows:

.venv\Scripts\activate

2. Instalar as dependências
   pip install -r requirements.txt
3. Configurar as variáveis de ambiente

Crie um arquivo:

.env

com as configurações do PostgreSQL:

DB_HOST=localhost
DB_PORT=5432
DB_NAME=supermercado_vendas
DB_USER=postgres
DB_PASSWORD=sua_senha

O arquivo .env não deve ser enviado para o GitHub.

4. Criar o banco de dados

Execute o script:

sql/01_criar_banco.sql

O banco utilizado pelo projeto é:

supermercado_vendas

5. Criar os schemas

Execute:

sql/01_schemas.sql

6. Criar a tabela Raw

Execute:

sql/02_criar_tabelas.sql

7. Criar a camada Staging

Execute:

sql/02_staging.sql

8. Carregar os dados Raw

Utilize o script:

src/carga_raw.py

ou realize a importação utilizando o PostgreSQL/pgAdmin.

O arquivo original está em:

data/raw/supermarket_sales.csv

9. Executar as consultas SQL

O arquivo:

sql/03_consultas.sql

contém consultas de exploração, agregação, filtros, validações e indicadores.

10. Executar o processo de ETL
    python src/02_etl_vendas.py

O processo gera:

data/processed/vendas_tratadas.csv

e carrega os dados na tabela:

tratado.vendas

11. Criar a camada Analytics

Execute o conteúdo de:

sql/04_analytics.sql

no PostgreSQL/pgAdmin.

12. Executar a análise estatística
    python src/03_estatistica.py

Os resultados serão armazenados em:

resultados/

🔐 Segurança

As credenciais de acesso ao PostgreSQL são armazenadas em variáveis de ambiente.

O arquivo:

.env

está incluído no .gitignore e não deve ser versionado.

Nenhuma senha de acesso ao banco deve ser publicada no GitHub.

📌 Principais conhecimentos demonstrados

Este projeto demonstra conhecimentos em:

Python;

Pandas;

NumPy;

SQL;

PostgreSQL;

modelagem de dados;

constraints;

ETL;

tratamento de dados;

validação de dados;

estatística descritiva;

análise exploratória;

visualização de dados;

criação de indicadores;

organização de projetos;

Git;

GitHub.

👤 Autor:

Gustavo Machado Queiroga

Projeto desenvolvido como atividade avaliativa do curso de Análise de Dados com Python — Módulo 1.
