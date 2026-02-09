create materialized view ${catalog_name}.${stg_schema_name}.stg_erp_orders as
with
  source_orders as (
    select *
    from ${catalog_name}.${raw_schema_name}.raw_erp_orders
  )
  
  , renamed as (
    select 
      cast(id as int) as order_pk
      , cast(id as int) as order_number
      , cast(customerid as string) as customer_fk
      , cast(employeeid as int) as employee_fk
      , cast(orderdate as date) as order_date
      , cast(requireddate as date) as required_delivery_date
      , cast(shippeddate as date) as ship_date
      , cast(shipvia as string) as shipper_fk
      , cast(freight as double) as freight
      , cast(shipname as string) as recipient_name
      , cast(shipaddress as string) as shipaddress
      , cast(shipcity as string) as recipient_city
      , cast(shipregion as string) as recipient_region
      , cast(shippostalcode as string) as shippostalcode
      , cast(shipcountry as string) as recipient_country
    from source_orders
  )

select *
from renamed