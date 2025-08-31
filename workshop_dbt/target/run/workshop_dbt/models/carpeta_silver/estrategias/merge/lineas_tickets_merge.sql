
        
            delete from "dev"."silver"."lineas_tickets_merge" as DBT_INCREMENTAL_TARGET
            using "lineas_tickets_merge__dbt_tmp20250828223504897027"
            where (
                
                    "lineas_tickets_merge__dbt_tmp20250828223504897027".id_ticket = DBT_INCREMENTAL_TARGET.id_ticket
                    and 
                
                    "lineas_tickets_merge__dbt_tmp20250828223504897027".id_linea_ticket = DBT_INCREMENTAL_TARGET.id_linea_ticket
                    
                
                
            );
        
    

    insert into "dev"."silver"."lineas_tickets_merge" ("id_ticket", "id_linea_ticket", "cod_producto", "nombre_producto", "cantidad", "precio_unitario", "total_linea", "ts_insert")
    (
        select "id_ticket", "id_linea_ticket", "cod_producto", "nombre_producto", "cantidad", "precio_unitario", "total_linea", "ts_insert"
        from "lineas_tickets_merge__dbt_tmp20250828223504897027"
    )
  