
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select nombre_producto
from "dev"."bronze"."lineas_tickets"
where nombre_producto is null



  
  
      
    ) dbt_internal_test