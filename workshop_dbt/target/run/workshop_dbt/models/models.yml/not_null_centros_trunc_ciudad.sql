
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ciudad
from "dev"."silver"."centros_trunc"
where ciudad is null



  
  
      
    ) dbt_internal_test