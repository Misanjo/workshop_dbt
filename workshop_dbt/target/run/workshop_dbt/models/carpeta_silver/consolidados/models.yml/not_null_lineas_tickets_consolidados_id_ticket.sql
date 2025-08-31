
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id_ticket
from "dev"."silver"."lineas_tickets_consolidados"
where id_ticket is null



  
  
      
    ) dbt_internal_test