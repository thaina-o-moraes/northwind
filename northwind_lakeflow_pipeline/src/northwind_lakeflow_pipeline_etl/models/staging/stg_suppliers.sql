create materialized view ${catalog_name}.${stg_schema_name}.stg_erp_suppliers
  (
    /* Data Quality*/
    constraint valid_supplier_pk_not_null expect (supplier_pk is not null) on violation fail update,
    constraint valid_name_not_null expect (supplier_company_name is not null) on violation fail update
  )
as 

with
  source_suppliers as (
    select *
    from ${catalog_name}.${raw_schema_name}.raw_erp_suppliers
  )

  , renamed as (
    select 
      cast(id as int) as supplier_pk
      , cast(companyname as string) as supplier_company_name
      , cast(contactname as string) as supplier_contact_name
      , cast(contacttitle as string) as supplier_contact_title
      , cast(address as string) as supplier_address
      , cast(city as string) as supplier_city
      , cast(region as string) as supplier_region
      , cast(postalcode as string) as supplier_postalcode
      , cast(country as string) as supplier_country
      , cast(phone as string) as supplier_phone
      , cast(fax as string) as supplier_fax
      , cast(homepage as string) as supplier_homepage
    from source_suppliers
  )

select *
from renamed