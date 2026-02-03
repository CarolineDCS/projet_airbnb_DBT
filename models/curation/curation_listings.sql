{{
    config(
        schema=var("curation_schema","curation")
    )
}}
WITH
    to_join_verified AS
    (SELECT host_id
    FROM  {{ ref("curation_hosts")}} ),
    listings_raw AS 
	(SELECT 
		id AS listing_id,
		listing_url,
		name,
		description,
		description IS NOT NULL AS has_description,
		neighbourhood_overview,
		neighbourhood_overview IS NOT NULL AS has_neighbourhood_description,
		host_id,
		latitude,
		longitude,
		property_type,
		room_type,
		accommodates,
		bathrooms,
		bedrooms,
		beds,
		amenities,
        {{ extraire_prix_a_partir_dun_caractere('price', '$') }} as price,
        maximum_nights
	FROM {{ ref("listings_snapshot")}}
    WHERE DBT_VALID_TO IS NULL
    AND host_id IN (SELECT host_id FROM to_join_verified) 
    )
SELECT *
FROM listings_raw
