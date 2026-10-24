pyspark --jars C:\spark_drivers\mssql-jdbc-13.2.1.jre11.jar,C:\spark_drivers\ojdbc17.jar

pyspark --jars C:\spark_drivers\mssql-jdbc-11.2.4.jre11.jar,C:\spark_drivers\ojdbc17.jar

pyspark --jars C:\spark_drivers\mssql-jdbc-13.2.1.jre11.jar,C:\spark_drivers\postgresql-42.7.8.jar


pyspark --packages com.microsoft.azure:spark-mssql-connector_2.12:1.2.0,com.microsoft.sqlserver:mssql-jdbc:11.2.4.jre11

pyspark --jars C:\spark_drivers\mssql-jdbc-13.2.1.jre11.jar,C:\spark_drivers\postgresql-42.7.8.jar,C:\spark_drivers\ojdbc17.jar,C:\spark_drivers\mysql-connector-j-9.5.0.jar,



pyspark --jars C:\Drivers\mssql-jdbc-13.2.1.jre11.jar --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.2 --conf spark.mongodb.read.connection.uri=mongodb://localhost:27017/AdventureSales.customerdist_1910a --conf spark.mongodb.write.connection.uri=mongodb://localhost:27017/AdventureSales.customerdist_1910a



