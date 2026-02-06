-- test si la date host_since de la table host est au bon format aaaa-nn-dd
{{ config(store_failures = true) }}

SELECT *
FROM {{ ref('hosts_snapshot') }}
WHERE host_since NOT RLIKE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        OR host_since < '1900-01-01'
        OR host_since > current_date()