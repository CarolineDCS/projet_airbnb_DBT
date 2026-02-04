{% snapshot listings_snapshot %}

    {{
        config(
          target_database='airbnb',
          target_schema='snapshots',
          strategy='check',
          check_cols='all',
          unique_key='id'
        )
    }}

    SELECT * 
    FROM {{ source('raw_airbnb_data', "listings") }}
    WHERE  id IS NOT NULL
       AND listing_url IS NOT NULL
      AND LENGTH(listing_url) > 0
        AND (listing_url LIKE 'https://%'
        OR listing_url LIKE 'http://%')
		AND name IS NOT NULL
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
		AND neighbourhood_cleansed IS NOT NULL 
		AND amenities IS NOT NULL
        AND price IS NOT NULL
        AND price RLIKE  '^\\$[[:space:]]*[0-9]{1,3}(,[0-9]{3})*(\\.[0-9]{0,2})?$'
        AND  trim(try_to_double(REPLACE(split_part(price, '$', 2), ',', ''))) >0
        AND minimum_nights IS NOT NULL
        AND minimum_nights > 0
        AND maximum_nights IS NOT NULL
        AND maximum_nights > 0
		AND minimum_nights<= maximum_nights    


{% endsnapshot %}
