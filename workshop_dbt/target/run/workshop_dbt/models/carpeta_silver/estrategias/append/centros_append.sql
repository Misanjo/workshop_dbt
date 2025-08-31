

    insert into "dev"."silver"."centros_append" ("cod_centro", "nombre_centro", "ciudad", "region", "estado", "ts_insert")
    (
        select "cod_centro", "nombre_centro", "ciudad", "region", "estado", "ts_insert"
        from "centros_append__dbt_tmp20250831191927930162"
    )
  