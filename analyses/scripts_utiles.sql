-- =============================================================================
-- SCRIPTS ÚTILES - WORKSHOP DBT
-- =============================================================================
-- Este archivo agrupa scripts para carga manual, verificación de datos y auditoría.

-- -----------------------------------------------------------------------------
-- 1. CARGA MANUAL DE DATOS (BRONZE)
-- -----------------------------------------------------------------------------
-- Script para crear y cargar las tablas manuales desde archivos CSV en DuckDB.

-- Crear el esquema bronze si no existe
CREATE SCHEMA IF NOT EXISTS bronze;

-- centros_manual
CREATE OR REPLACE TABLE bronze.centros_manual (
    cod_centro VARCHAR,
    nombre_centro VARCHAR,
    ciudad VARCHAR,
    region VARCHAR,
    estado VARCHAR,
    ts_insert TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COPY bronze.centros_manual (cod_centro, nombre_centro, ciudad, region, estado)
FROM 'seeds/centros.csv'
WITH (FORMAT csv, HEADER true, DELIMITER '|', NULL '');

-- cabecera_tickets_manual
CREATE OR REPLACE TABLE bronze.cabecera_tickets_manual (
    id_ticket VARCHAR,
    cod_centro VARCHAR,
    fecha_ticket VARCHAR,
    hora_ticket VARCHAR,
    total_ticket VARCHAR,
    metodo_pago VARCHAR,
    empleado VARCHAR,
    ts_insert TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COPY bronze.cabecera_tickets_manual (id_ticket, cod_centro, fecha_ticket, hora_ticket, total_ticket, metodo_pago, empleado)
FROM 'seeds/cabecera_tickets.csv'
WITH (FORMAT csv, HEADER true, DELIMITER '|', NULL '');

-- lineas_tickets_manual
CREATE OR REPLACE TABLE bronze.lineas_tickets_manual (
    id_ticket VARCHAR,
    id_linea_ticket VARCHAR,
    cod_producto VARCHAR,
    nombre_producto VARCHAR,
    cantidad VARCHAR,
    precio_unitario VARCHAR,
    total_linea VARCHAR,
    ts_insert TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COPY bronze.lineas_tickets_manual (id_ticket, id_linea_ticket, cod_producto, nombre_producto, cantidad, precio_unitario, total_linea)
FROM 'seeds/lineas_tickets.csv'
WITH (FORMAT csv, HEADER true, DELIMITER '|', NULL '');


-- -----------------------------------------------------------------------------
-- 2. VERIFICACIÓN DE CARGA (SEEDS & MANUAL)
-- -----------------------------------------------------------------------------

-- Conteo de registros
SELECT
    (SELECT COUNT(*) FROM bronze.centros) AS total_centros_seed,
    (SELECT COUNT(*) FROM bronze.centros_manual) AS total_centros_manual,
    (SELECT COUNT(*) FROM bronze.cabecera_tickets) AS total_cabeceras_seed,
    (SELECT COUNT(*) FROM bronze.lineas_tickets) AS total_lineas_seed;

-- Muestras de datos
SELECT 'bronze.centros' AS tabla, * FROM bronze.centros LIMIT 3;
SELECT 'bronze.cabecera_tickets' AS tabla, * FROM bronze.cabecera_tickets LIMIT 3;
SELECT 'bronze.lineas_tickets' AS tabla, * FROM bronze.lineas_tickets LIMIT 5;


-- -----------------------------------------------------------------------------
-- 3. AUDITORÍA Y MONITORIZACIÓN
-- -----------------------------------------------------------------------------

-- Resumen de ejecuciones
SELECT
    (SELECT COUNT(*) FROM dbt_audit) AS total_ejecuciones_audit;

-- Últimas 5 ejecuciones
SELECT 'db_audit' AS tabla, * FROM dbt_audit ORDER BY run_started_at DESC LIMIT 5;
