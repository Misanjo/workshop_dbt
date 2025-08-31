
    
    

with all_values as (

    select
        estado as value_field,
        count(*) as n_records

    from "dev"."bronze"."centros_manual"
    group by estado

)

select *
from all_values
where value_field not in (
    'Activo','Inactivo','Mantenimiento'
)


