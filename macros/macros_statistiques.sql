{% macro calcul_q1(nom_colonne) -%}
    -- pour calculer le premier quartile en fonction d'une colonne donnee nom_colonne
    PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY {{ nom_colonne }})
{%- endmacro %}

{% macro calcul_q3(nom_colonne) -%}
    -- pour calculer le 3e quartile en fonction d'une colonne donnee nom_colonne
    PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY {{ nom_colonne }})
{%- endmacro %}

{% macro inter_quartile(nom_colonne) -%}
    -- pour calculer l'écart interquartile en fonction d'une colonne donnee nom_colonne
    -- et en utilisant les macros qui calculent Q1 et Q3
    {{ calcul_q3(nom_colonne) }} - {{ calcul_q1(nom_colonne) }}
{%- endmacro %}

{% macro pct_distribution(nb_categorie, total) %}
-- calcul du pourcentage d'une catégorie dont on donne le nombre
    ROUND(100.0 * {{ nb_categorie }} / {{ total }}, 2)
{% endmacro %}

{% macro stddev_safe(nom_colonne) %}
-- calcul l'écart-type en ne mettant pas null si toute les valeurs contenues dans nom_colonne sont identique
-- dans ce cas, met 0
    CASE 
        WHEN COUNT(DISTINCT {{ nom_colonne }}) <= 1 THEN 0 
        ELSE STDDEV({{ nom_colonne }}) 
    END
{% endmacro %}