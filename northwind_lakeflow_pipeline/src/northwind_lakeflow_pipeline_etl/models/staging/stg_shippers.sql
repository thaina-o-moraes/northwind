create materialized view ${catalog_name}.${stg_schema_name}.stg_erp_shippers
  (
    /* Data Quality*/
    constraint valid_shippers_pk_not_null expect (shippers_pk is not null) on violation fail update,
    constraint valid_name_not_null expect (shipper_company_name is not null) on violation fail update
  )
as 

with
  source_shippers as (
    select *
    from ${catalog_name}.${raw_schema_name}.raw_erp_shippers
  )

  , renamed as (
    select 
      cast(id as int) as shippers_pk
      , cast(companyname as string) as shipper_company_name
      , cast(phone as string) as shipper_phone
    from source_shippers
  )

select *
from renamed