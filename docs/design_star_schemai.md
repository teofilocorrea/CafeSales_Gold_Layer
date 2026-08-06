# Diseño del Modelo Dimensional — Gold Layer

## Objetivo
Transformar los datos limpios de `silver.sales` en un modelo dimensional
Star Schema que permita análisis de ventas, temporal y de comportamiento
de compra.

## Enfoque
Star Schema con 4 dimensiones y 1 tabla de hechos. Aunque el dataset es
una sola entidad (transacciones de venta), se separan las dimensiones
para demostrar un modelo dimensional completo y habilitar análisis
multi-perspectiva.

---

## Las 4 dimensiones

| Dimensión | ¿Qué describe? | Origen en Silver |
|---|---|---|
| `dim_item` | El producto vendido | `item` |
| `dim_location` | Dónde se realizó la venta | `location` |
| `dim_payment` | Cómo se pagó | `payment_method` |
| `dim_date` | Cuándo se realizó la venta | `transaction_date` |

## La tabla de hechos

| Tabla | ¿Qué mide? | Origen en Silver |
|---|---|---|
| `fact_sales` | Cada transacción de venta | toda la fila de silver.sales |

---

## Reparto de campos

```
silver.sales
│
├── item → dim_item (como FK item_id en fact)
├── location → dim_location (como FK location_id)
├── payment_method → dim_payment (como FK payment_id)
├── transaction_date → dim_date (como FK date_id)
│
├── quantity → fact_sales (medida)
├── price_per_unit → fact_sales (medida)
├── total_spent → fact_sales (medida)
└── record_status → fact_sales (bandera de calidad)
```

---

## Decisiones de diseño

### 1. Manejo de valores NULL — categoría "Unknown"
Los campos que quedaron NULL en Silver (item, location, payment_method)
se convierten a un registro `'Unknown'` en cada dimensión durante el ETL,
usando `COALESCE`. Así ninguna FK queda en NULL y los valores faltantes
se pueden analizar como una categoría más.

### 2. record_status llega hasta la fact
La bandera `record_status` se mantiene en `fact_sales`. Los análisis de
ingresos filtran `WHERE record_status = 'active'` para no sumar ventas
sin monto; los análisis de volumen (unidades) cuentan todos los registros.

### 3. dim_date con desglose temporal
La dimensión de fecha usa `EXTRACT` para desglosar cada fecha en día,
mes, trimestre y año, habilitando análisis temporal en distintos niveles.

---

## Relaciones (Star Schema)

```
          dim_item
             │
dim_payment──┼──dim_location
│
fact_sales
│
dim_date
```

- Las dimensiones NO se conectan entre sí (Star Schema puro)
- Solo `fact_sales` tiene FK hacia las 4 dimensiones
- Cada FK conecta una medida de venta con su contexto descriptivo

---

## Relaciones formales — FK

| Tabla origen | Campo | Tabla destino |
|---|---|---|
| `fact_sales` | `item_id` | `dim_item` |
| `fact_sales` | `location_id` | `dim_location` |
| `fact_sales` | `payment_id` | `dim_payment` |
| `fact_sales` | `date_id` | `dim_date` |