--top 5 cities in the top 10 countries
WITH TopCitiesOfTopCountries_CTE AS (
    SELECT 
        city 
    FROM 
        customer a 
        INNER JOIN address b ON a.address_id = b.address_id 
        INNER JOIN city c ON b.city_id = c.city_id 
        INNER JOIN country d ON c.country_id = d.country_id 
    WHERE 
        d.country IN (
            --top 10 countries by the number of accounts
            SELECT 
                country 
            FROM 
                customer a 
                INNER JOIN address b ON a.address_id = b.address_id 
                INNER JOIN city c ON b.city_id = c.city_id 
                INNER JOIN country d ON c.country_id = d.country_id 
            GROUP BY 
                country 
            ORDER BY 
                COUNT(customer_id) DESC 
            LIMIT 
                10
        ) 
    GROUP BY 
        country, 
        city 
    ORDER BY 
        COUNT(customer_id) DESC 
    LIMIT 
        10
)
SELECT 
    a.customer_id, 
    b.first_name, 
    b.last_name, 
    e.country, 
    d.city, 
    SUM(amount) AS total_paid_amount 
FROM 
    payment a 
    INNER JOIN customer b ON a.customer_id = b.customer_id 
    INNER JOIN address c ON b.address_id = c.address_id 
    INNER JOIN city d ON c.city_id = d.city_id 
    INNER JOIN country e ON d.country_id = e.country_id 
    INNER JOIN TopCitiesOfTopCountries_CTE tc ON d.city = tc.city
GROUP BY 
    a.customer_id, 
    b.first_name, 
    b.last_name, 
    e.country, 
    d.city 
ORDER BY 
    total_paid_amount DESC 
LIMIT 
    5;
