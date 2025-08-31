
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select precio_unitario
from "dev"."silver"."lineas_tickets_consolidados"
where precio_unitario is null



  
  
      
    ) dbt_internal_test