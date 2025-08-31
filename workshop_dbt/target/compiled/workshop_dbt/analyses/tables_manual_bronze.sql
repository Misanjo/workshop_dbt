-- Script para crear y cargar las tablas manuales desde archivos CSV en DuckDB
-- Gestión automática del esquema bronze y todas las columnas como VARCHAR

-- 1. Crear el esquema bronze si no existe
CREATE SCHEMA IF NOT EXISTS bronze;

-- 2. Crear tabla centros_manual en esquema bronze
CREATE OR REPLACE TABLE bronze.centros_manual (
    cod_centro VARCHAR,
    nombre_centro VARCHAR,
    ciudad VARCHAR,
    region VARCHAR,
    estado VARCHAR,
    ts_insert TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Cargar datos desde CSV a centros_manual
COPY bronze.centros_manual (cod_centro, nombre_centro, ciudad, region, estado)
FROM 'seeds/centros.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER '|',
    NULL ''
);

-- 4. Crear tabla cabecera_tickets_manual en esquema bronze
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

-- 5. Cargar datos desde CSV a cabecera_tickets_manual
COPY bronze.cabecera_tickets_manual (id_ticket, cod_centro, fecha_ticket, hora_ticket, total_ticket, metodo_pago, empleado)
FROM 'seeds/cabecera_tickets.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER '|',
    NULL ''
);

-- 6. Crear tabla lineas_tickets_manual en esquema bronze
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

-- 7. Cargar datos desde CSV a lineas_tickets_manual
COPY bronze.lineas_tickets_manual (id_ticket, id_linea_ticket, cod_producto, nombre_producto, cantidad, precio_unitario, total_linea)
FROM 'seeds/lineas_tickets.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER '|',
    NULL ''
);

-- 8. Verificar conteo de registros cargados
SELECT
    (SELECT COUNT(*) FROM bronze.centros_manual) AS total_centros,
    (SELECT COUNT(*) FROM bronze.cabecera_tickets_manual) AS total_cabeceras,
    (SELECT COUNT(*) FROM bronze.lineas_tickets_manual) AS total_lineas;

-- 9. Mostrar muestras de datos cargados
SELECT 'bronze.centros_manual' AS tabla, * FROM bronze.centros_manual LIMIT 3;
SELECT 'bronze.cabecera_tickets_manual' AS tabla, * FROM bronze.cabecera_tickets_manual LIMIT 3;
SELECT 'bronze.lineas_tickets_manual' AS tabla, * FROM bronze.lineas_tickets_manual LIMIT 5;