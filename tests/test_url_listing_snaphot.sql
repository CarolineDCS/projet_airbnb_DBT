{{ config(store_failures = true) }}
-- test le format de l'url du listening
SELECT *
FROM {{ ref("listings_snapshot")  }}
WHERE (listing_url NOT LIKE 'https://%'
        AND listing_url NOT LIKE 'http://%')