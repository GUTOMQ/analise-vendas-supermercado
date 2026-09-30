PROJETO desenvolvido para demonstração de conhecimentos em Python, SQL, PostgreSQL, ETL e análise de dados.

📊 Análise de Vendas de Supermercado

Projeto de análise de dados desenvolvido para demonstrar um fluxo completo de ETL, tratamento de dados, PostgreSQL, análise estatística e geração de indicadores de negócio com Python.

O projeto utiliza uma base de 1.000 registros de vendas e organiza os dados em diferentes camadas, desde a ingestão dos dados brutos até a geração de indicadores e visualizações.

🎯 Objetivo

O objetivo do projeto é construir um pipeline de dados capaz de:

carregar dados brutos de vendas;

armazenar os dados na camada Raw;

realizar limpeza e transformação com Python;

validar regras de negócio;

armazenar a base tratada no PostgreSQL;

criar uma camada Analytics;

responder perguntas de negócio;

gerar estatísticas descritivas;

criar gráficos para análise dos resultados.

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

VS Code

🏗️ Arquitetura do projeto

O fluxo de dados foi estruturado da seguinte forma:

CSV
 ↓
RAW
 ↓
ETL com Python
 ↓
TRATADO
 ↓
ANALYTICS
 ↓
Análise Estatística
 ↓
Resultados e Gráficos

Camadas

Raw

Armazena os dados recebidos da fonte original, preservando os valores sem transformações de negócio.

Tratado

Contém os dados limpos, tipados e validados pelo processo de ETL desenvolvido em Python.

Analytics

Contém tabelas agregadas utilizadas para responder perguntas de negócio e facilitar análises.

📁 Estrutura do projeto
.
├── data/
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
│   ├── 01_*.sql
│   ├── 02_*.sql
│   ├── 03_*.sql
│   └── 04_analytics.sql
│
├── src/
│   ├── 01_*.py
│   ├── 02_etl_vendas.py
│   └── 03_estatistica.py
│
├── .env
├── .gitignore
├── README.md
└── requirements.txt

Os nomes dos arquivos podem variar de acordo com a organização final do projeto.

🔄 Processo de ETL

O processo de ETL é realizado pelo arquivo:

src/02_etl_vendas.py

Etapas realizadas

Conexão com o PostgreSQL utilizando variáveis de ambiente.

Leitura dos dados da camada Raw.

Padronização dos nomes das colunas.

Limpeza de espaços nos campos de texto.

Conversão das colunas numéricas.

Conversão de data e hora.

Identificação de valores nulos.

Identificação e remoção de duplicidades.

Aplicação das regras de negócio.

Criação de colunas derivadas.

Arredondamento de valores monetários.

Validação final da base.

Exportação para CSV.

Carga da base tratada no PostgreSQL.

✅ Validações realizadas

Durante o processo de ETL foram realizadas as seguintes validações:

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
Registros recebidos: 1.000
Duplicidades encontradas: 0
Registros removidos por dados críticos: 0
Registros finais: 1.000

A base tratada possui 21 colunas.

🗄️ PostgreSQL

O projeto utiliza PostgreSQL para armazenamento e consulta dos dados.

Os principais schemas são:

raw
tratado
analytics

Tabela tratada
tratado.vendas

A tabela contém os dados tratados e tipados utilizados como fonte para a camada Analytics.

📊 Camada Analytics

A camada Analytics é criada pelo arquivo:

sql/04_analytics.sql

São criadas 13 tabelas analíticas:

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

A camada Analytics utiliza como fonte a tabela:

tratado.vendas

📈 Perguntas de negócio

O projeto responde perguntas como:

Qual filial apresentou o maior faturamento?

Qual filial realizou a maior quantidade de vendas?

Qual linha de produto apresentou o maior faturamento?

Qual linha de produto apresentou a melhor avaliação média?

Qual foi a forma de pagamento mais utilizada?

Qual foi o valor médio das vendas?

Qual foi a maior venda registrada?

Em qual dia da semana ocorreu a maior quantidade de vendas?

📊 Análise estatística

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

Também foram gerados gráficos para facilitar a interpretação dos resultados.

📌 Principais resultados

A análise realizada sobre os 1.000 registros apresentou os seguintes resultados:

Faturamento

Faturamento total da base tratada:

R$ 322.966,82

Quantidade de vendas
1.000 vendas

Unidades vendidas
5.510 unidades

Ticket médio
R$ 322,97

Maior venda
R$ 1.042,65

Forma de pagamento mais utilizada
Ewallet
345 vendas

Dia da semana com maior quantidade de vendas
sábado
164 vendas

📉 Visualizações

O projeto gera os seguintes gráficos:

faturamento por filial;

faturamento por linha de produto;

formas de pagamento;

vendas por dia da semana;

avaliação média por linha de produto.

Os arquivos são armazenados na pasta:

resultados/

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

com as configurações do PostgreSQL.

Exemplo:

DB_HOST=localhost
DB_PORT=5432
DB_NAME=supermercado_vendas
DB_USER=postgres
DB_PASSWORD=sua_senha

O arquivo .env não deve ser enviado para o GitHub.

4. Executar a estrutura SQL

Os scripts da pasta sql/ devem ser executados na ordem definida pelo projeto.

A execução pode ser realizada utilizando o PostgreSQL/pgAdmin.

5. Executar o ETL

Execute:

python src/02_etl_vendas.py

O processo irá gerar a base tratada:

data/processed/vendas_tratadas.csv

e carregar os dados na tabela:

tratado.vendas

6. Criar a camada Analytics

Execute:

sql/04_analytics.sql

A camada Analytics será criada no PostgreSQL.

7. Executar a análise estatística

Execute:

python src/03_estatistica.py

Os resultados serão armazenados na pasta:

resultados/

🔐 Segurança

Informações sensíveis de conexão são armazenadas em variáveis de ambiente.

O arquivo .env está incluído no .gitignore e não deve ser versionado.

📚 Objetivo do projeto

Este projeto foi desenvolvido como prática de:

Engenharia de Dados;

ETL;

SQL;

PostgreSQL;

análise exploratória de dados;

estatística descritiva;

visualização de dados;

organização de projetos Python;

criação de indicadores de negócio.

👤 Gustavo Machado Queiroga
