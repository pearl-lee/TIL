USE sakila;
# 1. 가장 돈을 많이 지불한 고객 상위 5명의 이름과 지불 금액 출력
SELECT payment.customer_id, 
	CONCAT(customer.first_name, ' ',customer.last_name) AS full_name,
	sum(payment.amount) AS amount
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY customer_id
ORDER BY amount DESC
LIMIT 5;

# 2. 배우별 영화 출연 횟수 출력(상위 10개)

SELECT *
FROM film_actor;
SELECT *
FROM actor;

SELECT film_actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name) AS full_name
	, COUNT(film_actor.film_id) AS count
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id
GROUP BY film_actor.actor_id
ORDER BY COUNT DESC, full_name
LIMIT 10;

# 3. 영화 카테고리별 수입 데이터를 내림차순으로 정렬
# payment, rental, inventory, film_category, category 테이블 사용

SELECT category.name, sum(payment.amount) AS total_amount
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
JOIN payment 
ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY total_amount DESC;


### 테이블을 여러개 조인할 때, 한줄로 다 써도 가능
### 주로 Primary Key를 이용해서 조인
SELECT category.name, sum(payment.amount) AS total_amount
FROM payment, rental, inventory, film_category, category
WHERE 
	category.category_id = film_category.category_id
	AND film_category.film_id = inventory.film_id
	AND inventory.inventory_id = rental.inventory_id
	AND rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY total_amount desc;
