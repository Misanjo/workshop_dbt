
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    id_ticket as unique_field,
    count(*) as n_records

from "dev"."silver"."cabecera_tickets_merge"
where id_ticket is not null
group by id_ticket
having count(*) > 1



  
  
      
    ) dbt_internal_test