
    
    

with child as (
    select cod_centro as from_field
    from "dev"."bronze"."cabecera_tickets"
    where cod_centro is not null
),

parent as (
    select cod_centro as to_field
    from "dev"."bronze"."centros"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


