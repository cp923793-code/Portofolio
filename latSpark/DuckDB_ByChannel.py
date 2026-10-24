import os, sys, findspark

# 1. Setup paths
os.environ["SPARK_HOME"] = "C:/spark"
os.environ["HADOOP_HOME"] = "C:/hadoop"
os.environ["JAVA_HOME"] = r"C:\Program Files\BellSoft\LibericaJDK-17"
#os.environ["JAVA_HOME"] = "C:/Program Files/Java/jdk-21" # Verify this path!

# 2. Initialize
findspark.init()

# 3. Initialize findspark so it uses C:/spark
findspark.init()
print("Findspark initialized successfully.") 

import duckdb
from pyspark.sql import SparkSession
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
import time

# Configuration
SQL_SERVER_CONFIG = {
    "url": "jdbc:sqlserver://localhost:1433;databaseName=AdventureSales;encrypt=true;trustServerCertificate=true;",
    "user": "sa",
    "password": "D@1ry$2014",
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}

DUCKDB_PATH = 'c:\\duckDB\\adventuresales.duckdb'

# List of tables to migrate
''' 
TABLES_TO_COPY = [
    "sttwk", "customerdist_1910a", "product", "prodcat", 
    "branch", "stockpoint", "discount_b", "discount_potTunai",
    "sls_chlprn", "slsmanexc", "slsexc_chlprn6", "dw_ilo_18", 
    "dw_ilo_oth", "slsman"
]
'''
# sequence of tables to copy
TABLES_TO_COPY = [
    "branch", "stockpoint", "product", "prodcat","discount_potTunai",
    "sls_chlprn", "slsmanexc", "slsexc_chlprn6", "dw_ilo_18", 
    "dw_ilo_oth", "slsman","customerdist_1910a", "discount_b","sttwk"
]
'''
TABLES_TO_COPY = [
"sttwk"
]
'''

def migrate_table(spark, table_name):
    spark.sparkContext.setLogLevel("OFF")
    start_time = time.time()
    
    # 1. Standard Reader setup
    reader = spark.read.format("jdbc") \
        .option("url", SQL_SERVER_CONFIG["url"]) \
        .option("user", SQL_SERVER_CONFIG["user"]) \
        .option("password", SQL_SERVER_CONFIG["password"]) \
        .option("driver", SQL_SERVER_CONFIG["driver"]) \
        .option("batchsize", "100000")

    if table_name.lower() == 'sttwk':
        print("Processing large table sttwk via Parquet Stream...")
        # Use partitioning to speed up the read from SQL Server
        partition_sql = "(SELECT *, CAST(week AS INT) as week_num FROM dbo.sttwk) as subq"
        df = reader.option("dbtable", partition_sql) \
                   .option("partitionColumn", "week_num") \
                   .option("lowerBound", "1") \
                   .option("upperBound", "53") \
                   .option("numPartitions", "4") \
                   .load()

        # STEP 2: Write to a temp Parquet file (This avoids the Java Heap OOM)
        temp_parquet = f"c:\\duckDB\\temp_{table_name}.parquet"
        # Overwrite existing temp file if it exists
        df.write.mode("overwrite").parquet(temp_parquet)
        
        # STEP 3: DuckDB reads the Parquet file directly (Fastest way in 2026)
        con = duckdb.connect(DUCKDB_PATH)
        con.execute(f"DROP TABLE IF EXISTS {table_name}")
        con.execute(f"CREATE TABLE {table_name} AS SELECT * FROM '{temp_parquet}'")
        con.close()
        
        # Cleanup temp file
        import os
        # os.remove(temp_parquet) # Optional: remove if you want to save space
        
    else:
        # For small tables, use your existing fast method
        df = reader.option("dbtable", table_name).load()
        arrow_table = df.toArrow()
        con = duckdb.connect(DUCKDB_PATH)
        con.execute(f"DROP TABLE IF EXISTS {table_name}")
        con.register("temp_df", arrow_table)
        con.execute(f"CREATE TABLE {table_name} AS SELECT * FROM temp_df")
        con.close()

    print(f"Migrated {table_name} in {time.time() - start_time:.2f} seconds.")


