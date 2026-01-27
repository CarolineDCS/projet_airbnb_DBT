{{ config(store_failures = true) }}
-- test la valeur de la longitude dans l'intervalle [-180.0,180.0]
SELECT *
FROM {{ source('raw_airbnb_data', "listings")  }}
WHERE  longitude < -180.0
        OR longitude >180.0