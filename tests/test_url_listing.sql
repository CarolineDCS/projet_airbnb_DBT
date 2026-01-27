{{ config(store_failures = true) }}
-- test le format de l'url du listening
SELECT *
FROM {{ source('raw_airbnb_data', "listings")  }}
WHERE (listing_url NOT LIKE 'https://%'
        AND listing_url NOT LIKE 'http://%')