
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_linea
from "dev"."seed"."lineas_tickets"
where total_linea is null



  
  
      
    ) dbt_internal_test