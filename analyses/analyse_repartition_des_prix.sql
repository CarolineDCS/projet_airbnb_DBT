WITH hosts AS(
    SELECT 
        host_id,
        host_neighbourhood as neighbourhood
    FROM {{ ref("curation_host") }} 
),
listings AS(
    SELECT
        listing_id, 
        host_id,
        room_type,
        accommodates,
        price,
        {{ prix_par_personne('price', 'accommodates') }} as prix_par_personne
    FROM {{ ref("curation_listening") }}
)
SELECT 
    h.neighbourhood,
    count(l.listing_id) as nb_location, -- le nombre de loccation dans le quartier
    ROUND(AVG(l.price),2) as avg_prix_location, -- moyenne du prix de la location par quartier
    ROUND(AVG(l.prix_par_personne),2) as avg_prix_personne, -- moyenne du prix théorique par capacité maximale par personne
    ROUND(median(l.price),2) as median_prix_location, -- median du prix de la location par quartier
    ROUND({{ stddev_safe('l.price') }},2) as ecart_type_prix_location, -- ecart type du prix de la location par quartier pour pouvoir voir la dispersion par rapport à la moyenne 
     {{ calcul_q1('l.price') }} as Q1_prix_location, -- le premier quartile par rapport au prix de la location par quartier
      {{ calcul_q3('l.price') }} as Q3_prix_location,  -- le troisième quartile par rapport au prix de la location par quartier
    {{ inter_quartile('l.price') }} as ecart_inter_quartile_location,   -- le écart inter-quartile par rapport au prix de la location par quartier
    min(l.price) as min_prix_location, -- le prix de location minimum par quartier
    max(l.price) as max_prix_location, -- le prix de location maximum par quartier 
    max(l.price) - min(l.price) as etentue_prix_location, -- l'étendue du prix de location par quartier
    {{ pct_distribution("COUNT(CASE WHEN l.room_type='Entire home/apt' THEN 1 END)", "COUNT(l.listing_id)") }} as pct_entire_home -- pourcentage d'appartement à la location dans le quartier
FROM  hosts as h
INNER JOIN  listings as l
ON h.host_id = l.host_id
GROUP BY h.neighbourhood