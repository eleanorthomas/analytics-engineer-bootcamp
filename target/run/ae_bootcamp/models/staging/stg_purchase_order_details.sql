

  create or replace table `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_purchase_order_details`
  
  
  OPTIONS()
  as (
    WITH

source AS (
	SELECT * FROM `ae-bootcamp-eleanor`.`dl_northwind`.`purchase_order_details`
)

SELECT
	*
	, CURRENT_TIMESTAMP() AS ingestion_timestamp

FROM source
  );
  