{% macro delete_old_data(table_name, date_column, years_to_keep=2) %}
    {#
    Macro para borrar datos antiguos de una tabla solamente si la tabla existe.
    Compatible con DuckDB.

    Args:
        table_name (str/Relation): Nombre de la tabla o objeto Relation de dbt
        date_column (str): Nombre de la columna de fecha
        years_to_keep (int): Años de datos a mantener (por defecto 2)
    #}

    {%- if execute -%}
        {# Convertir el objeto Relation a string si es necesario #}
        {%- if table_name is string -%}
            {%- set full_table_name = table_name -%}
            {%- set table_schema = target.schema -%}
            {%- set table_only = table_name -%}
        {%- else -%}
            {# Es un objeto Relation (ref() o source()) #}
            {%- set full_table_name = table_name.render() -%}
            {%- set table_schema = table_name.schema -%}
            {%- set table_only = table_name.identifier -%}
        {%- endif -%}

        {%- do log("Checking if table exists: " ~ table_schema ~ "." ~ table_only, info=true) -%}

        {# Verificar si la tabla existe en DuckDB #}
        {%- set check_table_sql -%}
            SELECT COUNT(*) as table_count
            FROM information_schema.tables
            WHERE table_name = '{{ table_only }}'
            AND table_schema = '{{ table_schema }}'
        {%- endset -%}

        {%- set table_exists_result = run_query(check_table_sql) -%}

        {%- if table_exists_result and table_exists_result.rows -%}
            {%- set table_exists = table_exists_result.rows[0][0] > 0 -%}
        {%- else -%}
            {%- set table_exists = false -%}
        {%- endif -%}

        {%- if table_exists -%}
            {%- do log("Table " ~ table_schema ~ "." ~ table_only ~ " exists, proceeding with data deletion", info=true) -%}

            {%- set cutoff_date = modules.datetime.datetime.now() - modules.datetime.timedelta(days=365 * years_to_keep) -%}
            {%- set cutoff_date_str = cutoff_date.strftime('%Y-%m-%d') -%}

            {# Verificar si la columna existe #}
            {%- set check_column_sql -%}
                SELECT COUNT(*)
                FROM information_schema.columns
                WHERE table_name = '{{ table_only }}'
                AND column_name = '{{ date_column }}'
                AND table_schema = '{{ table_schema }}'
            {%- endset -%}

            {%- set column_exists_result = run_query(check_column_sql) -%}
            {%- set column_exists = column_exists_result.rows[0][0] > 0 if column_exists_result and column_exists_result.rows else false -%}

            {%- if column_exists -%}
                {%- set delete_sql -%}
                    DELETE FROM {{ full_table_name }}
                    WHERE {{ date_column }} < '{{ cutoff_date_str }}'
                {%- endset -%}

                {%- do log("Deleting data older than " ~ cutoff_date_str ~ " from " ~ full_table_name, info=true) -%}

                {%- do run_query(delete_sql) -%}

                {%- do log("Successfully deleted old data from " ~ full_table_name, info=true) -%}
            {%- else -%}
                {%- do log("Column " ~ date_column ~ " does not exist in table " ~ full_table_name ~ ", skipping deletion", info=true) -%}
            {%- endif -%}
        {%- else -%}
            {%- do log("Table " ~ full_table_name ~ " does not exist, skipping data deletion", info=true) -%}
        {%- endif -%}
    {%- endif -%}
{% endmacro %}