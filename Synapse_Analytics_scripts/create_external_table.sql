CREATE DATABASE SCOPED CREDENTIAL cred_maddy
WITH IDENTITY= 'Managed Identity'

CREATE EXTERNAL DATA SOURCE silver
WITH
(
LOCATION='https://projectdbmadhav.blob.core.windows.net/silver/',
CREDENTIAL=cred_maddy)

CREATE EXTERNAL DATA SOURCE gold
WITH
(
LOCATION='https://projectdbmadhav.blob.core.windows.net/gold/',
CREDENTIAL=cred_maddy)

CREATE EXTERNAL FILE FORMAT format_parquet
WITH (

    FORMAT_TYPE=PARQUET, DATA_COMPRESSION='org.apache.hadoop.io.compress.SnappyCodec'
)

CREATE EXTERNAL TABLE gold.extsales
WITH(
    LOCATION='extsales',
    DATA_SOURCE =gold,
    FILE_FORMAT= format_parquet
) AS SELECT* FROM gold.sales