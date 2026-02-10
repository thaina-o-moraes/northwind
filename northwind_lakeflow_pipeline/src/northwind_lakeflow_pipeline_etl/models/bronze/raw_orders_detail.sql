create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_orders_detail
    (
        /* Data Quality*/
        constraint valid_id_not_null expect (orderid is not null) on violation fail update,
        constraint valid_product_not_null expect (productid is not null) on violation fail update
    )
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