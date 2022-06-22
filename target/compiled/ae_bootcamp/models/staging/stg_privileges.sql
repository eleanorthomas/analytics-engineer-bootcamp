WITH

source AS (
	SELECT * FROM `ae-bootcamp-eleanor`.`dl_northwind`.`privileges`
)

SELECT
	*
	, CURRENT_TIMESTAMP() AS ingestion_timestamp

FROM source