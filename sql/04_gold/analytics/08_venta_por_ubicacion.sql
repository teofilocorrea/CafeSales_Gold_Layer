-- ============================================================
-- Script : Análisis de comportamiento — Ventas por ubicación
-- Capa   : Gold
-- Objetivo: Comparar los ingresos según dónde se realiza la
--           venta (en tienda vs para llevar)
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 28 de agosto 2026
-- ============================================================

SELECT
    gdl.location_name    AS location,
    SUM(gfs.total_spent) AS total
FROM gold.fact_sales AS gfs
INNER JOIN gold.dim_location AS gdl
    ON gfs.location_id = gdl.id
WHERE gfs.record_status = 'active'
  AND gdl.location_name IN ('Takeaway', 'In-store')
GROUP BY gdl.location_name
ORDER BY total DESC;