{% macro extraire_prix_a_partir_dun_caractere(price, symbol) -%}
    {% set devise = symbol %}
    {{log('excection de la macro d extraction du prix avec symbol égale ' ~ devise, info=True)}}
     trim(try_to_double(REPLACE(
            CASE 
                WHEN {{ price }}  RLIKE CONCAT('^\\', '{{ symbol }}', '[[:space:]]*[0-9]{1,3}(,[0-9]{3})*(\.[0-9]{0,2})?$')
                THEN split_part({{ price }},  '{{ symbol }}' , 2)
                WHEN {{ price }} RLIKE CONCAT('^[0-9]{1,3}(,[0-9]{3})*(\.[0-9]{0,2})[[:space:]]*?\\','{{ symbol }}' ,'$')
                THEN split_part( {{ price }} , '{{ symbol }}' , 1)
                ELSE NULL
            END, 
            ',', '' 
        )))
{%- endmacro %}