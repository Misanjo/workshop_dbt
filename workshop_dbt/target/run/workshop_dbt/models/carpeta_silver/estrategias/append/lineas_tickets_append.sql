

    insert into "dev"."silver"."lineas_tickets_append" ("id_ticket", "id_linea_ticket", "cod_producto", "nombre_producto", "cantidad", "precio_unitario", "total_linea", "ts_insert")
    (
        select "id_ticket", "id_linea_ticket", "cod_producto", "nombre_producto", "cantidad", "precio_unitario", "total_linea", "ts_insert"
        from "lineas_tickets_append__dbt_tmp20250828223504866979"
    )
  