def create_final_report():
    con = duckdb.connect(DUCKDB_PATH)
    
    report_sql = """
    DROP TABLE IF EXISTS Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint;

    CREATE TABLE Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint AS 
    SELECT 
        f.region, a.branch_id, f.branch_name, a.year, a.month, a.week, 
        c.channel, c.sub_channel, 
        e.prodLine, e.prodgrp,
        d.udf6 AS psub_id, 
        g.depo, g.sp_name, g.sp_id, d.text_id, d.product, d.udf1 AS psub_id1,
        CASE WHEN c.CRM = 'Y' THEN 'Y' ELSE 'N' END AS CRM,
        CASE WHEN ((h.sls_id_chl <> '' AND y.sls_id <> '') OR sls_id_org <> '') AND y.no <= 100 THEN 'Y' ELSE 'N' END AS Sls_100,
        CASE WHEN (h.sls_id_chl <> '' AND y.sls_id <> '') OR sls_id_org <> '' THEN 'Y' ELSE 'N' END AS Sls_200,
        CASE WHEN u.custd_id <> '' THEN 'Y' ELSE 'N' END AS DW_18,
        CASE WHEN v.custd_id <> '' THEN 'Y' ELSE 'N' END AS DW_Oth,
        c.Retwhs,
        CASE WHEN c.Chiller = 'Y' THEN 'Y' ELSE 'N' END AS Chiller,
        CAST(SUM(a.net_qty) AS DECIMAL(17,5)) AS net_qty,
        CAST(SUM(a.net_amt) AS DECIMAL(17,5)) AS net_amt,
        CAST(SUM(a.grs_qty) AS DECIMAL(17,5)) AS grs_qty,
        CAST(SUM(a.grs_amt) AS DECIMAL(17,5)) AS grs_amt,
        CAST(SUM(a.rtn_qty) AS DECIMAL(17,5)) AS rtn_qty,
        CAST(SUM(a.rtn_amt) AS DECIMAL(17,5)) AS rtn_amt,
        CAST(SUM(a.grs_amt - a.net_amt - a.rtn_amt) AS DECIMAL(17,5)) AS disc_amt,
        CAST(SUM(i.disc_b_amt) AS DECIMAL(17,5)) AS Disc_B,
        CAST(SUM(j.disc_PotTunai) AS DECIMAL(17,5)) AS Disc_PT, 
        CASE WHEN x.sls_type LIKE '%canva%' THEN 'Y' ELSE 'N' END AS Canvass,
        CASE WHEN c.Mkt = 'Y' THEN 'Y' ELSE 'N' END AS Mkt
    FROM sttwk AS a
    LEFT OUTER JOIN customerdist_1910a c ON a.custd_id = c.kode_iap
    LEFT OUTER JOIN product d ON a.prod_id = d.prod_id
    LEFT OUTER JOIN prodcat e ON d.psub_id = e.psub_id
    LEFT OUTER JOIN branch f ON a.branch_id = f.branch_id
    LEFT OUTER JOIN stockpoint g ON a.sp_id = g.sp_id
    LEFT OUTER JOIN discount_b i ON a.custd_id = i.custd_id AND a.prod_id = i.prod_id AND a.year = i.year AND a.week = i.week AND a.sls_id = i.sls_id
    LEFT OUTER JOIN discount_potTunai j ON a.custd_id = j.custd_id AND a.prod_id = j.prod_id AND a.year = j.year AND a.week = j.week AND a.sls_id = j.sls_id
    LEFT OUTER JOIN sls_chlprn h ON a.branch_id = h.br_chl AND a.sp_id = h.sp_chl AND a.sls_id = h.sls_id_chl AND a.year = h.year AND a.week = h.week
    LEFT OUTER JOIN slsmanexc y ON h.br_chl = y.branch_id AND h.sp_chl = y.sp_id AND h.sls_id_prn = y.sls_id 
    LEFT OUTER JOIN slsexc_chlprn6 b ON a.sp_id = b.sp_id1 AND a.sls_id = b.sls_id1 AND a.year = b.year AND a.week = b.week
    LEFT OUTER JOIN dw_ilo_18 u ON a.custd_id = u.custd_id
    LEFT OUTER JOIN dw_ilo_oth v ON a.custd_id = v.custd_id
    LEFT OUTER JOIN slsman x ON a.branch_id = x.branch_id AND a.sp_id = x.sp_id AND a.sls_id = x.sls_id
    GROUP BY ALL;
    """
    
    start = time.time()
    con.execute(report_sql)
    end = time.time()
    
    print(f"Final report created in {end - start:.2f} seconds.")
    con.close()

# 1. Define configuration
default_args = {
    'owner': 'airflow',
    'start_date': datetime(2026, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}    

# 3. Create the DAG structure
# Note: Changed schedule_interval to schedule
with DAG('sql_server_to_duckdb_migration',
         default_args=default_args,
         schedule='@daily', 
         catchup=False) as dag:

    # Task for final report
    report_task = PythonOperator(
        task_id='create_final_report_table',
        python_callable=create_final_report
    )

    for table in TABLES_TO_COPY:
        copy_task = PythonOperator(
            task_id=f'copy_{table}',
            python_callable=migrate_table,
            op_args=[table]
        )
        
        # Dependency: migrate tables before creating report
        copy_task >> report_task

print("Airflow DAG defined successfully using modern 2026 syntax!")
# --- ADD THIS AT THE BOTTOM ---

if __name__ == "__main__":
    print("Manual execution started because Airflow Scheduler is not running on Windows...")
    # Start Spark ONCE
    main_spark = SparkSession.builder \
        .appName("Full_Migration") \
        .config("spark.jars", r"C:\spark_drivers\mssql-jdbc-13.2.1.jre11.jar") \
        .config("spark.driver.memory", "12g") \
        .config("spark.sql.execution.arrow.pyspark.enabled", "true") \
        .getOrCreate()
        #.config("spark.executor.memory", "4g") \
        #.config("spark.driver.maxResultSize", "8g") \
        
        #.config("spark.sql.execution.arrow.pyspark.enabled", "true") \
        #.config("spark.sql.execution.arrow.maxRecordsPerBatch", "100000") \

    # 1. Migrate all tables
    for table in TABLES_TO_COPY:
        try:
            migrate_table(main_spark,table)
        except Exception as e:
            print(f"Error migrating {table}: {e}")
    
    # 2. Run the final summary report
    try:
        create_final_report()
    except Exception as e:
        print(f"Error creating final report: {e}")

    print("Migration and Report creation finished successfully!")        
        # STOP it here at the very end. 
    # You might still see the error ONCE, but it won't clutter your migration.
    main_spark.stop()