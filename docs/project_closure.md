# Project Closure — CafeSales Gold Layer

## 📋 Información del proyecto

| Campo | Detalle |
|---|---|
| **Proyecto** | CafeSales Gold Layer |
| **Fase** | 5 de 5 — Capa Gold (fase final) |
| **Autor** | Teófilo Correa Rojas |
| **Fecha inicio** | Agosto 2026 |
| **Fecha cierre** | Agosto 2026 |
| **Estado** | ✅ Completado |

---

## 🎯 Objetivos — ¿Se cumplieron?

| Objetivo | Estado |
|---|---|
| Diseñar el modelo dimensional Star Schema | ✅ Completado |
| Crear las 4 dimensiones y la fact table | ✅ Completado |
| Manejar los NULL como categoría 'Unknown' | ✅ Completado |
| Construir dim_date con desglose temporal (EXTRACT) | ✅ Completado |
| Implementar el ETL con Surrogate Key Lookup | ✅ Completado |
| Responder preguntas de negocio (3 perspectivas) | ✅ Completado |

---

## 🧱 Lo que se construyó

### El modelo dimensional

| Tabla | Tipo | Descripción |
|---|---|---|
| `dim_item` | Dimensión | Productos únicos |
| `dim_location` | Dimensión | Ubicaciones de venta |
| `dim_payment` | Dimensión | Métodos de pago |
| `dim_date` | Dimensión | Fechas desglosadas |
| `fact_sales` | Hechos | Transacciones de venta |

### Registros cargados

| Tabla | Registros |
|---|---|
| `fact_sales` | (completar: ~9,540 — 10,000 menos las sin fecha) |

> Las ~460 ventas sin fecha se excluyeron del modelo, ya que
> dim_date solo contiene fechas reales (no se puede desglosar
> una fecha inexistente).

---

## 📊 Hallazgos de negocio

Los análisis de la capa Gold respondieron tres perspectivas.
(Completar con los resultados reales de tus consultas.)

### Ventas por producto

| Métrica | Resultado |
|---|---|
| Producto de mayor ingreso | (completar) |
| Producto de mayor volumen | (completar) |
| Ticket promedio más alto | (completar) |

### Análisis temporal

| Métrica | Resultado |
|---|---|
| Mes de mayor venta | (completar) |
| Tendencia observada | (completar: ¿sube, baja, estable?) |

### Comportamiento de compra

| Métrica | Resultado |
|---|---|
| Método de pago preferido | (completar) |
| Ubicación con más ventas | (completar) |

---

## 📚 Lo que aprendí en esta fase

| Concepto | Descripción |
|---|---|
| Star Schema | Modelo dimensional con la fact en el centro |
| Dimensión vs Fact | Catálogo único vs eventos repetidos (el "calendario") |
| `COALESCE` | Reemplazar NULL por un valor de respaldo ('Unknown') |
| `EXTRACT` | Desglosar fechas en día, mes, trimestre, año |
| Surrogate Key Lookup | Traducir nombres de Silver a IDs de Gold vía JOIN |
| FK inline vs modular | Cuándo conviene cada forma de crear foreign keys |
| Ranking vs tendencia | El ORDER BY define el tipo de análisis |
| `ROUND` | Ajustar decimales para formato de dinero |

### Decisiones técnicas importantes

- Los NULL se convierten a 'Unknown' en Gold (no en Silver)
- Las FK son NOT NULL; las medidas permiten NULL
- record_status llega hasta la fact para filtrar incompletos
- Las ventas sin fecha se excluyen del análisis temporal
- FK modulares (ALTER TABLE) por ser un modelo con varias tablas

---

## 🔑 Lección más importante

```
El ORDER BY decide el tipo de análisis:

ORDER BY ventas DESC → ranking (comparar)
ORDER BY tiempo → tendencia (evolución)

El mismo dato cuenta historias distintas
según cómo lo ordenas.
```


---

## 💼 Qué significa para la gestión de proyectos

```
Esta capa cierra el ciclo completo de datos:
datos sucios → limpios → modelo → decisiones.

Haber construido cada capa a mano permite
juzgar con criterio el trabajo de un equipo
técnico: si un modelo dimensional está bien
diseñado o dará números inflados, si un análisis
responde la pregunta real o solo "corre".

Y traducir preguntas de negocio ("¿qué producto
deja más?", "¿prefieren tarjeta o efectivo?")
a consultas y respuestas claras es el puente
que un PM + Data tiende entre el negocio y
el equipo técnico.
```


---

## 🎉 Cierre de la serie completa

Con esta fase se completa la serie CafeSales — una plataforma
de datos end-to-end en PostgreSQL:

| Fase | Proyecto | Enfoque |
|---|---|---|
| 1 | CafeSales_Database_Infrastructure | Infraestructura ✅ |
| 2 | CafeSales_STG_Layer | Datos crudos ✅ |
| 3 | CafeSales_Bronze_Layer | Auditoría ✅ |
| 4 | CafeSales_Silver_Layer | Limpieza ✅ |
| 5 | CafeSales_Gold_Layer | Modelo + análisis ✅ |

Del dato sucio a la decisión de negocio, capa por capa.

---

## 👤 Autor

### Teófilo Correa Rojas

**Project Manager Digital | Data analytic**

🔗 [LinkedIn](https://www.linkedin.com/in/teófilo-correa-rojas/)