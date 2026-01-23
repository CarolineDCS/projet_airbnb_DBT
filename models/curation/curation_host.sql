WITH hosts_raw AS (
    SELECT
		host_id,
		CASE WHEN len(host_name) = 1 THEN 'Anonyme' ELSE host_name END AS host_name,
		host_since,
		host_location,
		SPLIT_PART(host_location, ',', 1) AS host_city,
		REPLACE(SPLIT_PART(host_location, ',', 2),' ','') AS host_country,
		TRY_CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) AS response_rate,
		host_is_superhost = 't' AS is_superhost,
		host_neighbourhood,
		host_identity_verified = 't' AS is_identity_verified
    FROM {{ref("hosts_snapshot")}}
    WHERE --DBT_VALID_TO IS NULL
       -- AND 
       host_id IS NOT NULL
        AND host_name IS NOT NULL
        AND host_since IS NOT NULL
        AND host_since RLIKE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        AND host_since >= '1900-01-01'
        AND host_since <= current_date()
        AND host_location IS NOT NULL
        AND host_location RLIKE '^[^0-9<>|\\?*",]+,[^0-9<>|\\?*",]+$'
        AND host_is_superhost IS NOT NULL
        AND (host_is_superhost LIKE 't' OR host_is_superhost LIKE 'f')
        AND host_neighbourhood IS NOT NULL
		AND host_identity_verified IS NOT NULL
        AND (host_identity_verified LIKE 't' OR host_identity_verified LIKE 'f') 
    )
SELECT *
from hosts_raw




