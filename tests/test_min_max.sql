-- test la valeur de la cohérence du minimum et du maximum
-- ils doivent être supérieurs à 0 et le minimum doit est plus petit ou egal au maximum
SELECT *
FROM {{ source('raw_airbnb_data', "listings")  }}
WHERE minimum_nights <= 0
      OR maximum_nights <= 0
	  OR minimum_nights > maximum_nights  