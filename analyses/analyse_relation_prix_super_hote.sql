{{ doc('prix_superhost') }}

SELECT  
    CASE
        WHEN h.is_superhost = TRUE THEN 'super hote'
        ELSE 'non super hote'
    END AS type_d_hote,
    count(h.host_id) as nb_hote,
    count(l.listing_id) as nb_location,
     {{ pct_distribution("COUNT(CASE WHEN l.room_type='Entire home/apt' THEN 1 END)", "COUNT(l.listing_id)") }} as pct_entire_home, -- pourcentage d'appartement à la location
    median(l.price) as prix_median,
    ROUND(AVG(l.price),2) as prix_moyen,
    ROUND({{ stddev_safe('price') }},2) as ecart_type_du_prix,
    min(l.price) as prix_minimum,
    max(l.price) as prix_maximum
FROM {{ ref("curation_hosts") }}  as h
INNER JOIN {{ ref("curation_listings") }} as l
ON h.host_id = l.host_id
GROUP BY type_d_hote