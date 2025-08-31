




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
    from "dev"."silver"."lineas_tickets_merge"
    
    where cast(ts_insert as date) between '2024-01-01'::date and '2024-01-31'::date
    
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