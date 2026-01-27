-- test le format du prix  dddddd.ddd
--  [espace] .ddd
SELECT *
FROM {{ source('raw_airbnb_data', "listings")  }}
WHERE price NOT RLIKE  '^\\$[[:space:]]*[0-9]{1,3}(,[0-9]{3})*(\\.[0-9]{0,2})?$'