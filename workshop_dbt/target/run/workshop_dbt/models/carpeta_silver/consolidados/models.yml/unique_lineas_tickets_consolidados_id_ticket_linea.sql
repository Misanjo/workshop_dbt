
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    id_ticket_linea as unique_field,
    count(*) as n_records

from "dev"."silver"."lineas_tickets_consolidados"
where id_ticket_linea is not null
group by id_ticket_linea
having count(*) > 1



  
  
      
    ) dbt_internal_test