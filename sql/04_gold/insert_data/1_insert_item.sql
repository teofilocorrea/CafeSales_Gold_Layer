-- ============================================================
-- Script : ETL — Silver → Gold | dim_item
-- Tabla  : gold.dim_item
-- Origen : silver.sales
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 17 de agosto 2026
-- ============================================================

-- Ensayo — verificar el resultado antes de insertar
SELECT DISTINCT COALESCE(item, 'Unknown')
FROM silver.sales;

-- ETL — cargar los productos únicos en la dimensión
INSERT INTO gold.dim_item (item_name)
SELECT DISTINCT COALESCE(item, 'Unknown')
FROM silver.sales;