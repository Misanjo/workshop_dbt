{{
    config(
        unique_key='cod_centro',
        strategy='delete+insert'
    )
}}

{% set start_date = var('start_date') %}
{% set end_date = var('end_date') %}

with nuevos_registros as (
    select
        cod_centro,
        nombre_centro,
        ciudad,
        region,
        estado,
        row_number() over (partition by cod_centro order by ts_insert desc) as rn
    from {{ ref('centros_merge') }}
    {% if is_incremental() %}
    where cast(ts_insert as date) between '{{ start_date }}'::date and '{{ end_date }}'::date
    {% endif %}
)

select
    cod_centro,
    nombre_centro,
    ciudad,
    region,
    estado,
    current_timestamp as ts_insert
from nuevos_registros
where rn = 1