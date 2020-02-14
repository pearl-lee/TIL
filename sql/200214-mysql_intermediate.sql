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







