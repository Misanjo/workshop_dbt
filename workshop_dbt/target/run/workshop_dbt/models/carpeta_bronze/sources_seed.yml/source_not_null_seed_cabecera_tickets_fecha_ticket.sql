
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select fecha_ticket
from "dev"."seed"."cabecera_tickets"
where fecha_ticket is null



  
  
      
    ) dbt_internal_test