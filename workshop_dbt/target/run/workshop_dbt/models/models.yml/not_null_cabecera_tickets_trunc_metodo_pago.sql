
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select metodo_pago
from "dev"."silver"."cabecera_tickets_trunc"
where metodo_pago is null



  
  
      
    ) dbt_internal_test