
        
            delete from "dev"."silver"."lineas_tickets_consolidados" as DBT_INCREMENTAL_TARGET
            using "lineas_tickets_consolidados__dbt_tmp20250831192044425141"
            where (
                
                    "lineas_tickets_consolidados__dbt_tmp20250831192044425141".id_ticket = DBT_INCREMENTAL_TARGET.id_ticket
                    and 
                
                    "lineas_tickets_consolidados__dbt_tmp20250831192044425141".id_linea_ticket = DBT_INCREMENTAL_TARGET.id_linea_ticket
                    
                
                
            );
        
    

    insert into "dev"."silver"."lineas_tickets_consolidados" ("id_ticket", "id_linea_ticket", "id_ticket_linea", "cod_producto", "nombre_producto", "cantidad", "precio_unitario", "total_linea", "ts_insert")
    (
        select "id_ticket", "id_linea_ticket", "id_ticket_linea", "cod_producto", "nombre_producto", "cantidad", "precio_unitario", "total_linea", "ts_insert"
        from "lineas_tickets_consolidados__dbt_tmp20250831192044425141"
    )
  