
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cod_producto
from "dev"."silver"."lineas_tickets_consolidados"
where cod_producto is null



  
  
      
    ) dbt_internal_test