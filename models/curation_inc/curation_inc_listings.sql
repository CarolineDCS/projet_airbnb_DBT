{{
    config(
        database=var('inc_database'),
        schema=var('inc_schema'),
        materialized='incremental',
        unique_key='listing_id'
    )
}}

WITH
    to_join_verified AS
    (SELECT host_id
    FROM  {{ ref("curation_inc_hosts")}} 
    ),
    raw_listings AS 
	(SELECT 
        LOAD_TIMESTAMP,
		id AS listing_id,
		listing_url,
		name,
		description,
		description IS NOT NULL AS has_description,
		neighbourhood_overview,
		neighbourhood_overview IS NOT NULL AS has_neighbourhood_description,
		host_id,
        neighbourhood_cleansed,
		latitude,
		longitude,
		property_type,
		room_type,
		accommodates,
		bathrooms,
		bedrooms,
		amenities,
        {{ extraire_prix_a_partir_dun_caractere('price', '$') }} as price,
        minimum_nights,
        maximum_nights
    FROM {{ source('raw_airbnb_data', "listings") }}
    WHERE  id IS NOT NULL
       AND listing_url IS NOT NULL
      AND LENGTH(listing_url) > 0
        AND (listing_url LIKE 'https://%'
        OR listing_url LIKE 'http://%')
		AND name IS NOT NULL
		AND neighbourhood_cleansed IS NOT NULL
        AND latitude IS NOT NULL
        AND latitude >= -90.0
        AND latitude <= 90.0
        AND longitude >= -180.0
        AND longitude <= 180.0
		AND property_type IS NOT NULL
		AND room_type IS NOT NULL
		AND accommodates IS NOT NULL
        AND accommodates > 0
		AND bathrooms IS NOT NULL
        AND bathrooms >=0
        AND bedrooms IS NOT NULL
        AND bedrooms >0
		AND amenities IS NOT NULL
        AND price IS NOT NULL
        AND price RLIKE  '^\\$[[:space:]]*[0-9]{1,3}(,[0-9]{3})*(\\.[0-9]{0,2})?$'
        AND  trim(try_to_double(REPLACE(split_part(price, '$', 2), ',', ''))) >0
        AND minimum_nights IS NOT NULL
        AND minimum_nights > 0
        AND maximum_nights IS NOT NULL
        AND maximum_nights > 0
		AND minimum_nights<= maximum_nights 
        AND host_id IN (SELECT host_id FROM to_join_verified) 
)
select *
from raw_listings
{% if is_incremental() %}
WHERE load_timestamp > (select max(load_timestamp) from {{  this }} ) 
{% endif %}

