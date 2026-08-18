-- ============================================================
-- Script : ETL — Silver → Gold | dim_payment
-- Tabla  : gold.dim_payment
-- Origen : silver.sales
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 18 de agosto 2026
-- ============================================================

-- Ensayo — verificar el resultado antes de insertar
SELECT DISTINCT COALESCE(payment_method, 'Unknown')
FROM silver.sales;

-- ETL — cargar los métodos de pago únicos en la dimensión
INSERT INTO gold.dim_payment (payment_method)
SELECT DISTINCT COALESCE(payment_method, 'Unknown')
FROM silver.sales;