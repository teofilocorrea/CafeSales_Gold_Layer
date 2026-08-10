# Diccionario de Datos — Gold Layer

## Propósito de la capa
Capa analítica final con modelo dimensional Star Schema. Los datos vienen
de `silver.sales` y se transforman en 4 dimensiones y una tabla de hechos
optimizadas para análisis de ventas, temporal y de comportamiento.

## Reglas generales de la capa
- Modelo dimensional Star Schema puro
- Las dimensiones NO se conectan entre sí
- Solo `fact_sales` tiene FK hacia las dimensiones
- Los valores NULL de Silver se convierten a 'Unknown' en las dimensiones
- `record_status` se mantiene en la fact como bandera de calidad
- Datos cargados con ETL desde Silver

## Tipo de tablas

| Tipo | Descripción | Tablas |
|---|---|---|
| Dimensión | Atributos descriptivos (cualitativo) | dim_item, dim_location, dim_payment, dim_date |
| Hechos | Eventos y medidas (cuantitativo) | fact_sales |

---

## Tabla: gold.dim_item

### Descripción
Dimensión que almacena cada producto único vendido en la cafetería.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| `id` | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| `item_name` | Nombre del producto | VARCHAR(100) | NOT NULL | silver.sales (COALESCE → 'Unknown') |

---

## Tabla: gold.dim_location

### Descripción
Dimensión que almacena las ubicaciones donde se realizó la venta.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| `id` | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| `location_name` | Ubicación de la venta (In-store, Takeaway) | VARCHAR(50) | NOT NULL | silver.sales (COALESCE → 'Unknown') |

---

## Tabla: gold.dim_payment

### Descripción
Dimensión que almacena los métodos de pago utilizados.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| `id` | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| `payment_method` | Método de pago (Cash, Credit Card, Digital) | VARCHAR(50) | NOT NULL | silver.sales (COALESCE → 'Unknown') |

---

## Tabla: gold.dim_date

### Descripción
Dimensión de tiempo que desglosa las fechas de las transacciones en
componentes para análisis temporal. Se construye extrayendo las fechas
únicas de silver.sales.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| `id` | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| `full_date` | Fecha completa | DATE | NOT NULL | silver.sales (fecha única) |
| `day` | Día del mes | INTEGER | NOT NULL | EXTRACT(DAY) |
| `month` | Número del mes | INTEGER | NOT NULL | EXTRACT(MONTH) |
| `quarter` | Trimestre del año | INTEGER | NOT NULL | EXTRACT(QUARTER) |
| `year` | Año | INTEGER | NOT NULL | EXTRACT(YEAR) |

---

## Tabla: gold.fact_sales

### Descripción
Tabla de hechos central del modelo. Cada registro representa una
transacción de venta. Combina las claves de las dimensiones con las
medidas cuantitativas y la bandera de calidad del registro.

### Campos

| Campo | ¿Qué guarda? | Tipo | Tipo de campo | Constraint | Origen |
|---|---|---|---|---|---|
| `id` | Identificador único del hecho | SERIAL | PK | PRIMARY KEY | autogenerado |
| `item_id` | Referencia al producto | INTEGER | FK | NOT NULL + FK | dim_item (vía nombre) |
| `location_id` | Referencia a la ubicación | INTEGER | FK | NOT NULL + FK | dim_location (vía nombre) |
| `payment_id` | Referencia al método de pago | INTEGER | FK | NOT NULL + FK | dim_payment (vía nombre) |
| `date_id` | Referencia a la fecha | INTEGER | FK | NOT NULL + FK | dim_date (vía fecha) |
| `quantity` | Unidades vendidas | INTEGER | Medida | — (permite NULL) | silver.sales |
| `price_per_unit` | Precio unitario | NUMERIC(10,2) | Medida | — (permite NULL) | silver.sales |
| `total_spent` | Monto total de la venta | NUMERIC(10,2) | Medida | — (permite NULL) | silver.sales |
| `record_status` | Estado del registro (active/incomplete) | VARCHAR(20) | Bandera | NOT NULL | silver.sales |

---

## Relaciones — FK de la Fact Table

| Tabla origen | Campo | Tabla destino | Constraint |
|---|---|---|---|
| `gold.fact_sales` | `item_id` | `gold.dim_item` | `fk_fact_sales_item` |
| `gold.fact_sales` | `location_id` | `gold.dim_location` | `fk_fact_sales_location` |
| `gold.fact_sales` | `payment_id` | `gold.dim_payment` | `fk_fact_sales_payment` |
| `gold.fact_sales` | `date_id` | `gold.dim_date` | `fk_fact_sales_date` |

---

## Star Schema# Diccionario de Datos — Gold Layer

