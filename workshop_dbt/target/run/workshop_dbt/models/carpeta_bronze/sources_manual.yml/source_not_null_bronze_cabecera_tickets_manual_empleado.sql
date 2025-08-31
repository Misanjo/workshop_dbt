
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select empleado
from "dev"."bronze"."cabecera_tickets_manual"
where empleado is null



  
  
      
    ) dbt_internal_test