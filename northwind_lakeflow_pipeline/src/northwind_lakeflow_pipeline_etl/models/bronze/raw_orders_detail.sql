create streaming table ${catalog_name}.${raw_schema_name}.raw_erp_orders_detail
AS SELECT
    orderid
    , productid
    , unitprice
    , quantity
    , discount
FROM STREAM READ_FILES(
    '/Volumes/workspace/raw/northwind/orders_detail/',
    format => "csv",
    header => true
);