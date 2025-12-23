# Workshop dbt - Proyecto de Ejemplo

Este repositorio contiene un proyecto dbt estructurado siguiendo las mejores prácticas para la transformación de datos. El proyecto utiliza **DuckDB** como motor de base de datos.

## Estructura del Proyecto

El proyecto sigue una arquitectura de capas (Medallion):

- **Bronze**: Carga de datos crudos desde archivos CSV y fuentes externas.
- **Silver**: Limpieza de datos, tipado, normalización y consolidación.
- **Gold**: Modelos finales listos para consumo (Dimensiones y Hechos).

## Requisitos Previos

- Python 3.8+
- dbt-core
- dbt-duckdb

Para instalar las dependencias necesarias:

```bash
pip install -r requirements.txt
```

## Configuración y Ejecución

### 1. Perfil de dbt
Asegúrate de tener configurado tu archivo `profiles.yml`. El proyecto busca el perfil `profile_workshop_dbt`. Puedes encontrar un ejemplo en la carpeta `profile/`.

### 2. Carga de Semillas
Carga los datos iniciales desde la carpeta `seeds/`:

```bash
dbt seed
```

### 3. Ejecución de Modelos
Para ejecutar todos los modelos:

```bash
dbt run
```

### 4. Pruebas de Datos
Para validar la calidad de los datos:

```bash
dbt test
```

## Buenas Prácticas Implementadas

- **Modularidad**: Uso exhaustivo de `ref()` y `source()`.
- **Documentación**: Todos los modelos y columnas principales están documentados en archivos `.yml`.
- **Testing**: Pruebas de unicidad, no nulidad y valores aceptados integradas.
- **Organización**: Estructura de carpetas clara por capas de datos.
- **Git Hygiene**: `.gitignore` optimizado para excluir binarios y archivos temporales de dbt.

---
Desarrollado para el workshop de dbt.
