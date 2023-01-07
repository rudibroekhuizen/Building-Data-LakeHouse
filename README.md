# Building Data Lakehouse

This project is designed to construct a data lakehouse. This data lakehouse will enable organizations to store, manage, and analyze large datasets in a cost-effective, secure, and scalable manner. The data lakehouse will provide a centralized repository for all data, allowing users to easily access and query the data with a unified interface.

Minio will provide distributed object storage to store the data, Delta Lake will provide ACID-compliant transactions for managing the data, Spark will enable distributed computing for analytics, Presto will provide fast SQL queries, and Hive Metastore will provide a unified catalog for the data. This data lakehouse will enable organizations to quickly and easily access and analyze valuable data, allowing them to make better data-driven decisions.

This project aims also to create an Extract, Load, and Transform (ELT) pipeline to ingest data from a Postgres database into our lakehouse. The ELT pipeline will make use of Apache Spark, to extract the data from the Postgres database, load it into the lakehouse, and then transform it into the desired format. Once the data is loaded into the lakehouse, it will be available for downstream analytics and reporting.
## Architecture

![Architecture](/images/1.png "Architecture")


## Start
- Run script
```bash
./start.sh
```

### Sync PostgreSQL to Delta/S3
```bash
docker compose exec spark-master spark-submit /opt/workspace/postgres_to_s3.py
```

### Doesn't work for now, error `py4j.protocol.Py4JJavaError: An error occurred while calling o75.save.`
```bash
docker compose exec spark-master spark-submit --master spark://master:7077 \
    --deploy-mode cluster \
    --executor-memory 5G \
    --executor-cores 8 \
    /opt/workspace/postgres_to_s3.py
```

### Cleanup
```
docker compose exec spark-master spark-submit /opt/workspace/clean_data.py
```

### Doesn't work for now, error `py4j.protocol.Py4JJavaError: An error occurred while calling o75.save.`
```bash
docker exec -it master spark-submit --master spark://master:7077 \
    --deploy-mode cluster \
    --executor-memory 5G \
    --executor-cores 8 \
    /opt/workspace/clean_data.py
```

### Query using spark-sql
```bash
docker compose exec spark-master bash
```
```
spark-sql \
--conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 \
--conf spark.hadoop.fs.s3a.access.key=admin \
--conf spark.hadoop.fs.s3a.secret.key=123456789 \
--conf spark.hadoop.fs.s3a.path.style.access=true \
--conf spark.sql.warehouse.dir=s3a://deltalake/ \
--conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem \
--conf hive.metastore.uris=thrift://hive-metastore:9083 \
--conf spark.hadoop.metastore.catalog.default=hive \
--conf spark.sql.catalogImplementation=hive \
--conf spark.hadoop.fs.s3.impl=org.apache.hadoop.fs.s3a.S3AFileSystem \
--conf spark.hadoop.fs.s3a.connection.ssl.enabled=false \
--packages io.delta:delta-core_2.12:1.0.1 \
--conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
--conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog"
```
```
SELECT * FROM delta.`s3a://deltalake/bronze/test_db/Dec-30-2022/bird` limit 10;
```

## Links
- Spark master UI: http://localhost:9090
- Spark worker a UI: http://localhost:9091
- Spark worker b UI: http://localhost:9092
- Minio: http://localhost:9001
- Presto: http://localhost:8000


## Built With

- Spark
- Minio
- PostgreSQL
- Hive Metastore
- Presto
- Delta Lake


## Author

**Youssef EL ASERY**

- [Profile](https://github.com/ysfesr "Youssef ELASERY")
- [Linkedin](https://www.linkedin.com/in/youssef-elasery/ "Welcome")
- [Kaggle](https://www.kaggle.com/youssefelasery "Welcome")


## 🤝 Support

Contributions, issues, and feature requests are welcome!

Give a ⭐️ if you like this project!
