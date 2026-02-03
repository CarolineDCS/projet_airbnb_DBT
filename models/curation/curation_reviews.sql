{{
    config(
        schema=var("curation_schema","curation")
    )
}}
WITH to_join_verified AS
    (SELECT listing_id
    FROM  {{ ref("curation_listings")}} ),
 reviews_raw AS (
    SELECT 
        listing_id,
        date AS review_date,
        count(*) AS number_reviews
    FROM {{ref("reviews_snapshot")}}
    WHERE  DBT_VALID_TO IS NULL
       AND listing_id IN (SELECT listing_id FROM to_join_verified )
    GROUP BY listing_id, review_date
)
SELECT *
FROM reviews_raw
