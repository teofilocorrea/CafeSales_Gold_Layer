-- ============================================================
-- Script : Análisis de ventas — Top productos por ingresos
-- Capa   : Gold
-- Objetivo: Identificar los 5 productos que más ingresos generan
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 25 de agosto 2026
-- ============================================================

SELECT
    gdi.item_name        AS producto,
    SUM(gfs.total_spent) AS total_ingresos
FROM gold.fact_sales AS gfs
INNER JOIN gold.dim_item AS gdi
    ON gfs.item_id = gdi.id
WHERE gfs.record_status = 'active'
GROUP BY gdi.item_name
ORDER BY total_ingresos DESC
LIMIT 5;