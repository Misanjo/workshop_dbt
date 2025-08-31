
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cantidad
from "dev"."silver"."lineas_tickets_append"
where cantidad is null



  
  
      
    ) dbt_internal_test