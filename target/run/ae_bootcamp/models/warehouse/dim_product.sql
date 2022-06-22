

  create or replace table `ae-bootcamp-eleanor`.`dbt_eleanor_dwh_northwind`.`dim_product`
  
  
  OPTIONS()
  as (
    WITH

source AS (
	SELECT
		p.id AS product_id
		, p.product_code
		, p.product_name
		, p.description
		, s.company AS supplier_company
		, p.standard_cost
		, p.list_price
		, p.reorder_level
		, p.target_level
		, p.quantity_per_unit
		, p.discontinued
		, p.minimum_reorder_quantity
		, p.category
		, p.attachments
		, CURRENT_TIMESTAMP() AS ingestion_timestamp
	FROM `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_products` p
	LEFT JOIN `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_suppliers` s
		ON s.id = p.supplier_id
)

, unique_source AS (
	SELECT
		*
		, ROW_NUMBER() OVER(PARTITION BY product_id) AS row_number
	FROM source
)

SELECT
	*
EXCEPT
	(row_number)
FROM unique_source
WHERE row_number = 1
  );
  