--calculate revenue by country
WITH RevenueByCountry_CTE AS (
    SELECT country.country, SUM(payment.amount) AS revenue
    FROM country
    INNER JOIN city ON country.country_id = city.country_id
    INNER JOIN address ON city.city_id = address.city_id
    INNER JOIN customer ON address.address_id = customer.address_id
    INNER JOIN rental ON customer.customer_id = rental.customer_id
    INNER JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY country.country
),
RentalsByCountry_CTE AS (
    SELECT country.country, COUNT(*) AS rental_count
    FROM country
    INNER JOIN city ON country.country_id = city.country_id
    INNER JOIN address ON city.city_id = address.city_id
    INNER JOIN customer ON address.address_id = customer.address_id
    INNER JOIN rental ON customer.customer_id = rental.customer_id
    GROUP BY country.country
),
CustomerCountByCountry_CTE AS (
    SELECT country.country, COUNT(*) AS customer_count
    FROM country
    INNER JOIN city ON country.country_id = city.country_id
    INNER JOIN address ON city.city_id = address.city_id
    INNER JOIN customer ON address.address_id = customer.address_id
    GROUP BY country.country
)
--join revenue, rental count, and customer count by country
SELECT RevenueByCountry_CTE.country, RevenueByCountry_CTE.revenue, RentalsByCountry_CTE.rental_count, CustomerCountByCountry_CTE.customer_count
FROM RevenueByCountry_CTE
INNER JOIN RentalsByCountry_CTE ON RevenueByCountry_CTE.country = RentalsByCountry_CTE.country
INNER JOIN CustomerCountByCountry_CTE ON RevenueByCountry_CTE.country = CustomerCountByCountry_CTE.country
ORDER BY RevenueByCountry_CTE.country;
