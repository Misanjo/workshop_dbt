
    
    

select
    cod_centro as unique_field,
    count(*) as n_records

from "dev"."silver"."centros_merge"
where cod_centro is not null
group by cod_centro
having count(*) > 1


