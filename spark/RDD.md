# Spark RDD 이해하기

### RDD 기본개념
- 여러 분산 노드에 걸쳐서 저장되는 변경이 불가능한 데이터(객체)의 집합
- 서로 다른 노트에서 분리되어 실행되는 여러개의 파티션으로 분리됨
- 스파크 내에 저장된 데이터. 변경이 불가능(새로운 데이터셋을 생성해야만 함)

### RDD 생성
- 외부로부터 데이터를 로딩하거나 파일은 일반 파일을 읽거나, S3, HBase, HDFS, Cassandra 등에서 데이터를 읽어 올 수 있다 
- 드라이버 프로그램 내에서 생성된 collection을 parallelize()라는 메서드을 이용해서 RDD화 하는 방	- 자바컬렉션 등을 RDD로 생성

### RDD Operations
1. Transformation(변환)
- RDD를 필터링하거나 변환하여 새로운 RDD를 리턴하는 오퍼레이션
- filter, map, group
- [변환 함수리스트](https://spark.apache.org/docs/1.2.0/programming-guide.html#transformations)

```python
>>> f = sc.textFile("README.md")
>>> t = f.filter(lambda x: "Apache" in x)
>>> for l in t.collect():
...	print l
...
# Apache Spark
Spark is built using [Apache Maven](http://maven.apche.org/).
>>>
```

- 위 코드는 README.md라는 파일을 읽어서 f라는 RDD를 생성한 후,
- f라는 RDD에서 "Apache"라는 문자열을 가진 라인만을 모아서 t라는 RDD를 새롭게 생성한 후 화면으로 출력하는 예제.
- f와 t는 전혀 다른 RDD로 RDD t는 filter에 의해서 새롭게 생성되었다

2. Action(액션)
- RDD를 가지고 계산해서 최종 결과를 리턴하거나 데이터를 외부 저장소에 쓸 수 있음
- 최종결과를 리턴하는 오퍼레이션 : count(), first
- RDD를 저장하는 오퍼레이션 : saveAsTextFile(path) 


ref) https://bcho.tistory.com/
