-- test si la location de la table curation_host est au bon format * , *
SELECT *
FROM {{ref('hosts_snapshot')}}
WHERE host_location NOT RLIKE '^[^0-9<>|\\?*",]+,[^0-9<>|\\?*",]+$'