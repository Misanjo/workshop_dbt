
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select hora_ticket
from "dev"."silver"."cabecera_tickets_consolidados"
where hora_ticket is null



  
  
      
    ) dbt_internal_test