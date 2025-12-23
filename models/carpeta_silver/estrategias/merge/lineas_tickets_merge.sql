{{
    config(
        tags=['tag_lineas_tickets_merge'],
        unique_key=['id_ticket', 'id_linea_ticket']
            )
}}

with source_data as (
    select
        -- Conversiones explícitas para todos los campos
        cast(id_ticket as varchar(10)) as id_ticket,
        cast(id_linea_ticket as integer) as id_linea_ticket,
        cast(cod_producto as varchar(10)) as cod_producto,
        cast(nombre_producto as varchar(100)) as nombre_producto,
        cast(cantidad as integer) as cantidad,
        cast(precio_unitario as decimal(10,2)) as precio_unitario,
        cast(total_linea as decimal(10,2)) as total_linea,
        cast(current_timestamp as timestamp) as ts_insert
    from {{ source('bronze', 'lineas_tickets_manual') }}
)

select
    id_ticket,
    id_linea_ticket,
    cod_producto,
    nombre_producto,
    cantidad,
    precio_unitario,
    total_linea,
    ts_insert
from source_data