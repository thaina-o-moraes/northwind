create materialized view ${catalog_name}.${int_schema_name}.int_employee__self_join_for_manager as
with
  employees as (
    select *
    from ${catalog_name}.${stg_schema_name}.stg_erp_employees
  )

  , self_joined as (
    select
      employees.employee_pk
      , employees.employee_name
      , employees.employee_title
      , managers.employee_name as manager_name
      , employees.employee_birth_date
      , employees.employee_hire_date
      , employees.employee_city
      , employees.employee_region
      , employees.employee_country
    from employees
    left join employees as managers
        on employees.manager_fk = managers.employee_pk
  )

select *
from self_joined