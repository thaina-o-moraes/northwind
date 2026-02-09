create materialized view ${catalog_name}.${int_schema_name}.int_order_items__metrics as
with
  orders as (
      select *
      from ${catalog_name}.${stg_schema_name}.stg_erp_orders
  )

  , orders_detail as (
      select *
      from ${catalog_name}.${stg_schema_name}.stg_erp_orders_detail
  )

  , joined as (
    select
      orders_detail.order_item_pk
      , orders.order_pk
      , orders_detail.product_fk
      , orders.employee_fk
      , orders.customer_fk
      , orders.shipper_fk
      , orders.order_date
      , orders.ship_date
      , orders.required_delivery_date
      , orders_detail.discount_pct
      , orders_detail.unit_price
      , orders_detail.quantity
      , orders.freight
      , orders.order_number
      , orders.recipient_name
      , orders.recipient_city
      , orders.recipient_region
      , orders.recipient_country
    from orders_detail
    left join orders
      on orders_detail.order_item_pk = orders.order_pk
  )

  , metrics as (
    select
      order_item_pk
      , order_pk
      , product_fk
      , employee_fk
      , customer_fk
      , shipper_fk
      , order_date
      , ship_date
      , required_delivery_date
      , discount_pct
      , unit_price
      , quantity
      , unit_price * quantity as gross_total
      , unit_price * (1 - discount_pct) * quantity as net_total
      , cast((freight / count(*) over (partition by order_number)) as numeric(18,2)) as freight_allocated
      , case
          when discount_pct > 0 then true
          else false
      end as had_discount
      , order_number
      , recipient_name
      , recipient_city
      , recipient_region
      , recipient_country
    from joined
  )

select *
from metrics