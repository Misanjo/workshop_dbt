
    
    

select
    id_ticket as unique_field,
    count(*) as n_records

from "dev"."bronze"."cabecera_tickets_manual"
where id_ticket is not null
group by id_ticket
having count(*) > 1


