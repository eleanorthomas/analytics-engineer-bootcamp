

WITH

source AS (
	SELECT
		od.order_id
		, od.product_id
		, o.customer_id
		, o.employee_id
		, o.shipper_id
		, od.quantity
		, od.unit_price
		, od.discount
		, od.status_id
		, od.date_allocated
		, od.purchase_order_id
		, od.inventory_id
		, o.order_date
		, o.shipped_date
		, o.paid_date
		, CURRENT_TIMESTAMP() AS insertion_timestamp
	FROM `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_orders` o
	LEFT JOIN `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_order_details` od
		ON o.id = od.order_id
	WHERE od.order_id IS NOT NULL
)

, unique_source AS (
	SELECT
		*
		, ROW_NUMBER() OVER(PARTITION BY customer_id, employee_id, order_id, product_id, shipper_id, purchase_order_id, order_date) AS row_number
	FROM source
)

SELECT
	*
EXCEPT
	(row_number)
FROM unique_source
WHERE row_number = 1