create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_products
AS SELECT
  id
  , productname
  , supplierid
  , categoryid
  , quantityperunit
  , unitprice
  , unitsinstock
  , unitsonorder
  , reorderlevel
  , discontinued
FROM STREAM READ_FILES(
    '/Volumes/workspace/raw/northwind/products/',
    format => "csv",
    header => true
);