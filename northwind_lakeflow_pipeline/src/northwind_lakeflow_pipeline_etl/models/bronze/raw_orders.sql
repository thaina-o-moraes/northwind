create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_orders
as

select *
from stream read_files(
    '/Volumes/workspace/raw/northwind/orders/',
    format => "csv",
    header => true,
    schema => """
      id int
      , customerid string
      , employeeid int
      , orderdate date
      , requireddate date
      , shippeddate date
      , shipvia string
      , freight double
      , shipname string
      , shipaddress string
      , shipcity string
      , shipregion string
      , shippostalcode string
      , shipcountry string
    """
);