{{
    config(
        schema=var("curation_schema","curation_dev"),
        materialized='ephemeral'
    )
}}

SELECT 
    {{ pct_distribution('63', '156') }} as test_result 