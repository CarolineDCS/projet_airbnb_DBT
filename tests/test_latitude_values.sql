{{ config(store_failures = true) }}
-- test la valeur de la latitude dans l'intervalle [-90.0,90]
SELECT *
FROM {{ source('raw_airbnb_data', "listings")  }}
WHERE  latitude < -90.0
        OR latitude > 90.0