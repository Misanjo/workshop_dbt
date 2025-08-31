





with validation_errors as (

    select
        id_ticket, id_linea_ticket
    from "dev"."seed"."lineas_tickets"
    group by id_ticket, id_linea_ticket
    having count(*) > 1

)

select *
from validation_errors


