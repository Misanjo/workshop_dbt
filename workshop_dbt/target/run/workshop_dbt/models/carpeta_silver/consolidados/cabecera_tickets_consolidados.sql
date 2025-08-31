
        
            delete from "dev"."silver"."cabecera_tickets_consolidados"
            where (
                id_ticket) in (
                select (id_ticket)
                from "cabecera_tickets_consolidados__dbt_tmp20250831192044346582"
            );

        
    

    insert into "dev"."silver"."cabecera_tickets_consolidados" ("id_ticket", "cod_centro", "fecha_ticket", "hora_ticket", "total_ticket", "metodo_pago", "empleado", "ts_insert")
    (
        select "id_ticket", "cod_centro", "fecha_ticket", "hora_ticket", "total_ticket", "metodo_pago", "empleado", "ts_insert"
        from "cabecera_tickets_consolidados__dbt_tmp20250831192044346582"
    )
  