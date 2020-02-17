SHOW DATABASES;

CREATE DATABASE test2;

USE test2;

SELECT DATABASE();

CREATE TABLE USER1(
	user_id INT,
	NAME VARCHAR(20),
	email VARCHAR(30),
	age INT(3),
	rdate DATE
);

CREATE TABLE USER2(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20) NOT NULL,
	email VARCHAR(30) UNIQUE NOT NULL,
	age INT(3) DEFAULT 30,
	rdate timestamp
);

SHOW VARIABLES LIKE "character_set_database";
ALTER DATABASE test2 CHARACTER SET = UTF8;

ALTER TABLE USER2 ADD tmp TEXT;
ALTER TABLE USER2 MODIFY COLUMN tmp INT(3);
ALTER TABLE USER2 DROP tmp;

CREATE DATABASE tmp;
DROP DATABASE tmp;
SHOW DATABASES;
DROP DATABASE test;

DROP TABLE USER2;
SELECT DATABASE();

INSERT INTO USER1(user_id, NAME, email, age, rdate)
VALUE 
	(7, 'dm', 'dddm@gmail.com', 33, NOW()),
	(8, 'peterm', 'peterm@gmail.com', 23, NOW()),
	(9, 'pom', 'popom@daum.net', 43, NOW()),
	(10, 'andym', 'andym@naver.com', 17, NOW()),
	(11, 'jinm', 'jinm@naver.com', 32, NOW());

SELECT user_id, NAME, age
FROM USER1;

SELECT *
FROM USER1;

INSERT INTO USER1(user_id, NAME, email, age, rdate)
VALUE (7, 'd', 'dd@naver.com', 22, NOW());

SELECT DISTINCT(NAME)
FROM USER1;

SELECT COUNT(DISTINCT(NAME))
FROM USER1
WHERE age >= 30;

SELECT *
FROM USER1
WHERE age > 20 AND age < 40;

SELECT *
FROM USER1
WHERE age BETWEEN 20 AND 40;

# 나이가 20세에서 40세 사이에 있는 사용자를 이름순으로 내림차순 정렬하고,
SELECT DISTINCT(NAME)
FROM USER1
WHERE age BETWEEN 20 AND 40 
ORDER BY NAME DESC;

SELECT NAME, age, CONCAT(NAME, '(', age, ')') AS "name_age"
FROM USER1;

SELECT *
FROM USER1
WHERE email LIKE "p%";

SELECT *
FROM USER1
WHERE NAME IN ('peter', 'po', 'andy');

## 서브쿼리
SELECT DISTINCT(NAME)
FROM USER1
WHERE age > 30;

SELECT *
FROM USER1
WHERE NAME IN(
	SELECT DISTINCT(NAME)
	FROM USER1
	WHERE age > 30
);

SELECT *
FROM USER1
LIMIT 3;

SELECT *
FROM USER1
LIMIT 3, 2;

UPDATE USER1
SET age=20, rdate='2020-02-11'
WHERE age BETWEEN 22 AND 25;

SELECT *
FROM USER1;

USE world;

SELECT countrycode, COUNT(countrycode) AS COUNT
FROM city
GROUP BY countrycode;

SELECT COUNT(DISTINCT(LANGUAGE))
FROM countrylanguage;

# 대륙별 인구수와 GNP의 최댓값을 출력
SELECT continent, max(population), MAX(GNP)
FROM country
GROUP BY continent;

# 대륙별 전체인구를 구하고 5억 이상인 대륙만 출력
SELECT continent, SUM(population) AS population
FROM country
GROUP BY continent
HAVING population >= 500000000;

SELECT CEIL(12.345);
SELECT round(12.345, 2);
SELECT TRUNCATE(12.345, 1);

# 조건문
# IF: IF(조건, 참, 거짓)
# 도시의 인구가 100만 이상 big city, 100만 미만 small city 출력
SELECT NAME, population, if(population >= 1000000, 'big city', 'small city' ) as city_scale
FROM city;

# IFNULL: IFNULL(참, 거짓)
# country 테이블에서 독립년도(IndepYear)가 없으면 0으로 출력
SELECT NAME, IFNULL(IndepYear, 0) AS IndepYear
FROM country;

# CASE
#	WHEN (조건1) THEN (출력1)
#	WHEN (조건2) THEN (출력2)
# END AS (컬럼명)
# 나라별 10억 이상, 1억 이상, 1억 이하 조건을 출력
SELECT NAME, population, 
case	
	when population >= 1000000000 then '10억 이상'
	when population >= 100000000 then '1억 이상'
	ELSE '1억 이하' END as result
FROM country;

USE sakila;
# payment에서 월별 총 매출횟수와 총 매출 출력
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS monthly, COUNT(amount), SUM(amount)
FROM payment
GROUP BY monthly;

# payment에서 시간대별 총 매출횟수와 총 매출 출력
SELECT DATE_FORMAT(payment_date, '%H') AS hourly, COUNT(amount), SUM(amount)
FROM payment
GROUP BY hourly;

### JOIN(merge)
USE world;

## inner join
SELECT addr.id, addr.user_id, USER.name, addr.addr 
FROM addr
JOIN USER	
ON addr.user_id = USER.user_id; 

## left join
SELECT addr.id, addr.user_id, ifnull(USER.name, '-')AS name, addr.addr
FROM addr
LEFT JOIN USER	
ON addr.user_id = USER.user_id;

## right join
SELECT addr.id, addr.user_id, USER.name, addr.addr
FROM addr
RIGHT JOIN USER	
ON addr.user_id = USER.user_id;

## unoin
SELECT NAME
FROM USER
UNION
SELECT addr
FROM addr;

## outer join (union left join and right join)
SELECT USER.name, addr.addr, addr.user_id
FROM USER
LEFT JOIN addr
ON USER.user_id = addr.user_id
UNION
SELECT USER.name, addr.addr, addr.user_id
FROM USER
RIGHT JOIN addr
ON USER.user_id = addr.user_id;

### sub query
## select
# 전체 나라수, 전체 도시수, 전체 언어수를 출력
SELECT 
(SELECT COUNT(NAME)
FROM country) AS country,
(SELECT COUNT(NAME)
FROM city) AS city,
(SELECT COUNT(LANGUAGE)
FROM countrylanguage) AS LANGUAGE
FROM DUAL;

USE world;
# from 절
# 800만 이상이 되는 도시의 국가코드, 이름, 도시 인구수를 출력
select countrycode, NAME, population
FROM city
WHERE population >= 8000000;

SELECT *
FROM (
SELECT countrycode, NAME, population
FROM city
WHERE population >= 8000000) AS city
JOIN (
SELECT CODE, NAME
FROM country) AS country
ON city.countrycode = country.code;

# where 절
# 800만 이상 도시의 국가코드, 국가이름, 대통령이름 출력
SELECT CODE, NAME, HeadOfState
FROM country
WHERE CODE IN (
SELECT DISTINCT(countrycode)
FROM city
WHERE population >= 8000000);

# index
USE employees;
EXPLAIN
SELECT COUNT(*)
FROM salaries
WHERE to_date > "2000-01-01";

CREATE INDEX tdate
ON salaries(to_date);

DROP INDEX tdate
ON salaries;

# view
USE world;
CREATE VIEW code_name AS
SELECT CODE, NAME
FROM country;

SELECT *
FROM city
JOIN (
SELECT CODE, NAME
FROM country) AS code_name
ON city.countrycode = code_name.code;

SELECT *
FROM city
JOIN code_name
ON city.countrycode = code_name.code;