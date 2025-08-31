
        
            delete from "dev"."silver"."centros_consolidados"
            where (
                cod_centro) in (
                select (cod_centro)
                from "centros_consolidados__dbt_tmp20250831192044400396"
            );

        
    

    insert into "dev"."silver"."centros_consolidados" ("cod_centro", "nombre_centro", "ciudad", "region", "estado", "ts_insert")
    (
        select "cod_centro", "nombre_centro", "ciudad", "region", "estado", "ts_insert"
        from "centros_consolidados__dbt_tmp20250831192044400396"
    )
  