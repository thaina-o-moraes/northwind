CREATE MATERIALIZED VIEW ${catalog_name}.${stg_schema_name}.stg_erp_customers as
with
  source_customers as (
    select *
    from ${catalog_name}.${raw_schema_name}.raw_erp_customers 
  )

  , renamed as (
    select 
      cast(id as string) as customer_pk
      , cast(companyname as string) as customer_company_name
      , cast(contactname as string) as customer_contact_name
      , cast(contacttitle as string) as customer_contact_title
      , cast(address as string) as customer_address
      , cast(city as string) as suplier_city
      , cast(region as string) as customer_region
      , cast(postalcode as string) as customer_postalcode
      , cast(country as string) as customer_country
      , cast(phone as string) as customer_phone
      , cast(fax as string) as customer_fax
    from source_customers
  )

select *
from renamed