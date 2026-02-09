create materialized view ${catalog_name}.${mart_schema_name}.fct_orders as
with
    orders_metrics (
        select *
        from ${catalog_name}.${stg_schema_name}.stg_erp_shippers
    )

select *
from orders_metrics