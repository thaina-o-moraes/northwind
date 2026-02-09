create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_categories as

select *
from stream READ_FILES(
    '/Volumes/workspace/raw/northwind/categories/',
    format => 'csv',
    header => 'true',
    schema => """
        id string
        , categoryname string
        , description string
    """
);