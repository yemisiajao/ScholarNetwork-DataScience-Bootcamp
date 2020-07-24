
/*
Question 1: My partner and I want to come by each of the stores in person and meet the managers. Please send over 
the managers’ names at each store, with the full address of each property (street address, district, city, and 
country please).
*/

SELECT 
    s1.first_name AS managers_first_name,
    s1.last_name AS managers_last_name,
    s2.store_id,
    a.address AS street_address,
    a.district,
    c1.city,
    c2.country
FROM
    staff s1
        JOIN
    store s2 ON s1.staff_id = s2.manager_staff_id
        JOIN
    address a ON s2.address_id = a.address_id
        JOIN
    city c1 ON a.city_id = c1.city_id
        JOIN
    country c2 ON c1.country_id = c2.country_id;


/*
Question 2: I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, the inventory_id,
 the name of the film, the film’s rating, its rental rate and replacement cost.
 */ 

SELECT 
    i.store_id,
    i.inventory_id,
    f.title AS film_name,
    f.rating,
    f.rental_rate,
    f.replacement_cost
FROM
    inventory i
        JOIN
    film f ON i.film_id = f.film_id;


/*
Question 3: From the same list of films you just pulled, please roll that data up and provide a summary level 
overview of your inventory. We would like to know how many inventory items you have with each rating at each store.
*/ 

SELECT 
    i.store_id,
    COUNT(i.inventory_id) AS inventory_items,
    f.rating
FROM
    inventory i
        JOIN
    film f ON i.film_id = f.film_id
GROUP BY i.store_id , rating;


/*
Question 4: Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want 
to see how big of a hit it would be if a certain category of film became unpopular at a certain store. We would like
to see the number of films, as well as the average replacement cost, and total replacement cost, sliced by store 
and film category.
*/ 

SELECT 
    i.store_id,
    c.name AS film_category,
    COUNT(i.film_id) AS number_of_films,
    AVG(f.replacement_cost) AS average_replacement,
    SUM(f.replacement_cost) AS total_replacement
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    film_category fc ON i.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
GROUP BY store_id , c.name;


/*
Question 5: We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, and their full 
addresses – street address, city, and country.
*/ 

SELECT 
    c.first_name,
    c.last_name,
    c.store_id,
    c.active,
    a.address AS street_address,
    c1.city,
    c2.country
FROM
    customer c
        JOIN
    address a ON c.address_id = a.address_id
        JOIN
    city c1 ON a.city_id = c1.city_id
        JOIN
    country c2 ON c1.country_id = c2.country_id;
    
    
/*
Question 6: We would like to understand how much your customers are spending with you, and also to know who your 
most valuable customers are. Please pull together a list of customer names, their total lifetime rentals, and the 
sum of all payments you have collected from them. It would be great to see this ordered on total lifetime value, 
with the most valuable customers at the top of the list.
*/ 

SELECT 
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_lifetime_rentals,
    SUM(p.amount) AS all_payments_collected
FROM
    customer c
        JOIN
    rental r ON c.customer_id = r.customer_id
        JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY c.first_name , c.last_name
ORDER BY all_payments_collected DESC;

    
/*
Question 7: My partner and I would like to get to know your board of advisors and any current investors. Could you 
please provide a list of advisor and investor names in one table? Could you please note whether they are an 
investor or an advisor, and for the investors, it would be good to include which company they work with.
*/ 

SELECT 
    a.first_name,
    a.last_name,
    'advisor' AS role,
    NULL AS company_name
FROM
    advisor a 
UNION SELECT 
    i.first_name,
    i.last_name,
    'investor' AS role,
    i.company_name
FROM
    investor i;


/*
Question 8: We're interested in how well you have covered the most-awarded actors. Of all the actors with three 
types of awards, for what % of them do we carry a film? And how about for actors with two types of awards? Same 
questions. Finally, how about actors with just one award?
*/

SELECT 
    CASE
        WHEN aa.awards = 'Emmy, Oscar,Tony' THEN '3 awards'
        WHEN aa.awards IN ('Emmy,Oscar' , 'Emmy, Tony', 'Oscar,Tony') THEN '2 awards'
        ELSE '1 award'
    END AS number_ofawards,
    AVG(CASE
        WHEN aa.actor_id IS NULL THEN 0
        ELSE 1
    END) AS percentage_carry_afilm
FROM
    actor_award aa
GROUP BY number_ofawards;
