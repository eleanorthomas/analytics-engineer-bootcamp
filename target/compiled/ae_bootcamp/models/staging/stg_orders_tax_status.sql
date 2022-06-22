WITH

source AS (
	SELECT * FROM `ae-bootcamp-eleanor`.`dl_northwind`.`orders_tax_status`
)

SELECT
	*
	, CURRENT_TIMESTAMP() AS ingestion_timestamp

FROM source