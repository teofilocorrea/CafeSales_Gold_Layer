# Gold Layer — CafeSales

## ¿Qué es esta capa?

La capa Gold es la capa analítica final de la arquitectura Medallion.
Toma los datos limpios de Silver y los transforma en un modelo
dimensional Star Schema, optimizado para responder preguntas de
negocio sobre ventas, tiempo y comportamiento de compra.

---

## 📋 Reglas de esta capa

- Modelo dimensional Star Schema puro
- Las dimensiones NO se conectan entre sí
- Solo la fact table tiene FK hacia las dimensiones
- Los valores NULL de Silver se convierten a 'Unknown' en las dimensiones
- `record_status` se mantiene en la fact como bandera de calidad
- Las medidas permiten NULL (registros incompletos existen)
- Datos cargados con ETL desde Silver (Surrogate Key Lookup)

---

## 🌟 Modelo Star Schema

```
              gold.dim_item
                    │
gold.dim_payment ───┼─── gold.dim_location
                    │
             gold.fact_sales
                    │
              gold.dim_date
```


**Star Schema puro:** 4 dimensiones + 1 fact table. Las dimensiones
son catálogos de valores únicos; la fact registra cada transacción
con FK hacia las dimensiones y las medidas de la venta.

---

## 📊 Tablas de la capa

| Tabla | Tipo | Descripción |
|---|---|---|
| `gold.dim_item` | Dimensión | Productos vendidos |
| `gold.dim_location` | Dimensión | Ubicaciones de venta |
| `gold.dim_payment` | Dimensión | Métodos de pago |
| `gold.dim_date` | Dimensión | Fechas desglosadas (día, mes, trimestre, año) |
| `gold.fact_sales` | Hechos | Cada transacción de venta |

---

## 🔑 Conceptos clave aplicados

| Concepto | Descripción |
|---|---|
| Star Schema | Modelo dimensional con la fact en el centro |
| Dimensión vs Fact | Catálogo único (dimensión) vs eventos repetidos (fact) |
| `COALESCE` | Convertir NULL a 'Unknown' en las dimensiones |
| `EXTRACT` | Desglosar fechas en día, mes, trimestre, año |
| Surrogate Key Lookup | Traducir nombres de Silver a IDs de Gold vía JOIN |
| FK modular | Foreign keys agregadas con ALTER TABLE |

---

## 🔄 Proceso de carga — el ETL

El orden de carga respeta las dependencias del modelo:

```
1.Cargar las 4 dimensiones (INSERT SELECT desde Silver)
↓
2.Cargar la fact table (ETL con JOINs a las dimensiones)
```

### Las dimensiones — COALESCE para los NULL

```sql
INSERT INTO gold.dim_item (item_name)
SELECT DISTINCT COALESCE(item, 'Unknown')
FROM silver.sales;
```

### La fact — Surrogate Key Lookup

La fact combina Silver con las 4 dimensiones para traducir cada
nombre a su ID de Gold. Las ventas sin fecha se excluyen del modelo:

```sql
INSERT INTO gold.fact_sales (
    item_id, location_id, payment_id, date_id,
    quantity, price_per_unit, total_spent, record_status
)
SELECT
    di.id, dl.id, dp.id, dd.id,
    s.quantity, s.price_per_unit, s.total_spent, s.record_status
FROM silver.sales AS s
INNER JOIN gold.dim_item AS di
    ON COALESCE(s.item, 'Unknown') = di.item_name
INNER JOIN gold.dim_location AS dl
    ON COALESCE(s.location, 'Unknown') = dl.location_name
INNER JOIN gold.dim_payment AS dp
    ON COALESCE(s.payment_method, 'Unknown') = dp.payment_method
INNER JOIN gold.dim_date AS dd
    ON s.transaction_date = dd.full_date
WHERE s.transaction_date IS NOT NULL;
```

---

## 📈 Análisis de negocio

Las consultas de la carpeta `analytics/` responden tres perspectivas:

| Perspectiva | Preguntas que responde |
|---|---|
| Ventas | Productos top, ingresos, ticket promedio |
| Temporal | Ventas por mes, por día, tendencia mensual |
| Comportamiento | Método de pago preferido, ventas por ubicación |

Todas filtran `record_status = 'active'` para excluir los registros
incompletos de los cálculos de ingresos.

---

## 🗂️ Estructura de archivos

```
04_gold/
├── star_schema_design.md
├── data_dictionary_gold.md
├── create_tables/
│ ├── 01_create_dim_item.sql
│ ├── 02_create_dim_location.sql
│ ├── 03_create_dim_payment.sql
│ ├── 04_create_dim_date.sql
│ └── 05_create_fact_sales.sql
├── add_constraints/
│ └── 01_add_fk_gold.sql
├── insert_data/
│ ├── 01_insert_dim_item.sql
│ ├── 02_insert_dim_location.sql
│ ├── 03_insert_dim_payment.sql
│ ├── 04_insert_dim_date.sql
│ └── 05_insert_fact_sales.sql
├── analytics/
│ ├── 01_ventas/
│ ├── 02_temporal/
│ └── 03_comportamiento/
├── README.md
└── data_dictionary_gold.md
```

---

## 🔗 Convención de nombres para constraints

| Tipo | Prefijo | Ejemplo |
|---|---|---|
| PRIMARY KEY | `pk_` | `pk_dim_item` |
| FOREIGN KEY | `fk_` | `fk_fact_sales_item` |

---

## 🔗 Capas relacionadas

| Capa | Descripción |
|---|---|
| ⬆️ Silver | Origen de los datos — datos limpios y validados |
| ➡️ **Gold** | Estás aquí — modelo dimensional y análisis |