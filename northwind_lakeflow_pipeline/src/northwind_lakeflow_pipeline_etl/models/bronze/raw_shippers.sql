create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_shippers
as

select *
from stream read_files(
    '/Volumes/workspace/raw/northwind/shippers/',
    format => "csv",
    header => true,
    schema => """
        id int
        , companyname string
        , phone string
    """
);