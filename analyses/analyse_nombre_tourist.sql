SELECT  {{ pct_distribution("COUNT(CASE WHEN accommodates>4 THEN 1 END)", "COUNT(listing_id)") }} as pct_hors_la_loi
FROM {{ ref("curation_listings")}}
-- retourne 5,96

SELECT
    listing_id,
    CASE 
    WHEN accommodates>4 THEN 4
    WHEN accommodates = 1 THEN 1
    ELSE ROUND(accommodates * 0.75,2)
    END as estimation_nb_locataire
FROM  {{ ref("curation_listings")}}