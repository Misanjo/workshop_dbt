
        
            delete from "dev"."silver"."cabecera_tickets_merge" as DBT_INCREMENTAL_TARGET
            using "cabecera_tickets_merge__dbt_tmp20250828223504717710"
            where (
                
                    "cabecera_tickets_merge__dbt_tmp20250828223504717710".id_ticket = DBT_INCREMENTAL_TARGET.id_ticket
                    
                
                
            );
        
    

    insert into "dev"."silver"."cabecera_tickets_merge" ("id_ticket", "cod_centro", "fecha_ticket", "hora_ticket", "total_ticket", "metodo_pago", "empleado", "ts_insert")
    (
        select "id_ticket", "cod_centro", "fecha_ticket", "hora_ticket", "total_ticket", "metodo_pago", "empleado", "ts_insert"
        from "cabecera_tickets_merge__dbt_tmp20250828223504717710"
    )
  