## Propósito de la capa
Capa analítica final con modelo dimensional Star Schema. Los datos vienen
de `silver.sales` y se transforman en 4 dimensiones y una tabla de hechos
optimizadas para análisis de ventas, temporal y de comportamiento.

## Reglas generales de la capa
- Modelo dimensional Star Schema puro
- Las dimensiones NO se conectan entre sí
- Solo `fact_sales` tiene FK hacia las dimensiones
- Los valores NULL de Silver se convierten a 'Unknown' en las dimensiones
- `record_status` se mantiene en la fact como bandera de calidad
- Datos cargados con ETL desde Silver

## Tipo de tablas

| Tipo | Descripción | Tablas |
|---|---|---|
| Dimensión | Atributos descriptivos (cualitativo) | dim_item, dim_location, dim_payment, dim_date |
| Hechos | Eventos y medidas (cuantitativo) | fact_sales |

---

## Tabla: gold.dim_item

### Descripción
Dimensión que almacena cada producto único vendido en la cafetería.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| `id` | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| `item_name` | Nombre del producto | VARCHAR(100) | NOT NULL | silver.sales (COALESCE → 'Unknown') |

---

## Tabla: gold.dim_location

### Descripción
Dimensión que almacena las ubicaciones donde se realizó la venta.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| `id` | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| `location_name` | Ubicación de la venta (In-store, Takeaway) | VARCHAR(50) | NOT NULL | silver.sales (COALESCE → 'Unknown') |

---

## Tabla: gold.dim_payment

### Descripción
Dimensión que almacena los métodos de pago utilizados.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| `id` | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| `payment_method` | Método de pago (Cash, Credit Card, Digital) | VARCHAR(50) | NOT NULL | silver.sales (COALESCE → 'Unknown') |

---

## Tabla: gold.dim_date

### Descripción
Dimensión de tiempo que desglosa las fechas de las transacciones en
componentes para análisis temporal. Se construye extrayendo las fechas
únicas de silver.sales.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| `id` | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| `full_date` | Fecha completa | DATE | NOT NULL | silver.sales (fecha única) |
| `day` | Día del mes | INTEGER | NOT NULL | EXTRACT(DAY) |
| `month` | Número del mes | INTEGER | NOT NULL | EXTRACT(MONTH) |
| `quarter` | Trimestre del año | INTEGER | NOT NULL | EXTRACT(QUARTER) |
| `year` | Año | INTEGER | NOT NULL | EXTRACT(YEAR) |

---

## Tabla: gold.fact_sales

### Descripción
Tabla de hechos central del modelo. Cada registro representa una
transacción de venta. Combina las claves de las dimensiones con las
medidas cuantitativas y la bandera de calidad del registro.

### Campos

| Campo | ¿Qué guarda? | Tipo | Tipo de campo | Constraint | Origen |
|---|---|---|---|---|---|
| `id` | Identificador único del hecho | SERIAL | PK | PRIMARY KEY | autogenerado |
| `item_id` | Referencia al producto | INTEGER | FK | NOT NULL + FK | dim_item (vía nombre) |
| `location_id` | Referencia a la ubicación | INTEGER | FK | NOT NULL + FK | dim_location (vía nombre) |
| `payment_id` | Referencia al método de pago | INTEGER | FK | NOT NULL + FK | dim_payment (vía nombre) |
| `date_id` | Referencia a la fecha | INTEGER | FK | NOT NULL + FK | dim_date (vía fecha) |
| `quantity` | Unidades vendidas | INTEGER | Medida | — (permite NULL) | silver.sales |
| `price_per_unit` | Precio unitario | NUMERIC(10,2) | Medida | — (permite NULL) | silver.sales |
| `total_spent` | Monto total de la venta | NUMERIC(10,2) | Medida | — (permite NULL) | silver.sales |
| `record_status` | Estado del registro (active/incomplete) | VARCHAR(20) | Bandera | NOT NULL | silver.sales |

---

## Relaciones — FK de la Fact Table

| Tabla origen | Campo | Tabla destino | Constraint |
|---|---|---|---|
| `gold.fact_sales` | `item_id` | `gold.dim_item` | `fk_fact_sales_item` |
| `gold.fact_sales` | `location_id` | `gold.dim_location` | `fk_fact_sales_location` |
| `gold.fact_sales` | `payment_id` | `gold.dim_payment` | `fk_fact_sales_payment` |
| `gold.fact_sales` | `date_id` | `gold.dim_date` | `fk_fact_sales_date` |

---

## Star Schema

```
             gold.dim_item
                    │
gold.dim_payment ───┼─── gold.dim_location
│
gold.fact_sales
│
gold.dim_date
```

---

## Convención de nombres para constraints

| Tipo | Prefijo | Ejemplo |
|---|---|---|
| PRIMARY KEY | `pk_` | `pk_dim_item` |
| FOREIGN KEY | `fk_` | `fk_fact_sales_item` |