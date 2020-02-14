# 소수점 올림, 반올림, 버림
SELECT CEIL(12.345);        # 13
SELECT ROUND(12.345, 2);    # 12.35
SELECT TRUNCATE(12.345, 2); # 12.34

SELECT CODE, CEIL((GNP/Population) * 1000)
FROM country;
SELECT CODE, ROUND((GNP/Population) * 1000, 2)
FROM country;
SELECT CODE, TRUNCATE((GNP/Population) * 1000, 2)
FROM country;

# 조건문

## IF(조건, 참, 거짓)

# 도시의 인구가 100만 이상: big city, 100만 미만: small city 출력
# column: city_scale
SELECT NAME, population, if(population >= 1000000, 'big city', 'small city') as city_scale
FROM city;

## IFNULL(참, 거짓)
# country 테이블에서 독립연도(IndepYear)가 없으면 0으로 출력
SELECT NAME, IFNULL(IndepYear, 0) AS IndepYear
FROM country;

## CASE
##		WHEN (조건1) THEN (출력1)
##		WHEN (조건2) THEN (출력2)
## END AS (컬럼명)
# 나라별 10억 이상, 1억이상, 1억 이하 조건을 출력
SELECT NAME, population, 
CASE
WHEN population >= 1000000000 THEN "10억 이상"
WHEN population >= 100000000 THEN "1억 이상"
ELSE	"1억 이하"
END AS result
FROM country;

## DATE_FORMAT: 날짜 데이터의 포맷을 변경해주는 함수
# sakila
USE sakila;

# payment에서 월별 총 매출 횟수와 총 매출 출력
SELECT DATE_FORMAT(payment_date, "%m") AS monthly, COUNT(amount), SUM(amount)
FROM payment
GROUP BY monthly;

## JOIN: pandas의 merge()와 비슷
# world
USE world;

CREATE TABLE USER(
	user_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(30) DEFAULT NULL,
	PRIMARY KEY(user_id)
)ENGINE=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE addr(
	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	addr VARCHAR(30) DEFAULT NULL,
	user_id INT(11) DEFAULT NULL,
	PRIMARY KEY(id)
)ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO USER(NAME)
VALUES ("jin"), ("po"), ("alice"), ("peter");

INSERT INTO addr(addr, user_id)
VALUES ("seoul", 1), ("busan", 2), ("daejeon", 3), ("daegu", 5), ("seoul", 6);

## left join
SELECT id, addr.addr, addr.user_id, IFNULL(USER.name, "-") AS name
FROM addr		# left
LEFT JOIN USER # right
ON addr.user_id = USER.user_id;

## right join
SELECT id, USER.user_id, addr.addr, USER.name
FROM addr
RIGHT JOIN USER
ON USER.user_id = addr.user_id;

# union: select 문의 결과를 합쳐서 출력, 자동으로 중복 제거
SELECT name
FROM USER
UNION
SELECT addr
FROM addr;

# union all: 중복 제거 안 함
SELECT NAME
FROM USER
UNION ALL
SELECT addr
FROM addr;

## outer join: left join, right join을  union
SELECT USER.NAME, addr.user_id, addr.addr AS address
FROM addr
LEFT JOIN USER	
ON addr.user_id = USER.user_id
UNION	
SELECT USER.NAME, addr.user_id, addr.addr AS address
FROM addr
RIGHT JOIN USER
ON USER.user_id = addr.user_id;

## sub-query: 쿼리문 안에 쿼리가 있는 문법(뒤에 또 나옴)
# select, from, where

# select절
# 전체 나라수, 전체 도시수, 전체 언어수를 출력 
SELECT	
(SELECT COUNT(name)
FROM country) AS total_counrty,
(SELECT COUNT(name)
FROM city) AS total_city,
(SELECT COUNT(DISTINCT(LANGUAGE))
FROM countrylanguage) AS total_language;

# from절
# 800만 이상이 되는 도시의 국가코드, 이름, 도시 인구 수 출력
-- SELECT CODE, NAME, population
-- FROM country
-- WHERE population >= 8000000;
SELECT *
FROM (
	SELECT countrycode, NAME, population
	FROM city
	WHERE population >= 8000000) AS city
JOIN(
	SELECT CODE, name
	FROM country) AS country
ON city.countrycode = country.code;

# where절
# 800만 이상 도시의 국가코드, 국가이름, 대통령이름 출력
-- SELECT CODE, NAME, HeadOfState
-- FROM country
-- WHERE population >= 8000000;

SELECT CODE, NAME, HeadOfState
FROM country
WHERE CODE IN (
	SELECT DISTINCT(countrycode)
	FROM city
	WHERE population >= 8000000);



























