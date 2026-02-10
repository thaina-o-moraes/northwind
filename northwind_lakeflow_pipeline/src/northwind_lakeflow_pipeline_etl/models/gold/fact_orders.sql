create materialized view ${catalog_name}.${mart_schema_name}.fct_orders
  (      
    /*  ──────────── Documentation ──────────── */
    order_pk integer comment 'Unique identifier for the order',
    order_number integer comment 'Business-facing order reference number',
    employee_fk integer comment 'Foreign key linking to the employee who processed the order',
    customer_fk string comment 'Foreign key linking to the customer who placed the order',
    shipper_fk integer comment 'Foreign key linking to the shipping company used',
    order_date date comment 'Date the order was placed',
    ship_date date comment 'Date the order was shipped',
    required_delivery_date date comment 'Target date for order delivery',
    freight_total double comment 'Total shipping cost for the order',
    total_quantity long comment'Total number of items purchased in this order (aggregated from line items)',
    gross_total double comment 'Total order value before discounts (sum of line item gross totals)',
    net_total double comment 'Final order value after discounts (sum of line item net totals)',
    line_item_count long comment 'Number of distinct line items in the order',
    had_discount_flag integer comment 'Flag indicating if any item in the order received a discount (1 = Yes, 0 = No)',
    recipient_name string comment 'Name of the recipient for the shipment',
    recipient_city string comment 'City where the order was shipped',
    recipient_region string comment 'Region or state where the order was shipped',
    recipient_country string comment 'Country where the order was shipped'

    /*  ──────────── Data Quality ──────────── */
    constraint valid_order_pk_not_null expect (order_pk is not null) on violation fail update,
    constraint valid_order_not_null expect (order_number is not null) on violation fail update,
    /* Databricks does not enforce primary key or foreign key constraints
    the purpose is to provide metadata about your data model to the system */
    constraint valid_order_pk primary key(order_pk),
    constraint valid_employee_fk foreign key(employee_fk) references ${catalog_name}.${mart_schema_name}.dim_employees(employee_pk),
    constraint valid_customer_fk foreign key(customer_fk) references ${catalog_name}.${mart_schema_name}.dim_customers(customer_pk)
    )
    comment 'Fact table order-level metrics such as total value, quantity, and shipping details.'
as

with
    orders_metrics (
        select *
        from ${catalog_name}.${int_schema_name}.int_orders__metrics
    )

select *
from orders_metrics