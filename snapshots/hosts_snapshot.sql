{% snapshot hosts_snapshot %}

    {{
        config(
          target_database='airbnb',
          target_schema='snapshots',
          strategy='check',
          check_cols='all',
          unique_key='host_id'
        )
    }}

    SELECT * 
    FROM {{ source('raw_airbnb_data', 'hosts') }}
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
        AND host_neighbourhood IS NOT NULL
		AND host_identity_verified IS NOT NULL
        AND (host_identity_verified LIKE 't' OR host_identity_verified LIKE 'f') 

{% endsnapshot %}
