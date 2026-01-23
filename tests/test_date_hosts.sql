SELECT *
FROM {{ ref('stg_orders') }}
WHERE order_date > current_date
