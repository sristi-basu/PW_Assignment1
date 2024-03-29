use sakila;
-- q1: Retrieve total no of rentals made in sakila db.Hint: Use the COUNT() function.
select count(rental_id) as total_no_of_rentals from rental;
select * from rental;

-- q2:avg rental duration(in days) of movies rented from the sakila db.Hint: Utilize the AVG() function.
select avg(datediff(return_date,rental_date))as avg_rental_duration from rental;

-- q3: first name and last name of customers in uppercase.Hint: Use the UPPER () function.
select upper( first_name) as first_name, upper(last_name)as last_name from customer;

-- q4: display the month from the rental date and display it alongside the rental id.Hint: Employ the MONTH() function.
select month(rental_date) as month,rental_id from rental;

-- Group By

-- Q5: the count of rentals for each customer (customer_id and count of rentals).Hint: Use COUNT () in conjunction with GROUP BY.
select count(rental_id)as count_of_rentals,c.customer_id
from customer c
left join rental r
on c.customer_id=r.customer_id
group by c.customer_id;

-- q6: total revenue generated by each store.Hint: Combine SUM() and GROUP BY.
select sum(amount)as total_revenue,store.store_id
from store  
join staff 
on store.store_id=staff.store_id
join payment p
on staff.staff_id=p.staff_id
group by store.store_id; 

-- joins

-- q7: display the title of movie,customer first_name,last name who rented it.Hint: Use JOIN between the film, inventory, rental, and customer tables
-- rental,customer table.
-- film- title,film_id
-- inventory- inventory_id,film_id
-- rental- rental_id,c_id,inventory_id
-- customer- fname,lname,c_id

select film.title,customer.first_name,customer.last_name 
from film
inner join inventory
on film.film_id=inventory.film_id
inner join rental
on inventory.inventory_id=rental.inventory_id
inner join customer
on rental.customer_id=customer.customer_id;

-- q8: names of all actors who have appeared in the film "gone with the wind".Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
select concat(first_name," ",last_name) as name,title 
from actor
join film_actor
on actor.actor_id=film_actor.actor_id
inner join film
on film_actor.film_id=film.film_id
where film.title ='gone with the wind';

-- grp by
-- q1: total no of rentals for each category of movies.Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
-- film_category:film_id,cat_id
-- film:filmid,title,
-- rental:rentalid,custid,inventid,
-- inventory-inventory_id,film_id

select count(rental_id) as total_no_of_rentals,category_id as category
from rental r
inner join inventory i
on r.inventory_id=i.inventory_id
inner join film f
on i.film_id=f.film_id
inner join film_category fc
on f.film_id=fc.film_id
group by fc.category_id;

-- q2:avg rental rate of movies in each language.Hint: JOIN film and language tables, then use AVG () and GROUP BY.
-- film:filmid,title,rental_rate,lan_id
-- language:lanid,

select avg(rental_rate) as avg_rental_rate,name as language
from film f
join language l
on f.language_id=l.language_id
group by l.name;

-- joins
-- q3: customer names along with total amt they have spent on rentals.Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
-- payment: paym_id,cus_id,ren_id,staff_id,amt
-- customer:fname,lname,c_id,store_id,add_id
-- rental: ren_id,inven_id,cus_id,staff_id

select concat(first_name," ",last_name) as customer_names,sum(amount) as amount_spent
from customer c
join payment p
on c.customer_id=p.customer_id
join rental r
on p.customer_id=r.customer_id
group by c.customer_id;

-- q4: titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
-- customer:custid,storeid,addid
-- address:addid,city_id,
-- city:city_id,city,cntryid,
-- rental:rentalid,inventoryid,custid,staffid
-- inventory:inventoryid,filmid,storeid
-- film:filmid,title,langid

select title as rented_movie,concat(first_name," ",last_name) as customer,city
from film f
join inventory i
on f.film_id=i.film_id
join rental r
on i.inventory_id=r.inventory_id
join customer cus
on r.customer_id=cus.customer_id
join address a
on cus.address_id=a.address_id
join city ci
on a.city_id=ci.city_id
where ci.city ='london';

-- advanced joins
-- q5: Display the top 5 rented movies along with the number of times they've been rented.Hint: JOIN film, inventory, and rental tables, then use cOUNT() and GROUP BY, and limit the results.

-- rental:rentalid,inventoryid,custid,staffid
-- inventory:inventoryid,filmid,storeid
-- film:filmid,title,langid
use sakila;
select title,count(*)as rental_count
from film f
inner join inventory i
on f.film_id=i.film_id
inner join rental r
on i.inventory_id=r.inventory_id
group by title
order by rental_count desc
limit 5;
use sakila;

-- q6: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
-- rental:rentalid,inventoryid,custid,staffid
-- inventory:inventoryid,filmid,storeid
-- customer:custid,storeid,addid
-- store:store_id,

select concat(first_name," ",last_name) customers,c.customer_id
from customer c
join rental r
on c.customer_id=r.rental_id 
join inventory i
on r.inventory_id=i.inventory_id
join store s
on i.store_id=s.store_id
where s.store_id in(1,2)
group by c.customer_id,c.first_name,c.last_name
having count(distinct s.store_id)=2;