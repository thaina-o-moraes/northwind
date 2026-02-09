create materialized view ${catalog_name}.${mart_schema_name}.dim_shippers as
with
    dim_shippers as (
        select *
        from ${catalog_name}.${stg_schema_name}.stg_erp_shippers
    )

select *
from dim_shippers