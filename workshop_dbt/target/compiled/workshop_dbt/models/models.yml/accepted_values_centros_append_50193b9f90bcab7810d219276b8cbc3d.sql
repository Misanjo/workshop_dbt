
    
    

with all_values as (

    select
        estado as value_field,
        count(*) as n_records

    from "dev"."silver"."centros_append"
    group by estado

)

select *
from all_values
where value_field not in (
    'Activo','Inactivo','Mantenimiento'
)


