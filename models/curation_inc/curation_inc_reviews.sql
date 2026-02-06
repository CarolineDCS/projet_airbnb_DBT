{{
    config(
        database=var('inc_database'),
        schema=var('inc_schema'),
        materialized='incremental',
        unique_key=['listing_id','date']
    )
}}

WITH to_join_verified AS
    (SELECT listing_id
    FROM  {{ ref("curation_inc_listings")}} ),
raw_reviews AS (
    SELECT 
        listing_id,
        date AS review_date,
        count(*) AS number_reviews
    FROM {{ source('raw_airbnb_data', "reviews") }}
    WHERE listing_id IN (SELECT listing_id FROM to_join_verified )
        AND  date RLIKE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        AND date >= '1900-01-01'
        AND date <= current_date()
    GROUP BY listing_id, review_date
)
select *
from raw_reviews
{% if is_incremental() %}
WHERE load_timestamp > (select max(load_timestamp) from {{  this }} ) 
{% endif %}

