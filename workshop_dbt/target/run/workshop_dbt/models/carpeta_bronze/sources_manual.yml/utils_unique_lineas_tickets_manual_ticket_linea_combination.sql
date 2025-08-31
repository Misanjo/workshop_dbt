
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        id_ticket, id_linea_ticket
    from "dev"."bronze"."lineas_tickets_manual"
    group by id_ticket, id_linea_ticket
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test