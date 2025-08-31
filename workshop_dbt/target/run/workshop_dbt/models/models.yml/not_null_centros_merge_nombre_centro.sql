
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select nombre_centro
from "dev"."silver"."centros_merge"
where nombre_centro is null



  
  
      
    ) dbt_internal_test