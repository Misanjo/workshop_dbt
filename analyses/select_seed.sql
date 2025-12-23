-- 8. Verificar conteo de registros cargados
SELECT
    (SELECT COUNT(*) FROM bronze.centros) AS total_centros,
    (SELECT COUNT(*) FROM bronze.cabecera_tickets) AS total_cabeceras,
    (SELECT COUNT(*) FROM bronze.lineas_tickets) AS total_lineas;

-- 9. Mostrar muestras de datos cargados
SELECT 'bronze.centros' AS tabla, * FROM bronze.centros LIMIT 3;
SELECT 'bronze.cabecera_tickets' AS tabla, * FROM bronze.cabecera_tickets LIMIT 3;
SELECT 'bronze.lineas_tickets' AS tabla, * FROM bronze.lineas_tickets LIMIT 5;