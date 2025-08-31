
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    cod_centro as unique_field,
    count(*) as n_records

from "dev"."silver"."centros_consolidados"
where cod_centro is not null
group by cod_centro
having count(*) > 1



  
  
      
    ) dbt_internal_test