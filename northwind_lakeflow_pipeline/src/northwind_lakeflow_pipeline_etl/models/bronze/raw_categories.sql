create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_categories
    (
        /* Data Quality*/
        constraint valid_id_not_null expect (id is not null) on violation fail update,
        constraint valid_name_not_null expect (categoryname is not null) on violation fail update
    )
as 

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