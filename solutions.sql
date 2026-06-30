-- Add you solution queries below:

--1 Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

--2 Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, sum(amount) AS TOTAL_BUSINESS
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

--3 What is the average running time of films by category?
SELECT c.name, avg(f.length)
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name;

--4 Which film categories are longest?
SELECT c.name, avg(f.length)
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg(f.length) DESC;

--5 Display the most frequently rented movies in descending order.
SELECT f.title, count(r.inventory_id)
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY count(r.inventory_id) DESC
LIMIT 10;

--6 List the top five genres in gross revenue in descending order.
SELECT c.name, sum(p.amount)
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film_category AS fc ON i.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY sum(p.amount) DESC
LIMIT 5;

--7 Is "Academy Dinosaur" available for rent from Store 1?
SELECT
CASE
WHEN EXISTS (
SELECT 1
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1
AND i.inventory_id NOT IN (
SELECT inventory_id FROM rental WHERE return_date IS NULL
)
) THEN 'Yes'
ELSE 'No'
END AS is_available;
