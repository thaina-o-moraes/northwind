create materialized view ${catalog_name}.${mart_schema_name}.dim_employees as
with
    dim_shippers as (
        select *
        from ${catalog_name}.${int_schema_name}.int_employee__self_join_for_manager
    )

select *
from dim_shippers