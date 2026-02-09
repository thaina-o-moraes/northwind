create materialized view ${catalog_name}.${int_schema_name}.int_orders__metrics as
with
  order_items_metrics as (
    select *
    from ${catalog_name}.${int_schema_name}.int_order_items__metrics
  )

  , aggregated_line_metrics as (
    select
      order_pk
      , sum(quantity) as total_quantity
      , sum(gross_total) as gross_total
      , sum(net_total) as net_total
      , count(*) as line_item_count
      , max(case when had_discount then 1 else 0 end) as had_discount_flag
    from order_items_metrics
    group by order_pk
  )

  , orders as (
    select *
    from ${catalog_name}.${stg_schema_name}.stg_erp_orders
  )

select
  orders.order_pk
  , orders.order_number
  , orders.employee_fk
  , orders.customer_fk
  , orders.shipper_fk
  , orders.order_date
  , orders.ship_date
  , orders.required_delivery_date
  , orders.freight as freight_total
  , coalesce(aggregated_line_metrics.total_quantity, 0) as total_quantity
  , coalesce(aggregated_line_metrics.gross_total, 0) as gross_total
  , coalesce(aggregated_line_metrics.net_total, 0) as net_total
  , coalesce(aggregated_line_metrics.line_item_count, 0) as line_item_count
  , coalesce(aggregated_line_metrics.had_discount_flag, 0) as had_discount_flag
  , orders.recipient_name
  , orders.recipient_city
  , orders.recipient_region
  , orders.recipient_country
from orders
left join aggregated_line_metrics
  on aggregated_line_metrics.order_pk = orders.order_pk