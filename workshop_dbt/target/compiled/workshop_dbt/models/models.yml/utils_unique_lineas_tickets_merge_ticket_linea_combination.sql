





with validation_errors as (

    select
        id_ticket, id_linea_ticket
    from "dev"."silver"."lineas_tickets_trunc"
    group by id_ticket, id_linea_ticket
    having count(*) > 1

)

select *
from validation_errors


