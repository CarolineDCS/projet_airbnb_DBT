SELECT  {{ pct_distribution("COUNT(CASE WHEN accommodates>4 THEN 1 END)", "COUNT(listing_id)") }} as pct_hors_la_loi
FROM {{ ref("curation_listings")}}
-- retourne 5,96

WITH estimaton_locataire AS (
SELECT
    listing_id,
    CASE 
    WHEN accommodates>4 THEN 4
    WHEN accommodates = 1 THEN 1
    ELSE ROUND(accommodates * 0.75,2)
    END as estimation_nb_locataire
FROM  {{ ref("curation_listings")}}
),
nombre_annuel_de_reviws AS (
SELECT 
    listing_id,
    YEAR(review_date) as review_year,
    SUM(number_reviews) as total_reviews
FROM {{ ref("curation_reviews")}}
GROUP BY listing_id, review_year
),
estimation_location AS (
SELECT 
    listing_id,
    review_year,
    total_reviews * 0.5 as estimation_location_ration_50pct,
    total_reviews * 0.8 as estimation_location_ration_80pct
FROM nombre_annuel_de_reviws),
estimation_tourist_par_listing AS (
SELECT 
    e.listing_id,
    e.review_year as year,
    e.estimation_location_ration_50pct * l.estimation_nb_locataire as nb_tourist_par_location_ratio50pct,
    e.estimation_location_ration_80pct * l.estimation_nb_locataire as nb_tourist_par_location_ratio80pct
FROM estimation_location as e
INNER JOIN estimaton_locataire as l
ON e.listing_id = l.listing_id ),
estimation_tourist AS (
SELECT 
    year,
    ROUND(SUM(nb_tourist_par_location_ratio50pct), 0) as nb_tourist_ratio_50pct,
    ROUND(SUM(nb_tourist_par_location_ratio80pct),0) as nb_tourist_ratio_80pct
FROM estimation_tourist_par_listing
GROUP BY year)
SELECT 
    e.year,

   ROUND({{ pct_distribution('e.nb_tourist_ratio_50pct', 'c.tourists') }}, 2) as pct_tourist_per_year_ratio50pct, 
--   LAG(pct_tourist_per_year_ratio50pct) OVER (ORDER BY e.year) as previous_year_ratio50pct,
    ROUND(
        (pct_tourist_per_year_ratio50pct / NULLIF(LAG(pct_tourist_per_year_ratio50pct) OVER (ORDER BY e.year), 0) - 1) * 100, 1
    ) as yoy_pct_ratio50pct, 

   ROUND({{ pct_distribution('e.nb_tourist_ratio_80pct', 'c.tourists') }}, 2) as pct_tourist_per_year_ratio80pct,
--   LAG(pct_tourist_per_year_ratio80pct) OVER (ORDER BY e.year) as previous_year_ratio80pct,
    ROUND(
        (pct_tourist_per_year_ratio80pct / NULLIF(LAG(pct_tourist_per_year_ratio80pct) OVER (ORDER BY e.year), 0) - 1) * 100, 1
    ) as yoy_pct_ratio80pct, 

FROM estimation_tourist as e
INNER JOIN {{ ref("curation_tourists_per_year")}} as c
ON e.year = YEAR(c.year)
