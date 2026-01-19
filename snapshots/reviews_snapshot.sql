{% snapshot reviews_snapshot %}

    {{
        config(
          target_database='airbnb',
          target_schema='snapshots',
          strategy='check',
          check_cols='all',
          unique_key=['listing_id','date']
        )
    }}

    select * from {{ source('raw_airbnb_data', "reviews") }}

{% endsnapshot %}