use mavenmovies;
-- Identify the primary and foreign keys and in maven movies db.Discuss the differences.
-- A primary key is a key that uniquely identifies each record of a row. 
-- A foreign key is a key that refers to the primary key in another table.
describe film;
-- In table actor, actor_id is the primary key and last_name is the foreign key.

-- In table actor_award, actor_award_id is the primary key and last_name is the foreign key.

-- In table address, address_id is the primary key and city_id is the foreign key.

-- In table advisor, advisor_id is the primary key.

-- In table category, category_id is the primary key.

-- In table city, city_id is the primary key and country_id is the foreign key.

-- In table country, country_id is the primary key.

-- In table customer, customer_id is the primary key and store_id, last_name and address_id are the foreign keys.
 
 -- In table film, film_id is the primary key and title, language_id, original_language_id are the foreign keys.

-- In table film_actor, actor_id and film_id are the primary keys.

-- In table film_category, film_id and category_id are the primary keys.

-- In table film_text, film_id is the primary key and title is the foreign key.

-- In table inventory, inventory_id is the primary key and film_id and store_id are the foreign keys.

-- In table investor, investor_id is the primary key.

-- In table language, language_id is the primary key.

-- In table payment, payment_id is the primary key and customer_id,staff_id and rental_id are the foreign keys.

-- In table rental, rental_id is the primary_key and rental_date, inventory_id, customer_id and staff_id are the foreign keys.

-- In table staff, staff_id is the primary key and address_id and store_id are the foreign keys.

-- in table store, store_id is the primary_key and address_id is the foreign key and manager_staff_id is the unique key.

-- q2: List all details of actors

select * from actor;

-- q3: list all customer information from DB

select * from customer;

-- q4:list different countries
select distinct country from country;

-- q5:display all active customers
select first_name,last_name from customer where active=1;

-- q6:list all rental ids for customer with id 1
select rental_id from rental where customer_id=1;

-- q7:display all the film whose rental duration is grater than 5;
select title from film where rental_duration>5;

-- q8:list the total no of films whose replacement cost is grater than $15 and less than $20
select count(*) as Total_films from film where replacement_cost>15 and replacement_cost<20;

-- q9:find the no of films whose rental rate is less than $1
select count(film_id) as no_of_films from film where rental_rate<1;

-- q10:display the count of unique first names of actors
select  count(distinct first_name) as unique_first_names from actor;

-- q11:display the first 10 records from the customer table
select * from customer limit 10;

-- q12:display the 1st 3 records from the customer table whose first name starts with 'b'
select * from customer where first_name like 'b%' limit 3;

-- q13:display the names of the first 5 movies which are rated as 'g'
select title from film where rating like 'g' limit 5;

-- q14:find all the customers whose first name starts with 'a'
select concat(first_name," ", last_name) as customers from customer where first_name like 'a%';

-- q15: find all the customers whose first name ends with 'a'
select concat(first_name," ", last_name)as customers from customer where first_name like '%a';

-- q16: the list of 4 cities which start and end with 'a'
select city from city where city like '%a%' limit 4;

-- q17: customers whose first_name have 'ni' in any position
select concat(first_name," ", last_name) as customers from customer where first_name like '%ni%';

-- q18: customers whose first name has 'r' in the 2nd position
select first_name,last_name from customer where first_name like '_r%';

-- q19: customers whose first name starts with 'a' and are atleast 5 characters in length
select first_name,last_name from customer where first_name like 'a%' and length(first_name)>=5;

-- q20: customers whose first_name starts with 'a' and ends with 'o';
select first_name,last_name from customer where first_name like 'a%o';

-- q21:films with pg and pg-13 rating using IN operator
select title from film where rating in ('pg', 'pg-13');

-- q22:films with length between 50 to 100 using between operator
select title from film where length between 50 and 100;

-- q23:get the top 50 actors using limit operator
select concat(first_name," ",last_name) as actors from actor order by actor_id desc limit 50;

-- q24:get the distinct film_ids from inventory table
select distinct(film_id) from inventory;



