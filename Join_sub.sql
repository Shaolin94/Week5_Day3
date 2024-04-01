--1. List all customers with their address who live in Texas (use JOINs)

SELECT first_name, last_name, district 
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--2. List all payments of more than $7.00 with the customer’s first and last name

SELECT first_name, last_name, amount
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id 
WHERE amount > 7
ORDER BY amount, first_name, last_name;

--3. Show all customer names who have made over $175 in payments (use subqueries)

SELECT * FROM customer JOIN(
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING sum(amount) > 175) AS temp_table
ON temp_table.customer_id = customer.customer_id;

--4. List all customers that live in Argentina (use multiple joins)

SELECT first_name, last_name, district, city, country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id;

--5. Show all the film categories with their count in descending order

SELECT 
    film_category.category_id, 
    category.name, 
    COUNT(film.title) AS title 
FROM 
    film_category 
INNER JOIN 
    category 
ON (film_category.category_id = category.category_id) 
INNER JOIN 
    film 
ON (film_category.film_id = film.film_id) 
GROUP BY 
    film_category.category_id, 
    category.name 
ORDER BY 
    title DESC;

--6. What film had the most actors in it (show film info)?
--Answer: Lambs Cincinatti only has 15 actors

SELECT 
    film.film_id, 
    film.title, 
    COUNT(film_actor.actor_id) AS actorid 
FROM 
    film_actor 
INNER JOIN 
    film 
ON (film_actor.film_id = film.film_id) 
GROUP BY 
    film.film_id, 
    film.title 
ORDER BY 
    actorid DESC
LIMIT 1;
	
--7. Which actor has been in the least movies?
--Answer: Emily has in 14 films

SELECT 
    actor.actor_id, 
    actor.first_name, 
    actor.last_name, 
    COUNT(film.title) AS num_films 
FROM 
    film_actor 
INNER JOIN 
    actor 
ON (film_actor.actor_id = actor.actor_id) 
INNER JOIN 
    film 
ON (film_actor.film_id = film.film_id) 
GROUP BY 
    actor.actor_id, 
    actor.first_name, 
    actor.last_name 
ORDER BY 
    num_films ASC
LIMIT 1;

--8. Which country has the most cities?
--Answer: India has 60 cities

SELECT 
    country.country_id, 
    country.country, 
    COUNT(city.city) AS num_cities 
FROM 
    city 
INNER JOIN 
    country 
ON (city.country_id = country.country_id) 
GROUP BY 
    country.country_id, 
    country.country 
ORDER BY 
    num_cities DESC
LIMIT 1

--9. List the actors who have been in between 20 and 25 films.

SELECT 
    actor.actor_id, 
    actor.first_name, 
    actor.last_name, 
    COUNT(film.title) AS COUNT 
FROM 
    film_actor 
INNER JOIN 
    actor 
ON (film_actor.actor_id = actor.actor_id) 
INNER JOIN 
    film 
ON (film_actor.film_id = film.film_id) 
GROUP BY 
    actor.actor_id, 
    actor.first_name, 
    actor.last_name 
HAVING 
    COUNT(film.title) BETWEEN 20 AND 25
ORDER BY COUNT desc, last_name DESC