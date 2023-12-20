--calculate revenue by film rating
WITH RevenueByRating_CTE AS (
    SELECT film.rating, SUM(payment.amount) AS revenue
    FROM film
    INNER JOIN inventory ON film.film_id = inventory.film_id
    INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
    INNER JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY film.rating
),
RentalsByRating_CTE AS (
    SELECT film.rating, COUNT(*) AS rental_count
    FROM film
    INNER JOIN inventory ON film.film_id = inventory.film_id
    INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
    GROUP BY film.rating
)
--join revenue and rental count by film rating
SELECT RevenueByRating_CTE.rating, RevenueByRating_CTE.revenue, RentalsByRating_CTE.rental_count
FROM RevenueByRating_CTE
INNER JOIN RentalsByRating_CTE ON RevenueByRating_CTE.rating = RentalsByRating_CTE.rating
ORDER BY RevenueByRating_CTE.rating;
