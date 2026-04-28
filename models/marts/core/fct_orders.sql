WITH orders AS (

    SELECT *
    FROM {{ ref('stg_postgre_db__orders') }}

),

order_items AS (

    SELECT *
    FROM {{ ref('stg_postgre_db__order_items') }}

),

order_items_aggregated AS (

    SELECT
        order_id,
        COUNT(DISTINCT product_id) AS distinct_products_count,
        SUM(quantity) AS total_items_quantity
    FROM order_items
    GROUP BY order_id

),

final AS (

    SELECT
        o.order_id,
        o.user_id,
        o.address_id,
        o.promo_id,

        o.created_at AS order_created_at,
        o.estimated_delivery_at,
        o.delivered_at,

        o.status AS order_status,
        o.shipping_service,
        o.tracking_id,

        o.order_cost,
        o.shipping_cost,
        o.order_total,

        COALESCE(oi.distinct_products_count, 0) AS distinct_products_count,
        COALESCE(oi.total_items_quantity, 0) AS total_items_quantity

    FROM orders o
    LEFT JOIN order_items_aggregated oi
        ON o.order_id = oi.order_id

)

SELECT * FROM final