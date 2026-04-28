WITH users AS (

    SELECT *
    FROM {{ ref('stg_postgre_db__users') }}

),

addresses AS (

    SELECT *
    FROM {{ ref('stg_postgre_db__addresses') }}

),

final AS (

    SELECT
        u.user_id,
        u.first_name,
        u.last_name,
        CONCAT(u.first_name, ' ', u.last_name) AS full_name,
        u.email,
        u.phone_number,

        u.created_at AS user_created_at,
        u.updated_at AS user_updated_at,
        u.total_orders,

        u.address_id,
        a.address,
        a.zipcode,
        a.state,
        a.country

    FROM users u
    LEFT JOIN addresses a
        ON u.address_id = a.address_id

)

SELECT * FROM final