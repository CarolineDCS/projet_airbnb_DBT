{{
    config(
        schema=var("curation_schema","curation_dev"),
        materialized='ephemeral'
    )
}}

SELECT 
    neighbourhood,
     {{ calcul_q1('price') }} as Q1,
      {{ calcul_q3('price') }} as Q3,
    {{ inter_quartile('price') }} as ecart_inter_quartile,
   {{ stddev_safe('price') }} as ecart_type
FROM {{ ref ("tests_stat_prix") }}
GROUP BY neighbourhood
