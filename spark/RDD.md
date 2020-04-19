# Spark RDD 이해하기

### RDD 기본개념
- 여러 분산 노드에 걸쳐서 저장되는 변경이 불가능한 데이터(객체)의 집합
- 서로 다른 노트에서 분리되어 실행되는 여러개의 파티션으로 분리됨
- 스파크 내에 저장된 데이터. 변경이 불가능(새로운 데이터셋을 생성해야만 함)

### RDD 생성
- 외부로부터 데이터를 로딩하거나 파일은 일반 파일을 읽거나, S3, HBase, HDFS, Cassandra 등에서 데이터를 읽어 올 수 있다 
- 드라이버 프로그램 내에서 생성된 collection을 parallelize()라는 메서드을 이용해서 RDD화 하는 방	- 자바컬렉션 등을 RDD로 생성

### RDD Operations
#### 1. Transformation(변환)
- RDD를 필터링하거나 변환하여 새로운 RDD를 리턴하는 오퍼레이션
- filter, map, group
- [변환 함수리스트](https://spark.apache.org/docs/1.2.0/programming-guide.html#transformations)

```
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

#### 2. Action(액션)
- RDD를 가지고 계산해서 최종 결과를 리턴하거나 데이터를 외부 저장소에 쓸 수 있음
- 최종결과를 리턴하는 오퍼레이션 : count(), first
- RDD를 저장하는 오퍼레이션 : saveAsTextFile(path) 

### Passing Function(python)
- 스파크는 개발자가 비지니스 로직을 함수로 정의한 후에, 이 함수를 스파크 클러스의 노드들로 보내 수행할 수 있다

####  1. 람다 표기법을 이용하는 방식

- 필터 연산에서 함수를 람다 표기법으로 정의해서 넘기는 예제. 'l'이라는 RDD에 Apache라는 문자열이 있는지 없는지를 행마다 체크하는 로직 

```
>>> l = sc.textFile("README.md")
>>> apache = l.filter(lambda s: "Apache" in s)
>>> apache.count()
2
```

####  2. 모듈 상의 탑레벨 함수

- 같은 로직을 함수로 정의해서 함수 자체로 넘길 수 있다
- 아래 코드는 위의 람다표현식으로 된 함수를 countainsApache라는 함수로 정의하여 필터로 넘기는 예제이다

```
>>> l = sc.textFile("README.md")
>>> def contaionsApache(s):
...    return "Apache" in s
...
>>> apache = l.filter(contaionsApache)
>>> apache.count()
2
```

####  3. 파이썬 클래스 안에서 함수를 정의하여, 클래스 안에서 그 함수를 스파크로 넘기는 방식

- MyClass 클래스를 정의한 다음, 클래스를 생성할 때, filter에 사용할 문자열을 받은 후, count라는 메서드에서, 그 문자열로 필터링을 한 후, 라인 수를 count하여 리턴하는 방법

```
>>> class MyClass(object):
...    def __init__(self, query):
...        self.query = query
...    def count(self, rdd):
...        return rdd.filter(lambda s: self.query in s).count()
...
>>> c = MyClass("Apache")
>>> c.count(l)
2
```

- 주의할 점 : 
	- self.query를 filter에 인자로 넘겼는데, 스파크로 넘어가는 것은 self.query변수 내용 하나가 아니라, 이 객체 전체가 스파크로 넘어간다. 동작상에는 문제가 없지만, 전체 객체가 스파크로 넘어가기 때문에 메모리 사용률이 많아지고 전체 객체를 넘기는 과정 역시 인자만 넘기는 방식에 비해서 상대적으로 시가닝 만힝 걸리기 때문에 좋은 방법은 아니다.
	- 이런 문제를 피하기 위해 클래스 내에서 어떤 값을 넘길 때는 `self.xxx` 식으로 넘기는 것이 아니라, 그 값을 복사하여 넘기는 방법을 사용하면 된다. 아래와 같이 수정하면 된다.

```
>>> class MyClass(object):
...    def __init__(self, query):
...        self.query = query
...    def count(self, rdd):
...        x = self.query
...        return rdd.filter(lambda s: x in s).count()
```

- 이렇게 `x = self.query` 로 하여 x를 넘기면, 모든 객체가 스파크에 전달되지 않고, 이 로컬 변수 x만 넘어가기 때문에 메모리가 과 사용되는 것을 예방할 수 있다.


ref) https://bcho.tistory.com/
