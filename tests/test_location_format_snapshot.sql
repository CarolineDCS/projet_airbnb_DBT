{{ config(store_failures = true) }}
-- test si la location du snapshot la table hosts est au bon format * , *
SELECT *
FROM {{ ref("hosts_snapshot") }}
WHERE host_location NOT RLIKE '^[^0-9<>|\\?*",]+,[^0-9<>|\\?*",]+$'