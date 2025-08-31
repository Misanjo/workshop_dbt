
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select hora_ticket
from "dev"."bronze"."cabecera_tickets_manual"
where hora_ticket is null



  
  
      
    ) dbt_internal_test