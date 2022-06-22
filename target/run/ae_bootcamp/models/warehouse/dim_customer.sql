

  create or replace table `ae-bootcamp-eleanor`.`dbt_eleanor_dwh_northwind`.`dim_customer`
  
  
  OPTIONS()
  as (
    WITH

source AS (
	SELECT
		id AS customer_id
		, company
		, last_name
		, first_name
		, email_address
		, job_title
		, business_phone
		, home_phone
		, mobile_phone
		, fax_number
		, address
		, city
		, state_province
		, zip_postal_code
		, country_region
		, web_page
		, notes
		, attachments
		, CURRENT_TIMESTAMP() AS ingestion_timestamp
	FROM `ae-bootcamp-eleanor`.`dbt_eleanor_stg_northwind`.`stg_customer`
)

, unique_source AS (
	SELECT
		*
		, ROW_NUMBER() OVER(PARTITION BY customer_id) AS row_number
	FROM source
)

SELECT
	*
EXCEPT
	(row_number)
FROM unique_source
WHERE row_number = 1
  );
  