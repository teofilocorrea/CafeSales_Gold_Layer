-- ============================================================
-- Script : Análisis de ventas — Unidades vendidas por producto
-- Capa   : Gold
-- Objetivo: Identificar qué productos mueven más volumen
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 25 de agosto 2026
-- ============================================================

SELECT
    gdi.item_name     AS producto,
    SUM(gfs.quantity) AS unidades_vendidas
FROM gold.fact_sales AS gfs
INNER JOIN gold.dim_item AS gdi
    ON gfs.item_id = gdi.id
WHERE gfs.record_status = 'active'
GROUP BY gdi.item_name
ORDER BY unidades_vendidas DESC
LIMIT 5;