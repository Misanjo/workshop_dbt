
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cod_centro
from "dev"."silver"."cabecera_tickets_merge"
where cod_centro is null



  
  
      
    ) dbt_internal_test