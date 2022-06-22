WITH

source AS (
	SELECT * FROM `ae-bootcamp-eleanor`.`dl_northwind`.`invoices`
)

SELECT
	*
	, CURRENT_TIMESTAMP() AS ingestion_timestamp

FROM source