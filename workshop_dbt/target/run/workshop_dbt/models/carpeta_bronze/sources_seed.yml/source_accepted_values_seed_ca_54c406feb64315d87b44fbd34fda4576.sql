
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        metodo_pago as value_field,
        count(*) as n_records

    from "dev"."seed"."cabecera_tickets"
    group by metodo_pago

)

select *
from all_values
where value_field not in (
    'Tarjeta','Efectivo','Transferencia','Bizum'
)



  
  
      
    ) dbt_internal_test