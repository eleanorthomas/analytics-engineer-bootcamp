WITH

source AS (
	SELECT * FROM `ae-bootcamp-eleanor`.`dl_northwind`.`employees`
)

SELECT
	*
	, CURRENT_TIMESTAMP() AS ingestion_timestamp

FROM source