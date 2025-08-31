

    insert into "dev"."silver"."cabecera_tickets_append" ("id_ticket", "cod_centro", "fecha_ticket", "hora_ticket", "total_ticket", "metodo_pago", "empleado", "ts_insert")
    (
        select "id_ticket", "cod_centro", "fecha_ticket", "hora_ticket", "total_ticket", "metodo_pago", "empleado", "ts_insert"
        from "cabecera_tickets_append__dbt_tmp20250828223504658575"
    )
  