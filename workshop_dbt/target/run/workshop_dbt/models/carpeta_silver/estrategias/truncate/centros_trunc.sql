
  
    
    

    create  table
      "dev"."silver"."centros_trunc__dbt_tmp"
  
    as (
      

with source_data as (
    select
        -- Conversiones explícitas para todos los campos
        cast(cod_centro as varchar(10)) as cod_centro,
        cast(nombre_centro as varchar(100)) as nombre_centro,
        cast(ciudad as varchar(50)) as ciudad,
        cast(region as varchar(50)) as region,
        cast(estado as varchar(20)) as estado,
        cast(current_timestamp as timestamp) as ts_insert
    from "dev"."bronze"."centros_manual"
)

select
    cod_centro,
    nombre_centro,
    ciudad,
    region,
    estado,
    ts_insert
from source_data
    );
  
  