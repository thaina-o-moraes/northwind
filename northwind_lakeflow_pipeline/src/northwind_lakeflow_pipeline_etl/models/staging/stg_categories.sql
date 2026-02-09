create materialized view ${catalog_name}.${stg_schema_name}.stg_erp_categories as
with
  source_categories as (
    select *
    from ${catalog_name}.${raw_schema_name}.raw_erp_categories
  )
  
  , renamed as (
    select 
      cast(id as int) as category_pk
      , cast(categoryname as string) as category_name
      , cast(description as string) as description
    from source_categories
  )

select *
from renamed