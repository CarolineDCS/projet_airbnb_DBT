{{
    config(
        database=var('inc_database'),
        schema=var('inc_schema'),
        materialized='incremental',
        unique_key='host_id'
    )
}}



with raw_hosts as (
    SELECT 
        LOAD_TIMESTAMP,
        host_id,
		CASE WHEN len(host_name) = 1 THEN 'Anonyme' ELSE host_name END AS host_name,
		host_since,
		host_location,
		SPLIT_PART(host_location, ',', 1) AS host_city,
		REPLACE(SPLIT_PART(host_location, ',', 2),' ','') AS host_country,
		TRY_CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) AS response_rate,
		host_is_superhost = 't' AS is_superhost,
		host_identity_verified = 't' AS is_identity_verified 
        FROM {{ source("raw_airbnb_data", "hosts") }}
          WHERE  host_id IS NOT NULL
        AND host_name IS NOT NULL
        AND host_since IS NOT NULL
        AND host_since RLIKE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        AND host_since >= '1900-01-01'
        AND host_since <= current_date()
        AND host_location IS NOT NULL
        AND host_location RLIKE '^[^0-9<>|\\?*",]+,[^0-9<>|\\?*",]+$'
        AND host_is_superhost IS NOT NULL
        AND (host_is_superhost LIKE 't' OR host_is_superhost LIKE 'f')
      	AND host_identity_verified IS NOT NULL
        AND (host_identity_verified LIKE 't' OR host_identity_verified LIKE 'f') 
      
)
select *
from raw_hosts
{% if is_incremental() %}
WHERE load_timestamp > (select max(load_timestamp) from {{  this }} ) 
{% endif %}
