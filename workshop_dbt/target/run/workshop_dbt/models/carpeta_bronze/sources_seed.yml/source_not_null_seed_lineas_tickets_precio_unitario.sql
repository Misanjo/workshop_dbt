
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select precio_unitario
from "dev"."seed"."lineas_tickets"
where precio_unitario is null



  
  
      
    ) dbt_internal_test