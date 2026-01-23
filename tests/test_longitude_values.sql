-- test la valeur de la longitude dans l'intervalle [-180.0,180.0]
SELECT *
FROM {{ ref('listening_snapshot') }}
WHERE  longitude < -180.0
        OR longitude >180.0