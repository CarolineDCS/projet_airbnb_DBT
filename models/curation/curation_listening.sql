WITH
    to_join_verified AS
    (SELECT host_id
    FROM  {{ source('raw_airbnb_data', 'hosts')}} ),
    listings_raw AS 
	(SELECT 
		id AS listing_id,
		listing_url,
		name,
		description,
		description IS NOT NULL has_description,
		neighbourhood_overview,
		neighbourhood_overview IS NOT NULL AS has_neighrbourhood_description,
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
        try_cast(split_part(price, '$', 1) as float) as price,
		minimum_nights,
		maximum_nights
	FROM {{ source('raw_airbnb_data', 'listings')}}
    WHERE --DBT_VALID_TO IS NULL
       -- AND id IS NOT NULL
       AND listing_url IS NOT NULL
      AND LENGTH(listing_url) > 0
        AND (listing_url LIKE 'https://%'
        OR listing_url LIKE 'http://%')
		AND name IS NOT NULL
		AND host_id IN (SELECT host_id FROM to_join_verified) 
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
		AND beds IS NOT NULL 
        AND beds >0
		AND amenities IS NOT NULL
        AND price IS NOT NULL
        AND try_cast(split_part(price, '$', 2) as float)>0
        AND minimum_nights IS NOT NULL
        AND minimum_nights > 0
        AND maximum_nights IS NOT NULL
        AND maximum_nights > 0
		AND minimum_nights< maximum_nights    
    )
SELECT *
FROM listings_raw
