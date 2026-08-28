-- ============================================================
-- Script : Análisis temporal — Ventas por producto y mes
-- Capa   : Gold
-- Objetivo: Detallar cuánto vendió cada producto en cada mes
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 25 de agosto 2026
-- ============================================================

SELECT gdi.item_name                AS productos,
       SUM(gfs.total_spent)         AS ventas,
       gdd.month                    AS meses
FROM gold.fact_sales                AS gfs
INNER JOIN gold.dim_item            AS gdi
ON gfs.item_id = gdi.id
INNER JOIN gold.dim_date            AS gdd
ON gfs.date_id = gdd.id
WHERE gfs.record_status = 'active'
GROUP BY meses, productos
ORDER BY meses DESC;