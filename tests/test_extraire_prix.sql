{% macro test_extraire_prix() %}
  {% set test_cases = [
    {'input': '$ 1,234.56', 'symbol': '$', 'expected': 1234.56},
    {'input': '1,234.56 $', 'symbol': '$', 'expected': 1234.56},
    {'input': '€ 1.234,56', 'symbol': '€', 'expected': 1234.56},
    {'input': 'invalid', 'symbol': '$', 'expected': null}
  ] %}

  {% for test in test_cases %}
    {% set result = extraire_prix_a_partir_dun_caractere(test.input, test.symbol) %}
    -- Debug : log pour voir le résultat 
    {{ log("Test: '" ~ test.input ~ "' -> " ~ result ~ " (expected: " ~ test.expected ~ ")", info=true) }}
  {% endfor %}
{% endmacro %}