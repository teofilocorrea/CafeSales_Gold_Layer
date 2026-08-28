-- ============================================================
-- Script : Análisis temporal — Ventas totales por mes
-- Capa   : Gold
-- Objetivo: Ver la evolución mensual de los ingresos
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 26 de agosto 2026
-- ============================================================

SELECT
    gdd.month                           AS mes,
    SUM(gfs.total_spent)                AS ventas
FROM gold.fact_sales                    AS gfs
INNER JOIN gold.dim_date                AS gdd
ON gfs.date_id = gdd.id
WHERE gfs.record_status = 'active'
GROUP BY mes
ORDER BY mes;