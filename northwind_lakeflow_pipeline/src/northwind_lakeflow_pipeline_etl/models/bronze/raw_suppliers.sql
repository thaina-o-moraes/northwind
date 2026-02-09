create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_suppliers
as
    
select *
from stream read_files(
    '/Volumes/workspace/raw/northwind/suppliers/',
    format => "csv",
    header => true,
    schema => """
        id int
        , companyname string
        , contactname string
        , contacttitle string
        , address string
        , city string
        , region string
        , postalcode string
        , country string
        , phone string
        , fax string
        , homepage string
    """
);