{{
    config(
        unique_key=['id_ticket', 'id_linea_ticket'],
        strategy='merge'
    )
}}

{% set start_date = var('start_date') %}
{% set end_date = var('end_date') %}

with nuevos_registros as (
    select
        id_ticket,
        id_linea_ticket,
        id_ticket || '_' || id_linea_ticket as id_ticket_linea,
        cod_producto,
        nombre_producto,
        cantidad,
        precio_unitario,
        total_linea,
        row_number() over (partition by id_ticket, id_linea_ticket order by ts_insert desc) as rn
    from {{ ref('lineas_tickets_merge') }}
    {% if is_incremental() %}
    where cast(ts_insert as date) between '{{ start_date }}'::date and '{{ end_date }}'::date
    {% endif %}
)

select
    id_ticket,
    id_linea_ticket,
    id_ticket || '_' || id_linea_ticket as id_ticket_linea,
    cod_producto,
    nombre_producto,
    cantidad,
    precio_unitario,
    total_linea,
    current_timestamp as ts_insert
from nuevos_registros
where rn = 1