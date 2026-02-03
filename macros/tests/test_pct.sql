{% macro test_pct_distribution() %}
-- pour tester la fonction pct_distribution
    SELECT {{ pct_distribution('63', '156') }} as result
{% endmacro %} 