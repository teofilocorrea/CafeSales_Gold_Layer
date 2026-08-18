-- ============================================================
-- Tabla: gold.dim_location
-- Descripción: Dimensión de ubicaciones. Almacena dónde se
--              realizó la venta (In-store, Takeaway, Unknown).
-- Capa: Gold
-- Autor: Teofilo Correa Rojas
-- Fecha: 11 de agosto 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.dim_location (

    id              SERIAL,
    location_name   VARCHAR(50) NOT NULL,

    -- Constraint
    CONSTRAINT pk_dim_location PRIMARY KEY (id)

);