create materialized view ${catalog_name}.${mart_schema_name}.dim_shippers
    (
    /*  ──────────── Documentation ──────────── */
    shippers_pk int comment 'Unique identifier for the shipping company',
    shipper_company_name string comment 'Commercial name of the shipping company',
    shipper_phone string comment 'Contact phone number for the shipping company'

    /*  ──────────── Data Quality ──────────── */
    constraint valid_pk_not_null expect (shippers_pk is not null) on violation fail update,
    constraint valid_name_not_null expect (shipper_company_name is not null),
    /* Databricks does not enforce primary key or foreign key constraints
    the purpose is to provide metadata about your data model to the system */
    constraint valid_shippers_pk primary key(shippers_pk)      
  )
  comment 'Dimension table containing details of shipping companies responsible for transporting orders.'
as

with
    dim_shippers as (
        select *
        from ${catalog_name}.${stg_schema_name}.stg_erp_shippers
    )

select *
from dim_shippers