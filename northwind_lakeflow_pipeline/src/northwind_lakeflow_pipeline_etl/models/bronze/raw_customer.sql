create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_customers
    (
        /* Data Quality*/
        constraint valid_id_not_null expect (id is not null) on violation fail update,
        constraint valid_name_not_null expect (companyname is not null) on violation fail update
    )
as 

select *
from stream read_files(
    '/Volumes/workspace/raw/northwind/customers/',
    format => "csv",
    header => true,
    schema => """
        id string
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
    """
);