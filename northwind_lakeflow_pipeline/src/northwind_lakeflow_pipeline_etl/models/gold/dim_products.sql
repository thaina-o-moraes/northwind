create materialized view ${catalog_name}.${mart_schema_name}.dim_products
 (      
    /*  ──────────── Documentation ──────────── */
    product_pk integer comment 'Unique identifier for the product',
    product_name string comment 'Full commercial name of the product',
    quantity_per_unit string comment 'Quantity and unit of measure per product package',
    unit_price decimal(18,2) comment 'Current price per unit of the product',
    units_in_stock integer comment 'Current quantity of physical stock available',
    units_on_order integer comment 'Quantity of units currently ordered from suppliers but not yet received',
    reorder_level integer comment 'Minimum stock level threshold to trigger a new order',
    is_discontinued boolean comment 'Flag indicating if the product is no longer available for sale',
    category_name string comment 'Name of the category the product belongs to',
    supplier_company_name string comment 'Name of the company supplying the product',
    supplier_city string comment 'City where the supplier is located',
    supplier_country string comment 'Country where the supplier is located'

    /*  ──────────── Data Quality ──────────── */
    constraint valid_pk_not_null expect (product_pk is not null) on violation fail update,
    constraint valid_name_not_null expect (product_name is not null),
    /* Databricks does not enforce primary key or foreign key constraints
    the purpose is to provide metadata about your data model to the system */
    constraint valid_product_pk primary key(product_pk)      
  )
  comment 'Product dimension table containing inventory levels, pricing, status, and enriched with supplier and category details.'
as

with
    dim_products as (
        select *
        from ${catalog_name}.${int_schema_name}.int_products__enriched
    )

select *
from dim_products