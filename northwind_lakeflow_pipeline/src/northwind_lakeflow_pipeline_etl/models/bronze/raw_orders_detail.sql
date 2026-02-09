create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_orders_detail
as

select *
from stream read_files(
    '/Volumes/workspace/raw/northwind/orders_detail/',
    format => "csv",
    header => true,
    schema => """
        orderid int
        , productid int
        , unitprice double
        , quantity int
        , discount double
    """
);