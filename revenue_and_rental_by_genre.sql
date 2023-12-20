--calculate revenue and rental count by genre
WITH RevenueByGenre_CTE AS (
    --calculate revenue by genre
    SELECT category.name AS genre, SUM(payment.amount) AS revenue
    FROM film_category
    INNER JOIN category ON film_category.category_id = category.category_id
    INNER JOIN film ON film_category.film_id = film.film_id
    INNER JOIN inventory ON film.film_id = inventory.inventory_id
    INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
    INNER JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY category.name
),
RentalsByGenre_CTE AS (
    --calculate rental count by genre
    SELECT category.name AS genre, COUNT(*) AS rental_count
    FROM film_category
    INNER JOIN category ON film_category.category_id = category.category_id
    INNER JOIN film ON film_category.film_id = film.film_id
    INNER JOIN inventory ON film.film_id = inventory.inventory_id
    INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
    GROUP BY category.name
)
--join revenue and rental count by genre
SELECT RevenueByGenre_CTE.genre, RevenueByGenre_CTE.revenue, RentalsByGenre_CTE.rental_count
FROM RevenueByGenre_CTE
INNER JOIN RentalsByGenre_CTE ON RevenueByGenre_CTE.genre = RentalsByGenre_CTE.genre
ORDER BY RevenueByGenre_CTE.genre;
