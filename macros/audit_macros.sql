{% macro create_audit_table_if_not_exists() %}
    {% set check_table_query %}
        SELECT COUNT(*) as table_exists
        FROM information_schema.tables
        WHERE table_schema = '{{ target.schema }}'
        AND table_name = 'dbt_audit'
    {% endset %}

    {% set result = run_query(check_table_query) %}
    {% set table_exists = result[0][0] > 0 if result and result[0] else false %}

    {% if not table_exists %}
        {% set create_table_query %}
            CREATE TABLE {{ target.schema }}.dbt_audit (
                audit_id BIGINT PRIMARY KEY,
                run_started_at TIMESTAMP,
                run_completed_at TIMESTAMP,
                execution_time_seconds FLOAT,
                dbt_version VARCHAR,
                dbt_command VARCHAR,
                run_status VARCHAR,
                models_processed INTEGER,
                tests_executed INTEGER,
                rows_affected INTEGER,
                artifacts_generated VARCHAR[],
                environment VARCHAR,
                target_name VARCHAR,
                target_schema VARCHAR,
                target_database VARCHAR,
                error_message VARCHAR,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        {% endset %}

        {% do run_query(create_table_query) %}
        {% do log("Tabla de auditoría creada: " ~ target.schema ~ ".dbt_audit", info=true) %}
    {% else %}
        {% do log("Tabla de auditoría ya existe: " ~ target.schema ~ ".dbt_audit", info=true) %}
    {% endif %}
{% endmacro %}

{% macro log_audit_start() %}
    {% set start_time = modules.datetime.datetime.now() %}
    {% set start_timestamp = start_time.strftime('%Y-%m-%d %H:%M:%S') %}

    {% set get_next_id_query %}
        SELECT COALESCE(MAX(audit_id), 0) + 1 as next_id
        FROM {{ target.schema }}.dbt_audit
    {% endset %}

    {% set id_result = run_query(get_next_id_query) %}
    {% set next_id = id_result[0][0] if id_result and id_result[0] else 1 %}

    {% set insert_query %}
        INSERT INTO {{ target.schema }}.dbt_audit (
            audit_id,
            run_started_at,
            dbt_version,
            dbt_command,
            environment,
            target_name,
            target_schema,
            target_database,
            run_status
        ) VALUES (
            {{ next_id }},
            '{{ start_timestamp }}',
            '{{ dbt_version }}',
            '{{ flags.WHICH }}',
            '{{ env_var("DBT_ENV", "development") }}',
            '{{ target.name }}',
            '{{ target.schema }}',
            '{{ target.database }}',
            'running'
        )
    {% endset %}

    {% do run_query(insert_query) %}
    {% do log("Inicio de ejecución registrado en auditoría. ID: " ~ next_id, info=true) %}
{% endmacro %}

{% macro log_audit_end() %}
    {% set end_time = modules.datetime.datetime.now() %}
    {% set end_timestamp = end_time.strftime('%Y-%m-%d %H:%M:%S') %}

    {% set get_audit_info_query %}
        SELECT audit_id, run_started_at
        FROM {{ target.schema }}.dbt_audit
        WHERE run_completed_at IS NULL
        ORDER BY run_started_at DESC
        LIMIT 1
    {% endset %}

    {% set result = run_query(get_audit_info_query) %}

    {% if result and result[0] %}
        {% set audit_id = result[0][0] %}
        {% set start_time_obj = result[0][1] %}  {# Esto ya es un objeto datetime #}

        {# Calculamos el tiempo de ejecución directamente #}
        {% set execution_time = (end_time - start_time_obj).total_seconds() %}

        {% set update_query %}
            UPDATE {{ target.schema }}.dbt_audit
            SET
                run_completed_at = '{{ end_timestamp }}',
                execution_time_seconds = {{ execution_time }},
                run_status = 'completed'
            WHERE audit_id = {{ audit_id }}
        {% endset %}

        {% do run_query(update_query) %}
        {% do log("Final de ejecución registrado en auditoría. ID: " ~ audit_id ~ ", Tiempo: " ~ execution_time ~ "s", info=true) %}
    {% else %}
        {% do log("No se encontró ejecución pendiente para actualizar", info=true) %}

        {# Si no hay ejecución pendiente, creamos un registro de error #}
        {% set insert_error_query %}
            INSERT INTO {{ target.schema }}.dbt_audit (
                audit_id,
                run_started_at,
                run_completed_at,
                run_status,
                error_message
            ) VALUES (
                999999,
                '{{ end_timestamp }}',
                '{{ end_timestamp }}',
                'error',
                'No se encontró ejecución pendiente al finalizar'
            )
        {% endset %}
        {% do run_query(insert_error_query) %}
    {% endif %}
{% endmacro %}