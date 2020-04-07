zeppelin
spark : local
spark2 : spark standalone
spark3 : yarn

- interpreter 설정 시, core수를 설정해야함

(spark.cores.max : yarn에서 안먹힘 / spark.executor.cores : yarn에서 먹힘)

- cd /pearl/spark2/bin/spark-shell --help : spark-shell에 대한 도움말 보기

---
* spark api documents 
: https://spark.apache.org/docs/latest/api/scala/

* spark는 저장할 때 파일명을 지정할 수 없다. 저장 경로만 지정할 수가 있음

* 파일 저장하기 
`df2.write.json("hdfs://hadoop-master-01:9000/pearl/data/airline_on_time.json")`
 json파일로 저장되는 것이 아니라, airline_on_time.json라는 디렉토리에 저장됨

* schema 보기
`df2.printSchema`

* DB에 어떤 테이블, 데이터가 있는지 보기
`spark.catalog.currentDatabase`
* 데이터 보기
`spark.catalog.listDatabases.show(truncate=false)`
	- truncate=false : 내용을 자르지 않고 모두 보기

* 그 경로에 뭐가 있는지 보기
```%sh
ls -al /home/hadoop/spark-warehouse
```

* 컬럼명을 적절하게 바꿔서 데이터웨어하우스에 저장하기
`df2.toDF("Year", "Month", "avg_flightNum", "min_flightNum", "max_flightNum", "cnt_flight").write.mode("overwrite").saveAsTable("df2")`

*웨어하우스 데이터 보기
`spark.catalog.listTables.show(false)`


---
## 데이터 종류 $\Rightarrow$ 저장소
#### File $\Rightarrow$ HDFS/S3/local
ex) txt, csv, json, parquet ...
- txt를 제외하고는 schema가 있음

#### RDB $\Rightarrow$ MySQL, Oracle

#### NoSQL $\Rightarrow$ mongodb, cassandra
#### DW(Big Data Warehoues) $\Rightarrow$ Hive, SparkSQL
#### Streaming $\Rightarrow$ 저장소 없음(트위터, kafka)

## Driver가 Cluster에 CPU를 할당
#### Driver 
- spark-shell / pyspark / sparkR / spark-sql
- Zeppelin interpreter
- jupyter notebook
- trift server :  BI Tool이 JDBC/ODBC 통신으로 trift server에 붙음
DB의 데이터(주로 RDB)를 BI tool로 (JDBC/ODBC)에 붙여서(가져와서?) 데이터를 처리 ex)Tableau, QlikView

#### cluseter
- YARN
- Standalone
- Mosos
- K8S

#### 데이터처리방식(?)
- RDD : txt
- DataFrame : schema 정보가 있는 모든 데이터
	- sql style ( $\supset$ rdd)
- MLlib(machine learning library)
- GraphX : 관계를 표현
