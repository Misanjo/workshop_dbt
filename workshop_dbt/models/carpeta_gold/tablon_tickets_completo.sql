{{
    config(
        materialized='incremental',
        schema='gold',
        unique_key=['id_ticket', 'id_ticket_linea'],
                pre_hook=[
            "{{ delete_old_data(this, 'fecha_ticket', 2) }}"
        ]

    )
}}

{% set start_date = var('start_date') %}
{% set end_date = var('end_date') %}

with centros as (
    select *
    from {{ ref('centros_consolidados') }}
    {% if is_incremental() %}
    where cast(ts_insert as date) between '{{ start_date }}'::date and '{{ end_date }}'::date
    {% endif %}
),

cabecera as (
    select *
    from {{ ref('cabecera_tickets_consolidados') }}
    {% if is_incremental() %}
    where cast(ts_insert as date) between '{{ start_date }}'::date and '{{ end_date }}'::date
    {% endif %}
),

lineas as (
    select
        *,
        cast(id_ticket as varchar) || '_' || cast(id_linea_ticket as varchar) as id_ticket_linea
    from {{ ref('lineas_tickets_consolidados') }}
    {% if is_incremental() %}
    where cast(ts_insert as date) between '{{ start_date }}'::date and '{{ end_date }}'::date
    {% endif %}
),

tablon_base as (
    select
        -- Campos de línea (granularidad más fina)
        l.id_ticket,
        l.id_linea_ticket,
        l.id_ticket_linea,
        l.cod_producto,
        l.nombre_producto,
        l.cantidad,
        l.precio_unitario,
        l.total_linea,

        -- Campos de cabecera
        c.id_ticket as cabecera_id_ticket,
        c.cod_centro,
        c.fecha_ticket,
        c.hora_ticket,
        c.total_ticket as total_cabecera,
        c.metodo_pago,
        c.empleado,

        -- Campos de centro
        cen.cod_centro as centro_cod_centro,
        cen.nombre_centro,
        cen.ciudad,
        cen.region,
        cen.estado,

        -- Campos calculados
        case
            when l.total_linea is not null and c.total_ticket is not null and c.total_ticket > 0
            then (l.total_linea / c.total_ticket) * 100
            else null
        end as porcentaje_del_total,

        -- Metadata
        current_timestamp as ts_gold_creacion,

        -- Flag de integridad (CORREGIDO: usar alias de las CTEs)
        case
            when c.cod_centro is not null and cen.cod_centro is not null
            then true
            else false
        end as integridad_completa

    from lineas l
    left join cabecera c on l.id_ticket = c.id_ticket
    left join centros cen on c.cod_centro = cen.cod_centro
)

select
    -- Identificadores
    id_ticket,
    id_linea_ticket,
    id_ticket_linea,
    cod_producto,
    cabecera_id_ticket,
    cod_centro,
    centro_cod_centro,

    -- Información del producto
    nombre_producto,
    cantidad,
    precio_unitario,
    total_linea,

    -- Información del ticket
    fecha_ticket,
    hora_ticket,
    total_cabecera,
    metodo_pago,
    empleado,

    -- Información del centro
    nombre_centro,
    ciudad,
    region,
    estado,

    -- Campos calculados
    porcentaje_del_total,

    -- Flag de integridad
    integridad_completa

from tablon_base