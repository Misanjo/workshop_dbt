




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
    from "dev"."silver"."cabecera_tickets_merge"
    
    where cast(ts_insert as date) between '2024-01-01'::date and '2024-01-31'::date
    
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