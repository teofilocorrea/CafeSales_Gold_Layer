-- ============================================================
-- Script : Análisis de comportamiento — Metodo de pago preferido
-- Capa   : Gold
-- Objetivo: Identificar qué metodo de pago genera más ventas
--           para entender la preferencia de los clientes
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 28 de agosto 2026
-- ============================================================

SELECT
    gdp.payment_method   AS metodo_pago,
    SUM(gfs.total_spent) AS total
FROM gold.fact_sales AS gfs
INNER JOIN gold.dim_payment AS gdp
    ON gfs.payment_id = gdp.id
WHERE gfs.record_status = 'active'
  AND gdp.payment_method IN ('Digital Wallet', 'Credit Card', 'Cash')
GROUP BY gdp.payment_method
ORDER BY total DESC;

