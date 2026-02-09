create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_orders
AS SELECT
  id
  , customerid
  , employeeid
  , orderdate
  , requireddate
  , shippeddate
  , shipvia
  , freight
  , shipname
  , shipaddress
  , shipcity
  , shipregion
  , shippostalcode
  , shipcountry
FROM STREAM READ_FILES(
    '/Volumes/workspace/raw/northwind/orders/',
    format => "csv",
    header => true
);