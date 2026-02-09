create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_products
as

select *
from stream read_files(
    '/Volumes/workspace/raw/northwind/products/',
    format => "csv",
    header => true,
    schema => """
      id int
      , productname string
      , supplierid int
      , categoryid int
      , quantityperunit string
      , unitprice double
      , unitsinstock int
      , unitsonorder int
      , reorderlevel int
      , discontinued boolean
    """
);