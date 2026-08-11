-- ============================================================
-- Tabla: gold.dim_payment
-- Descripción: Dimensión de métodos de pago. Almacena cómo se
--              pagó la venta (Cash, Credit Card, Digital, Unknown).
-- Capa: Gold
-- Autor: Teofilo Correa Rojas
-- Fecha: 11 de agosto 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.dim_payment (

    id               SERIAL,
    payment_method   VARCHAR(50) NOT NULL,

    -- Constraint
    CONSTRAINT pk_dim_payment PRIMARY KEY (id)

);