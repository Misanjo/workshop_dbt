
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cantidad
from "dev"."silver"."lineas_tickets_trunc"
where cantidad is null



  
  
      
    ) dbt_internal_test