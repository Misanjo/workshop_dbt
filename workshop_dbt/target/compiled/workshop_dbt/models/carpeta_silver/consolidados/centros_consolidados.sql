




with nuevos_registros as (
    select
        cod_centro,
        nombre_centro,
        ciudad,
        region,
        estado,
        row_number() over (partition by cod_centro order by ts_insert desc) as rn
    from "dev"."silver"."centros_merge"
    
    where cast(ts_insert as date) between '2024-01-01'::date and '2024-01-31'::date
    
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