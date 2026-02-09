# import dlt
# from pyspark.sql.functions import col

# # from databricks.connect import DatabricksSession
# # from pyspark import pipelines as dp
# # from pyspark.sql import SparkSession
# # from pyspark.sql.functions import col, lit
# # from pyspark.sql.types import (
# #     DecimalType,
# #     IntegerType,
# #     ShortType,
# #     StringType,
# #     StructField,
# #     StructType,
# #     TimestampType,
# # )
# # # 1. Recuperar as variáveis definidas no seu pipeline.yml (na seção configuration)
# # Certifique-se que no YAML, sob 'configuration', você tem essas chaves exatas.
# target_catalog = spark.conf.get("catalog_name")   # ou "target_catalog", dependendo do seu YAML
# raw_schema = spark.conf.get("raw_schema_name")

# # 2. Montar o caminho da tabela de origem dinamicamente
# # source_table_path = f"{target_catalog}.{raw_schema}.raw_erp_customers"
# source_table_path = "workspace.bronze.raw_erp_customers"


# @dlt.table(
#     name="stg_erp_customers",
#     comment="Tabela staging de customers convertida de SQL para Python"
#     # Nota: O Schema de destino é controlado automaticamente pelo 'target' do pipeline
# )
# def stg_erp_customers():
#     # Leitura da fonte (equivalente ao primeiro CTE 'source_customers')
#     source_df = spark.table(source_table_path)
    
#     # Transformação e Renomeação (equivalente ao CTE 'renamed')
#     return (
#         source_df.select(
#             col("id").cast("string").alias("customer_pk"),
#             col("companyname").cast("string").alias("customer_company_name"),
#             col("contactname").cast("string").alias("customer_contact_name"),
#             col("contacttitle").cast("string").alias("customer_contact_title"),
#             col("address").cast("string").alias("customer_address"),
#             col("city").cast("string").alias("suplier_city"),
#             col("region").cast("string").alias("customer_region"),
#             col("postalcode").cast("string").alias("customer_postalcode"),
#             col("country").cast("string").alias("customer_country"),
#             col("phone").cast("string").alias("customer_phone"),
#             col("fax").cast("string").alias("customer_fax")
#         )
#     )