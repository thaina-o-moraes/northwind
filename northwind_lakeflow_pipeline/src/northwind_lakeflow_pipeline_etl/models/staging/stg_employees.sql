create materialized view ${catalog_name}.${stg_schema_name}.stg_erp_employees as
with
  source_employees as (
    select *
    from ${catalog_name}.${raw_schema_name}.raw_erp_employees
  )

  , renamed as (
    select 
      cast(id as int) as employee_pk
      , cast(reportsto as int) as manager_fk
      , cast(lastname as string) as employee_lastname
      , cast(firstname as string) as employee_name
      , cast(title as string) as employee_title
      , cast(titleofcourtesy as string) as employee_title_of_courtesy
      , cast(birthdate as date) as employee_birth_date
      , cast(hiredate as date) as employee_hire_date
      , cast(address as string) as employee_address
      , cast(city as string) as employee_city
      , cast(region as string) as employee_region
      , cast(postalcode as string) as employee_postalcode
      , cast(country as string) as employee_country
      , cast(homephone as string) as employee_homephone
      , cast(extension as string) as employee_extension
      , cast(photo as string) as employee_photo
      , cast(notes as string) as employee_notes
      , cast(photopath as string) as employee_photopath
    from source_employees
  )


select *
from renamed