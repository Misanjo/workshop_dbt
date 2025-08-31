
  
  create view "dev"."gold"."dimension_centros__dbt_tmp" as (
    

select
    cod_centro,
    nombre_centro,
    ciudad,
    region,
    -- Convertir estado a mayúsculas
    upper(estado) as estado
from "dev"."silver"."centros_consolidados"
  );
