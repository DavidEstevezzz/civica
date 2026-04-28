{{ config(materialized='view') }}

WITH src_orders AS (

    SELECT *
    FROM {{ source('postgre_db', 'orders') }}

),

renamed_casted AS (

    SELECT
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced AS date_load
    FROM src_orders

)

SELECT * FROM renamed_casted