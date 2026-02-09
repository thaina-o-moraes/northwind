create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_suppliers
AS SELECT
    id
    , companyname
    , contactname
    , contacttitle
    , address
    , city
    , region
    , postalcode
    , country
    , phone
    , fax
    , homepage
FROM STREAM READ_FILES(
    '/Volumes/workspace/raw/northwind/suppliers/',
    format => "csv",
    header => true
);