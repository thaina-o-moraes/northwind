create materialized view ${catalog_name}.${mart_schema_name}.dim_products as
with
    dim_products as (
        select *
        from ${catalog_name}.${int_schema_name}.int_products__enriched
    )

select *
from dim_products