
    

    SELECT
        ciudad,
        'ciudad_sin_mayusculas' as error_type,
        'El campo ciudad debe contener al menos una letra mayúscula' as error_message
    FROM "dev"."silver"."centros_consolidados"
    WHERE
        ciudad IS NOT NULL
        AND ciudad != ''
        -- Verificar que no contiene ninguna letra mayúscula
        AND NOT REGEXP_MATCHES(ciudad, '[A-Z]')
        -- Pero sí contiene letras (excluir números puros)
        AND REGEXP_MATCHES(ciudad, '[a-z]')

