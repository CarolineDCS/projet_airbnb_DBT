-- test si la date host_since de la table host est valide 
-- pas trop loin dans le passé, pas dans le futur et au bon format aaaa-nn-dd
SELECT *
FROM {{ref('hosts_snapshot')}}
WHERE host_since < '1900-01-01'
      OR host_since > current_date()
      OR host_since NOT RLIKE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'