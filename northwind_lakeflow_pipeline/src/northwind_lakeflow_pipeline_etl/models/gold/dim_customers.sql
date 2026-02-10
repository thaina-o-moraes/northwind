create materialized view ${catalog_name}.${mart_schema_name}.dim_customers
  (      
    /*  ──────────── Documentation ──────────── */
    customer_pk string comment 'Unique identifier for the customer',
    customer_company_name string comment 'Company name',
    customer_contact_name string comment 'Customer name',
    customer_contact_title string comment 'Customer title',
    customer_address string comment 'Customer address',
    suplier_city string comment 'Suplier city',
    customer_region string comment 'Customer region',
    customer_postalcode string comment 'Customer postal code',
    customer_country string comment 'Customer country',
    customer_phone string comment 'Customer phone',
    customer_fax string comment 'Customer fax',
  
    /*  ──────────── Data Quality ──────────── */
    constraint valid_pk_not_null expect (customer_pk is not null) on violation fail update,
    constraint valid_name_not_null expect (customer_company_name is not null),
    /* Databricks does not enforce primary key or foreign key constraints
    the purpose is to provide metadata about your data model to the system */
    constraint valid_category_pk primary key(customer_pk)      
  )
  comment 'Dimension table for customers containing registration data.'
as
with
  dim_customers as (
      select *
      from ${catalog_name}.${stg_schema_name}.stg_erp_customers
  )

select *
from dim_customers