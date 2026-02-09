CREATE MATERIALIZED VIEW ${catalog_name}.${mart_schema_name}.dim_customers
-- (
--         customer_pk string comment 'Primary key',
--         customer_company_name string comment 'Company name',
--         customer_contact_name string comment 'Customer name',
--         customer_contact_title string comment 'Customer title',
--         customer_address string comment 'Customer address',
--         suplier_city string comment 'Suplier city',
--         customer_region string comment 'Customer region',
--         customer_postalcode string comment 'Customer postal code',
--         customer_country string comment 'Customer country',
--         customer_phone string comment 'Customer phone',
--         customer_fax string comment 'Customer fax'
--     )
--     comment 'Tabela dimensional de clientes contendo dados cadastrais.'
as
with
    dim_customers as (
        select *
        from ${catalog_name}.${stg_schema_name}.stg_erp_customers
    )

select *
from dim_customers