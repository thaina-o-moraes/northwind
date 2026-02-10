create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_products
    (
        /* Data Quality*/
        constraint valid_id_not_null expect (id is not null) on violation fail update,
        constraint valid_name_not_null expect (productname is not null) on violation fail update,
        constraint valid_supplierid expect (supplierid is not null) on violation fail update,
        constraint valid_categoryid expect (categoryid is not null) on violation fail update
    )
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