
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_ticket
from "dev"."silver"."cabecera_tickets_consolidados"
where total_ticket is null



  
  
      
    ) dbt_internal_test