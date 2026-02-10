create materialized view ${catalog_name}.${stg_schema_name}.stg_erp_products
  (
    /* Data Quality*/
    constraint valid_product_pk_not_null expect (product_pk is not null) on violation fail update,
    constraint valid_supplier_fk_not_null expect (supplier_fk is not null) on violation fail update,
    constraint valid_category_fk_not_null expect (category_fk is not null) on violation fail update,
    constraint valid_product_name_not_null expect (product_name is not null)
  )
as

with
  source_products as (
    select *
    from ${catalog_name}.${raw_schema_name}.raw_erp_products
  )

  , renamed as (
    select
      cast(id as int) as product_pk
      , cast(supplierid as int) as supplier_fk
      , cast(categoryid as int) as category_fk
      , cast(productname as string) as product_name
      , cast(quantityperunit as string) as quantity_per_unit
      , cast(unitprice as numeric(18,2)) as unit_price
      , cast(unitsinstock as int) as units_in_stock
      , cast(unitsonorder as int) as units_on_order
      , cast(reorderlevel as int) as reorder_level
      , discontinued as is_discontinued
    from source_products
  )

select *
from renamed