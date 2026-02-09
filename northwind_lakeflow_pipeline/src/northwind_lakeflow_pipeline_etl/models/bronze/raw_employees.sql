create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_employees
    (
--   teste não nulo para a coluna id
  constraint valid_id_not_null expect (id is not null) on violation fail update
)
AS SELECT
    id
    , lastname
    , firstname
    , title
    , titleofcourtesy
    , birthdate
    , hiredate
    , address
    , city
    , region
    , postalcode
    , country
    , homephone
    , extension
    , photo
    , notes
    , reportsto
    , photopath
FROM STREAM READ_FILES(
    '/Volumes/workspace/raw/northwind/employees/',
    format => "csv",
    header => true
);