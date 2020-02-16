USE sakila;

## WITH ROLLUP: generates the subtotal row every time the product line changes and the grand total at the end of the result.
# 고객과 스탭별 매출과 고객별 매출의 총합을 출력
SELECT customer_id, staff_id, SUM(amount) AS amount
FROM payment
GROUP BY customer_id, staff_id
WITH ROLLUP;

### JOIN
##INNER JOIN: 공통된 값이 없는 row는 출력 안함

# addr, USER 테이블 합쳐 id, name, addr 출력(inner join)
SELECT id, USER.name, addr.addr
FROM addr
JOIN USER
ON addr.user_id = USER.user_id;

USE world;
SELECT *
FROM country;

SELECT city.name AS city, country.name AS country
FROM city
JOIN country
ON city.CountryCode = country.code;

SELECT city.name AS city, country.name AS country
FROM city, country
WHERE city.CountryCode = country.code;

# user, addr 테이블 합쳐 id, name, addr 출력(left join)
SELECT addr.id, USER.name, addr.addr
FROM addr
LEFT JOIN USER
ON addr.user_id = USER.user_id;

# user, addr 테이블 합쳐 id, name, addr 출력(right join)
SELECT addr.id, USER.name, addr.addr
FROM addr
RIGHT JOIN USER
ON addr.user_id = USER.user_id;

## JOIN, DISTINCT 활용
# 지역과 대륙별 사용하는 언어 출력
SELECT country.region, country.continent, countrylanguage.language
FROM country
JOIN countrylanguage
ON country.code = countrylanguage.countrycode;

# 대륙과 지역별 사용하는 언어의 수 출력
SELECT DISTINCT sub.region, sub.continent, COUNT(*) AS COUNT

FROM 
	(SELECT country.continent, country.Region, countrylanguage.Language
	FROM country
	JOIN countrylanguage
	ON country.code = countrylanguage.countrycode) AS sub
GROUP BY sub.region, sub.continent;

# 테이블 3개 조인
# 국가별, 도시별, 언어의 사용률
SELECT country.Name AS country, city.name AS city, countrylanguage.language, countrylanguage.percentage 
FROM country
JOIN city
ON country.code = city.countrycode
JOIN countrylanguage
ON country.code = countrylanguage.countrycode;

SELECT country.Name AS country, city.name AS city, countrylanguage.language, countrylanguage.percentage 
FROM country, city, countrylanguage
WHERE country.code = city.countrycode and country.code = countrylanguage.CountryCode;

SELECT * 
FROM country;

SELECT *
FROM countrylanguage;

SELECT *
FROM city;



