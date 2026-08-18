-- ============================================================
-- Tabla: gold.dim_item
-- Descripción: Dimensión de productos. Almacena cada producto
--              único vendido en la cafetería.
-- Capa: Gold
-- Autor: Teofilo Correa Rojas
-- Fecha: 11 de agosto 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.dim_item (

    id          SERIAL,
    item_name   VARCHAR(100) NOT NULL,

    -- Constraints
    CONSTRAINT pk_dim_item PRIMARY KEY (id)

);