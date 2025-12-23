{{
    config(
        tags=['tag_cabecera_ticket_append']
            )
}}

with source_data as (
    select
        -- Conversiones explícitas para todos los campos
        cast(id_ticket as varchar(10)) as id_ticket,
        cast(cod_centro as varchar(10)) as cod_centro,
        cast(fecha_ticket as date) as fecha_ticket,
        cast(hora_ticket as time) as hora_ticket,
        cast(total_ticket as decimal(10,2)) as total_ticket,
        cast(metodo_pago as varchar(20)) as metodo_pago,
        cast(empleado as varchar(10)) as empleado,
        cast(current_timestamp as timestamp) as ts_insert
    from {{ source('bronze', 'cabecera_tickets_manual') }}
)

select
    id_ticket,
    cod_centro,
    fecha_ticket,
    hora_ticket,
    total_ticket,
    metodo_pago,
    empleado,
    ts_insert
from source_data