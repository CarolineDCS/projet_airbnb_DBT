{{ config(store_failures = true) }}
-- test si la location de la table hosts est au bon format * , *
SELECT *
FROM {{source('raw_airbnb_data', 'hosts')}}
WHERE host_location NOT RLIKE '^[^0-9<>|\\?*",]+,[^0-9<>|\\?*",]+$'