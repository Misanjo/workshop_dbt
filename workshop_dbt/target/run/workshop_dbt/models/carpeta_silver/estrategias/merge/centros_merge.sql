
        
            delete from "dev"."silver"."centros_merge" as DBT_INCREMENTAL_TARGET
            using "centros_merge__dbt_tmp20250828223504814830"
            where (
                
                    "centros_merge__dbt_tmp20250828223504814830".cod_centro = DBT_INCREMENTAL_TARGET.cod_centro
                    
                
                
            );
        
    

    insert into "dev"."silver"."centros_merge" ("cod_centro", "nombre_centro", "ciudad", "region", "estado", "ts_insert")
    (
        select "cod_centro", "nombre_centro", "ciudad", "region", "estado", "ts_insert"
        from "centros_merge__dbt_tmp20250828223504814830"
    )
  