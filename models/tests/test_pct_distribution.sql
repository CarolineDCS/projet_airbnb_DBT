{{
    config(
        schema=var("curation_schema","curation_dev"),
        materialized='table'
    )
}}

SELECT 
    {{ pct_distribution('63', '156') }} as test_result 