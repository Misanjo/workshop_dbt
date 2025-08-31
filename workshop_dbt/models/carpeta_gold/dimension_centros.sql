{{
    config(
        materialized='view',
        schema='gold'
    )
}}

select
    cod_centro,
    nombre_centro,
    ciudad,
    region,
    -- Convertir estado a mayúsculas
    upper(estado) as estado
from {{ ref('centros_consolidados') }}