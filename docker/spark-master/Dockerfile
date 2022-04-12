ARG spark_version
FROM spark-base:${spark_version}

EXPOSE 8080 7077

CMD bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out