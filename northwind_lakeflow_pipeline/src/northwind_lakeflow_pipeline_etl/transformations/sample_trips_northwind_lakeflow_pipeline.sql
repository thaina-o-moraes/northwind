-- This file defines a sample transformation.
-- Edit the sample below or add new transformations
-- using "+ Add" in the file browser.

CREATE MATERIALIZED VIEW sample_trips_northwind_lakeflow_pipeline AS
SELECT
    pickup_zip,
    fare_amount,
    trip_distance
FROM samples.nyctaxi.trips
