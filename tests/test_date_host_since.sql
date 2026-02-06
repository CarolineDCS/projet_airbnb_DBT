-- test si la date host_since de la table host est valide 
-- pas trop loin dans le passé, pas dans le futur et au bon format aaaa-nn-dd
{{ config(store_failures = true) }}

SELECT *
FROM {{source('raw_airbnb_data', 'hosts')}}
WHERE host_since NOT RLIKE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
     OR host_since < '1900-01-01'
        OR host_since > current_date()