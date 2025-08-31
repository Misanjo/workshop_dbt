
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id_ticket
from "dev"."bronze"."lineas_tickets"
where id_ticket is null



  
  
      
    ) dbt_internal_test