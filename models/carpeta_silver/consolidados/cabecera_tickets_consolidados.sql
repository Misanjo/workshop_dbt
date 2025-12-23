{{
    config(
        unique_key='id_ticket',
        strategy='merge'
    )
}}

{% set start_date = var('start_date') %}
{% set end_date = var('end_date') %}

with cabecera_ranked as (
    select
        id_ticket,
        cod_centro,
        fecha_ticket,
        hora_ticket,
        total_ticket,
        metodo_pago,
        empleado,
        row_number() over (partition by id_ticket order by ts_insert desc) as rn
    from {{ ref('cabecera_tickets_merge') }}
    {% if is_incremental() %}
    where cast(ts_insert as date) between '{{ start_date }}'::date and '{{ end_date }}'::date
    {% endif %}
)

select
    id_ticket,
    cod_centro,
    fecha_ticket,
    hora_ticket,
    total_ticket,
    metodo_pago,
    empleado,
    current_timestamp as ts_insert
from cabecera_ranked
where rn = 1