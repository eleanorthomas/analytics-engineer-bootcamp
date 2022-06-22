

  create or replace table `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_inventory_transaction_types`
  
  
  OPTIONS()
  as (
    WITH

source AS (
	SELECT * FROM `ae-bootcamp-eleanor`.`dl_northwind`.`inventory_transaction_types`
)

SELECT
	*
	, CURRENT_TIMESTAMP() AS ingestion_timestamp

FROM source
  );
  