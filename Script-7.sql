-- 1. List all customers who live in Texas
-- customer and address both have address_id

select first_name, last_name, address, district
from customer
inner join address
on customer.address_id = address.address_id 
where district = 'Texas';

-- 2. Get all payments above $6.99 with the customer's full name
-- link between customer_id
select first_name, last_name, amount
from customer
inner join payment
on customer.customer_id = payment.customer_id 
where amount > 6.99;

-- if we want to avoid duplicate name and summary the total amount with each customer
select first_name, last_name, sum(amount)
from customer
inner join payment
on customer.customer_id = payment.customer_id 
group by first_name, last_name
having sum(amount) > 6.99;

-- 3. Use subqueries to show all customers' name who have made payments over $175
select first_name, last_name
from customer
where customer_id in(
    select customer_id 
    from payment 
    group by customer_id 
    having sum(amount) > 175
    order by sum(amount) desc
);


-- 4. List all customers that live in Nepal, use the city table
-- customer and address both have address_id
-- address and city are linked between city_id
-- city and country are linked between country_id
select first_name, last_name, address, country
from customer
inner join address
on address.address_id = customer.address_id 
inner join city 
on address.city_id = city.city_id 
inner join country 
on city.country_id = country.country_id 
where country = 'Nepal';

--5.  List the staff member that had the most transaction
-- staff and payment are linked between staff_id
select first_name, last_name , sum(amount)
from staff
inner join payment 
on staff.staff_id = payment.staff_id
group by first_name, last_name 
order by sum(amount) desc;

-- 6. Find out how many movie of each rating are there
select rating, COUNT(*) as movie_count
from film
group by rating
order by movie_count desc;

-- 7. Show all customers who have made a single payment above $6.99 using subqueries
select first_name, last_name
from customer
where customer_id in (
    select customer_id 
    from payment 
    where amount > 6.99
);

-- 8. How many free rentals did store give away
--payment and rental are linked with rental_id
select count(*) as free_rentals_count
from rental r
where not exists (
    select 1
    from payment p
    where p.rental_id = r.rental_id and p.amount > 0
);



