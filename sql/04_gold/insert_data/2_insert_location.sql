-- ============================================================
-- Script : ETL — Silver → Gold | dim_location
-- Tabla  : gold.dim_location
-- Origen : silver.sales
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 18 de agosto 2026
-- ============================================================

-- Ensayo — verificar el resultado antes de insertar
SELECT DISTINCT COALESCE(location, 'Unknown')
FROM silver.sales;

-- ETL — cargar las localizaciones únicas en la dimensión
INSERT INTO gold.dim_location (location_name)
SELECT DISTINCT COALESCE(location, 'Unknown')
FROM silver.sales;