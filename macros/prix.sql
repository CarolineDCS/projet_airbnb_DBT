{% macro prix_par_personne(nom_colonne_prix, nom_colonne_nb_personne) -%}
    -- pour calculer le prix par personne d'une location
    {{ nom_colonne_prix }} / {{ nom_colonne_nb_personne }}
{%- endmacro %} 