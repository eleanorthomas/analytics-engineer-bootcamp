WITH

source AS (
	SELECT * FROM `ae-bootcamp-eleanor`.`dl_northwind`.`order_details_status`
)

SELECT
	*
	, CURRENT_TIMESTAMP() AS ingestion_timestamp

FROM source