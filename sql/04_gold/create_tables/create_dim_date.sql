-- ============================================================
-- Tabla: gold.dim_date
-- Descripción: Dimensión de tiempo. Desglosa cada fecha de
--              transacción en día, mes, trimestre y año para
--              análisis temporal.
-- Capa: Gold
-- Autor: Teofilo Correa Rojas
-- Fecha: 13 de agosto 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.dim_date (

    id          SERIAL,
    full_date   DATE    NOT NULL,
    day         INTEGER NOT NULL,
    month       INTEGER NOT NULL,
    quarter     INTEGER NOT NULL,
    year        INTEGER NOT NULL,

    -- Constraint
    CONSTRAINT pk_dim_date PRIMARY KEY (id)

);