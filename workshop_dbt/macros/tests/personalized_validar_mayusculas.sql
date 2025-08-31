{% test singular_validar_mayusculas(model, column_name) %}
    {#
    Test personalizado para validar que el campo ciudad tenga al menos una letra mayúscula.
    Usando expresiones regulares para mejor precisión.
    #}

    SELECT
        {{ column_name }},
        'ciudad_sin_mayusculas' as error_type,
        'El campo ciudad debe contener al menos una letra mayúscula' as error_message
    FROM {{ model }}
    WHERE
        {{ column_name }} IS NOT NULL
        AND {{ column_name }} != ''
        -- Verificar que no contiene ninguna letra mayúscula
        AND NOT REGEXP_MATCHES({{ column_name }}, '[A-Z]')
        -- Pero sí contiene letras (excluir números puros)
        AND REGEXP_MATCHES({{ column_name }}, '[a-z]')

{% endtest %}