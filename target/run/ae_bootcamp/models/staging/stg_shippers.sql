

  create or replace table `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_shippers`
  
  
  OPTIONS()
  as (
    WITH

source AS (
	SELECT * FROM `ae-bootcamp-eleanor`.`dl_northwind`.`shippers`
)

SELECT
	*
	, CURRENT_TIMESTAMP() AS ingestion_timestamp

FROM source
  );
  