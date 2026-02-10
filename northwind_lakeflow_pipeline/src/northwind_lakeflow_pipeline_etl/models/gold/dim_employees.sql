create materialized view ${catalog_name}.${mart_schema_name}.dim_employees
  (      
    /*  ──────────── Documentation ──────────── */
    employee_pk integer comment 'Unique identifier for the employee',
    employee_name string comment 'Full name of the employee',
    employee_title string comment 'Job title or position of the employee',
    manager_name string comment 'Name of the employee\'s direct manager',
    employee_birth_date date comment 'Date of birth of the employee',
    employee_hire_date date comment 'Date the employee was hired',
    employee_city string comment 'City of residence or office location',
    employee_region string comment 'Region or state of the employee',
    employee_country string comment 'Country of residence or office location'
  
    /*  ──────────── Data Quality ──────────── */
      constraint valid_pk_not_null expect (employee_pk is not null) on violation fail update,
      constraint valid_name_not_null expect (employee_name is not null),
      /* Databricks does not enforce primary key or foreign key constraints
      the purpose is to provide metadata about your data model to the system */
      constraint valid_employee_pk primary key(employee_pk)     
  )
  comment 'Contains enriched employee data including hierarchy (manager), location attributes, and hiring details.'
as
with
    dim_shippers as (
        select *
        from ${catalog_name}.${int_schema_name}.int_employee__self_join_for_manager
    )

select *
from dim_shippers