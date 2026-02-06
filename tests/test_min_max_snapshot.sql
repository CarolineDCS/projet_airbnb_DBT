{{ config(store_failures = true) }}
-- test la valeur de la cohérence du minimum et du maximum
-- ils doivent être supérieurs à 0 et le minimum doit est plus petit ou egal au maximum
SELECT *
FROM {{ ref("listings_snapshot")  }}
WHERE minimum_nights > maximum_nights  