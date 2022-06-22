WITH

source AS (
	SELECT
		id AS inventory_id
		, transaction_type
		, transaction_created_date
		, transaction_modified_date
		, product_id
		, quantity
		, purchase_order_id
		, customer_order_id
		, comments
		, CURRENT_TIMESTAMP() AS insertion_timestamp
	FROM {{ ref('stg_inventory_transactions') }}
)

, unique_source AS (
	SELECT
		*
		, ROW_NUMBER() OVER(PARTITION BY inventory_id) AS row_number
	FROM source
)

SELECT
	*
EXCEPT
	(row_number)
FROM unique_source
WHERE row_number = 1