create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_categories
AS

SELECT *
FROM STREAM READ_FILES(
    '/Volumes/workspace/raw/northwind/categories/',
    format => 'csv',
    header => 'true',
    -- inferSchema => 'true',
    -- quote => '"',
    -- escape => '"',
    -- multiline => 'true',
    schema => """
        id string
        , categoryname string
        , description string
    """

);