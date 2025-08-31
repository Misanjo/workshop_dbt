
        
            delete from "dev"."gold"."tablon_tickets_completo" as DBT_INCREMENTAL_TARGET
            using "tablon_tickets_completo__dbt_tmp20250831194855953200"
            where (
                
                    "tablon_tickets_completo__dbt_tmp20250831194855953200".id_ticket = DBT_INCREMENTAL_TARGET.id_ticket
                    and 
                
                    "tablon_tickets_completo__dbt_tmp20250831194855953200".id_ticket_linea = DBT_INCREMENTAL_TARGET.id_ticket_linea
                    
                
                
            );
        
    

    insert into "dev"."gold"."tablon_tickets_completo" ("id_ticket", "id_linea_ticket", "id_ticket_linea", "cod_producto", "cabecera_id_ticket", "cod_centro", "centro_cod_centro", "nombre_producto", "cantidad", "precio_unitario", "total_linea", "fecha_ticket", "hora_ticket", "total_cabecera", "metodo_pago", "empleado", "nombre_centro", "ciudad", "region", "estado", "porcentaje_del_total", "integridad_completa")
    (
        select "id_ticket", "id_linea_ticket", "id_ticket_linea", "cod_producto", "cabecera_id_ticket", "cod_centro", "centro_cod_centro", "nombre_producto", "cantidad", "precio_unitario", "total_linea", "fecha_ticket", "hora_ticket", "total_cabecera", "metodo_pago", "empleado", "nombre_centro", "ciudad", "region", "estado", "porcentaje_del_total", "integridad_completa"
        from "tablon_tickets_completo__dbt_tmp20250831194855953200"
    )
  