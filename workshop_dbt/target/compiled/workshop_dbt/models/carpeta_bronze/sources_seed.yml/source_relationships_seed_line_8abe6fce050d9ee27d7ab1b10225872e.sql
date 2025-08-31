
    
    

with child as (
    select id_ticket as from_field
    from "dev"."seed"."lineas_tickets"
    where id_ticket is not null
),

parent as (
    select id_ticket as to_field
    from "dev"."seed"."cabecera_tickets"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


