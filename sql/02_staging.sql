-- ============================================================
-- PROJETO: SUPERMARKET SALES
-- ARQUIVO: 03_staging.sql
-- DESCRIÇÃO: Criação da camada Staging
-- ============================================================

DROP TABLE IF EXISTS staging.vendas;

CREATE TABLE staging.vendas AS
SELECT
    "Invoice ID",
    "Branch",
    "City",
    "Customer type",
    "Gender",
    "Product line",

    CAST("Unit price" AS NUMERIC(10,2)) AS "Unit price",

    CAST("Quantity" AS INTEGER) AS "Quantity",

    CAST("Tax 5%" AS NUMERIC(10,2)) AS "Tax 5%",

    CAST("Sales" AS NUMERIC(12,2)) AS "Sales",

    TO_DATE("Date", 'MM/DD/YYYY') AS "Date",

    CAST("Time" AS TIME) AS "Time",

    "Payment",

    CAST("cogs" AS NUMERIC(12,2)) AS "cogs",

    CAST(
        "gross margin percentage"
        AS NUMERIC(10,2)
    ) AS "gross margin percentage",

    CAST(
        "gross income"
        AS NUMERIC(12,2)
    ) AS "gross income",

    CAST("Rating" AS NUMERIC(3,1)) AS "Rating"

FROM raw.vendas;
