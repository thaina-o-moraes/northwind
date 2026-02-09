create materialized view ${catalog_name}.${stg_schema_name}.stg_erp_orders_detail as
with
  source_orders_detail as (
    select *
    from ${catalog_name}.${raw_schema_name}.raw_erp_orders_detail
  )
  
  , renamed as (
    select 
      cast(orderid as int) as order_item_pk
      , cast(productid as int) as product_fk
      , cast(unitprice as double) as unit_price
      , cast(quantity as int) as quantity
      , cast(discount as double) as discount_pct
    from source_orders_detail
  )

select *
from renamed