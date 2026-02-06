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
		l.id AS listing_id,
		l.listing_url,
		l.name,
		l.description,
		l.description IS NOT NULL AS has_description,
		l.neighbourhood_overview,
		l.neighbourhood_overview IS NOT NULL AS has_neighbourhood_description,
		l.host_id,
		l.neighbourhood_cleansed,
		l.latitude,
		l.longitude,
		l.property_type,
		l.room_type,
		l.accommodates,
		l.bathrooms,
		l.bedrooms,
		l.amenities,
        {{ extraire_prix_a_partir_dun_caractere('l.price', '$') }} as price,
		l.minimum_nights,
        l.maximum_nights
	FROM {{ ref("listings_snapshot")}} as l
    INNER JOIN to_join_verified as h
    ON l.host_id = h.host_id
    WHERE DBT_VALID_TO IS NULL
    -- un IN entraine un changement de type sous snowflake
    )
SELECT *
FROM listings_raw
