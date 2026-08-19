-- ============================================================
-- Tabla: gold.fact_sales
-- Descripción: Tabla de hechos. Cada registro es una transacción
--              de venta, con FK a las dimensiones, las medidas y
--              la bandera record_status.
-- Capa: Gold
-- Autor: Teofilo Correa Rojas
-- Fecha: 19 de agosto 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.fact_sales (

    id              SERIAL,
    item_id         INTEGER NOT NULL,
    location_id     INTEGER NOT NULL,
    payment_id      INTEGER NOT NULL,
    date_id         INTEGER NOT NULL,
    quantity        INTEGER,
    price_per_unit  NUMERIC(10,2),
    total_spent     NUMERIC(10,2),
    record_status   VARCHAR(20) NOT NULL,

    -- Constraint
    CONSTRAINT pk_fact_sales PRIMARY KEY (id)

);