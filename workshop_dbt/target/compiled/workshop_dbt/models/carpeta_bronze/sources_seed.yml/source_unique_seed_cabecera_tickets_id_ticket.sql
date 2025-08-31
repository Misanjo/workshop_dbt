
    
    

select
    id_ticket as unique_field,
    count(*) as n_records

from "dev"."seed"."cabecera_tickets"
where id_ticket is not null
group by id_ticket
having count(*) > 1


