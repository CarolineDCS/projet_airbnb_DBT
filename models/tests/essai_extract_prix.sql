{{
    config(
        schema=var("curation_schema","curation_dev"),
        materialized='table'
    )
}}

SELECT 
    '$ 1,234.56' as price_raw,
    {{ extraire_prix_a_partir_dun_caractere('price_raw', '$') }} as price_clean
UNION ALL SELECT 
    '1,234.56 $' as price_raw, 
    {{ extraire_prix_a_partir_dun_caractere('price_raw', '$') }} as price_clean 