create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_employees
    (
        /* Data Quality*/
        constraint valid_id_not_null expect (id is not null) on violation fail update
    )
as

select *
from stream read_files(
    '/Volumes/workspace/raw/northwind/employees/',
    format => "csv",
    header => true,
    schema => """
        id int
        , lastname string
        , firstname string
        , title string
        , titleofcourtesy string
        , birthdate date
        , hiredate date
        , address string
        , city string
        , region string
        , postalcode string
        , country string
        , homephone string
        , extension int
        , photo string
        , notes string
        , reportsto int
        , photopath string
    """
);