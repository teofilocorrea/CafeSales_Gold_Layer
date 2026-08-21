-- ============================================================
-- Script : ETL — Silver → Gold | fact_sales
-- Tabla  : gold.fact_sales
-- Origen : silver.sales + las 4 dimensiones
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 21 de agosto 2026
-- ============================================================

INSERT INTO gold.fact_sales (
    item_id, location_id, payment_id, date_id,
    quantity, price_per_unit, total_spent, record_status
)
SELECT
    di.id,                    -- item_id (traducido)
    dl.id,                    -- location_id (traducido)
    dp.id,                    -- payment_id (traducido)
    dd.id,                    -- date_id (traducido)
    s.quantity,               -- medida (directa)
    s.price_per_unit,         -- medida (directa)
    s.total_spent,            -- medida (directa)
    s.record_status           -- bandera (directa)
FROM silver.sales AS s

INNER JOIN gold.dim_item AS di
    ON COALESCE(s.item, 'Unknown') = di.item_name

INNER JOIN gold.dim_location AS dl
    ON COALESCE(s.location, 'Unknown') = dl.location_name

INNER JOIN gold.dim_payment AS dp
    ON COALESCE(s.payment_method, 'Unknown') = dp.payment_method

INNER JOIN gold.dim_date AS dd
    ON s.transaction_date = dd.full_date

WHERE s.transaction_date IS NOT NULL;