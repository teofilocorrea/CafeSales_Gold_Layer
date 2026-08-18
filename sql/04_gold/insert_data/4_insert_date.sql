-- ============================================================
-- Script : ETL — Silver → Gold | dim_date
-- Tabla  : gold.dim_date
-- Origen : silver.sales
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 18 de agosto 2026
-- ============================================================

-- Ensayo — verificar el resultado antes de insertar
SELECT DISTINCT
    transaction_date,
    EXTRACT(DAY FROM transaction_date),
    EXTRACT(MONTH FROM transaction_date),
    EXTRACT(QUARTER FROM transaction_date),
    EXTRACT(YEAR FROM transaction_date)
FROM silver.sales
WHERE transaction_date IS NOT NULL;

-- ETL — cargar las fechas únicas desglosadas en la dimensión
INSERT INTO gold.dim_date (full_date, day, month, quarter, year)
SELECT DISTINCT
    transaction_date,
    EXTRACT(DAY FROM transaction_date),
    EXTRACT(MONTH FROM transaction_date),
    EXTRACT(QUARTER FROM transaction_date),
    EXTRACT(YEAR FROM transaction_date)
FROM silver.sales
WHERE transaction_date IS NOT NULL;