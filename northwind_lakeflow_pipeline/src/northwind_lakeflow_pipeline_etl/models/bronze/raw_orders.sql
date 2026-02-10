create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_orders
    (
        /* Data Quality*/
        constraint valid_id_not_null expect (id is not null) on violation fail update,
        constraint valid_customerid_not_null expect (customerid is not null) on violation fail update,
        constraint valide_employeeid_not_null expect (employeeid is not null) on violation fail update,
        constraint valid_orderdate_not_null expect (orderdate is not null) on violation fail update,
        constraint valid_shipvia_not_null expect (shipvia is not null) on violation fail update
    )
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
      , shipvia int
      , freight double
      , shipname string
      , shipaddress string
      , shipcity string
      , shipregion string
      , shippostalcode string
      , shipcountry string
    """
);