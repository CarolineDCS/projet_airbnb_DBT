-- test si la date host_since est valide 
-- pas dans le futur, pas trop loin dans le passé et au bon format 
SELECT *
FROM {{ref('reviews_snapshot')}}
WHERE date NOT RLIKE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
      OR date < '1900-01-01'
      OR date > current_date()