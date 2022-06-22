

  create or replace table `ae-bootcamp-eleanor`.`dbt_eleanor_dwh_northwind`.`fact_purchase_order`
  
  
  OPTIONS()
  as (
    WITH

source AS (
	SELECT
		c.id AS customer_id
		, e.id AS employee_id
		, pod.purchase_order_id
		, pod.product_id
		, pod.quantity
		, pod.unit_cost
		, pod.date_received
		, pod.posted_to_inventory
		, pod.inventory_id
		, po.supplier_id
		, po.created_by
		, po.submitted_date
		, po.creation_date
		, po.status_id
		, po.expected_date
		, po.shipping_fee
		, po.taxes
		, po.payment_date
		, po.payment_amount
		, po.payment_method
		, po.notes
		, po.approved_by
		, po.approved_date
		, po.submitted_by
		, CURRENT_TIMESTAMP() AS insertion_timestamp
	FROM `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_purchase_orders` po
	LEFT JOIN `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_purchase_order_details` pod
		ON po.id = pod.purchase_order_id
	LEFT JOIN `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_products` p
		ON pod.product_id = p.id
	LEFT JOIN `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_order_details` od
		ON p.id = od.product_id
	LEFT JOIN `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_orders` o
		ON od.order_id = o.id
	LEFT JOIN `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_employees` e
		ON po.created_by = e.id
	LEFT JOIN `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_customer` c
		ON o.customer_id = c.id
	WHERE o.customer_id IS NOT NULL
)

, unique_source AS (
	SELECT
		*
		, ROW_NUMBER() OVER(PARTITION BY customer_id, employee_id, purchase_order_id, product_id, inventory_id, supplier_id, creation_date) AS row_number
	FROM source
)

SELECT
	*
EXCEPT
	(row_number)
FROM unique_source
WHERE row_number = 1
  );
  