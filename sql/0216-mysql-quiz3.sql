# quiz3 - join & sub-query

# 1. 멕시코보다 인구가 많은 나라이름과 인구수를 조회하고 인구수 순으로 내림차순
SELECT NAME, population
FROM country
WHERE population > 98881000
ORDER BY population DESC;
SELECT population
FROM country
WHERE NAME = 'Mexico';

SELECT NAME, population
FROM country
WHERE population > (SELECT population FROM country WHERE NAME = 'Mexico')
ORDER USER1BY population DESC;

# 2. 국가별 몇개의 도시가 있는지 조회하고 도시수 순으로 10위까지 내림차순
SELECT country.NAME, count(city.name) AS city_
FROM country
JOIN city
ON country.Code = city.countrycode
GROUP BY country.name
ORDER BY city_ DESC
LIMIT 10;

USE world;
# 3. 언어별 사용인구를 출력하고 언어 사용인구 순으로 10위까지 내림차순
SELECT countrylanguage.language, 
	sum(country.population*countrylanguage.percentage) AS count
FROM countrylanguage
JOIN country
ON countrylanguage.CountryCode = country.code
GROUP BY countrylanguage.language 
order BY count DESC
LIMIT 10; 

# 4. 나라 전체 인구의 10%이상인 도시에서 도시인구가 500만이 넘는 도시 조회
SELECT city.name, city.countrycode, country.name, 
	ROUND((city.Population / country.population)*100, 2) AS percentage
FROM city
JOIN country
ON city.countrycode = country.code
WHERE city.Population > 5000000 AND (city.Population / country.population)* 100 >= 10
ORDER BY percentage DESC;

# 5. 면적이 10,000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고, 
# 인구밀도가 200이상인 국가들의 사용하고 있는 언어 수가 5가지 이상인 나라 조회
SELECT CODE, NAME, ROUND(Population/SurfaceArea) AS density
FROM country
WHERE SurfaceArea >= 10000 AND (Population/SurfaceArea) >= 200
ORDER BY density DESC;    

SELECT country.name, COUNT(countrylanguage.LANGUAGE) AS language_count
FROM countrylanguage
JOIN country
ON countrylanguage.countrycode = country.code
WHERE country.SurfaceArea >= 10000 AND (country.Population/country.SurfaceArea) >= 200
GROUP BY	countrycode
HAVING language_count >= 5
ORDER BY language_count DESC;

USE world;
# 6. 사용하는 언어가 3가지 이하인 국가중 도시인구가 300만 이상인 도시 조회
# GROUP_CONCAT(LANGUAGE)이용
# VIEW 이용하여 query를 깔끔하게 수정하기
CREATE VIEW city_lang AS
(SELECT city.countrycode, city.NAME AS city_name, city.population,
	lang.language_count, lang.languages
FROM (
SELECT countrycode, COUNT(LANGUAGE) AS language_count, 
	GROUP_CONCAT(LANGUAGE) AS languages
FROM countrylanguage
GROUP BY countrycode
HAVING language_count <= 3) AS lang
JOIN (
	SELECT countrycode, NAME, population
	FROM city
	WHERE population >= 3000000) AS city
ON lang.countrycode = city.countrycode);

SELECT *
FROM city_lang;

SELECT cl.countrycode, cl.city_name, cl.population, 
	country.name, cl.language_count, cl.languages
FROM city_lang AS cl
JOIN country
ON cl.countrycode = country.code
ORDER BY population DESC;