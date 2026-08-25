-- ============================================================
-- Script : Análisis de ventas — Ticket promedio por producto
-- Capa   : Gold
-- Objetivo: Calcular el gasto promedio por venta de cada producto
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 25 de agosto 2026
-- ============================================================

SELECT
    gdi.item_name                  AS producto,
    ROUND(AVG(gfs.total_spent), 2) AS ticket_promedio
FROM gold.fact_sales AS gfs
INNER JOIN gold.dim_item AS gdi
    ON gfs.item_id = gdi.id
WHERE gfs.record_status = 'active'
GROUP BY gdi.item_name
ORDER BY ticket_promedio DESC
LIMIT 5;