create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_shippers
AS SELECT
    id
    , companyname
    , phone
FROM STREAM READ_FILES(
    '/Volumes/workspace/raw/northwind/shippers/',
    format => "csv",
    header => true
);