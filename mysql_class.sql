-- 1a
select first_name,last_name
from actor;
-- 1b
select concat(first_name," ",last_name) as "Actor Name"
from actor;
-- 2a
select actor_id,first_name,last_name 
from actor
where first_name= "JOE";
-- 2b
select * 
from actor
where last_name like "%GEN%";
-- 2c
select *
from actor
where last_name like "%LI%"
order by last_name,first_name;
-- 2d
select country_id,country
from country
where country in('Afghanistan','Bangladesh','China');
-- 3a
ALTER TABLE `sakila`.`actor` 
ADD COLUMN `description` BLOB NULL AFTER `last_update`;
-- 3b
ALTER TABLE `sakila`.`actor` 
DROP COLUMN `description`;
-- 4a
select last_name,count(*)
from actor
group by last_name;
-- 4b
select last_name,count(*)
from actor
group by last_name
having count(*) >1;
-- 4c
update actor set
first_name='HARPO'
where first_name='GROUCHO' and
      last_name='WILLIAMS';
-- 4d
update actor set
first_name='GROUCHO'
where first_name='HARPO';  
-- 5a
show create table address;
-- 6a
select first_name,last_name,address,address2,city,postal_code
from staff s
join address a
on a.address_id = s.address_id
 join city c
 on   c.city_id = a.city_id;
 -- 6b
 select first_name,last_name,format(tot_amt,2) as "Total Amount"
 from(
 select s.staff_id,sum(p.amount) as Tot_amt
 from staff s
 join payment p
 on p.staff_id = s.staff_id
 where p.payment_date between str_to_date ('08/01/2005','%m/%d/%Y') and str_to_date ('08/31/2005','%m/%d/%Y')) x,
 staff s
 where s.staff_id = x.staff_id;
 -- 6c
 Select f.title,count(*) as "Actors"
 from film f 
 inner join film_actor a
 on f.film_id = a.film_id
 group by f.title;
 -- 6d
 Select count(*) as "Movies in Inventory"
 from inventory i
 join film f
 on i.film_id = f.film_id
 where title = "Hunchback Impossible";
 -- 6e
 select first_name,last_name,sum(amount) "Total Amount Paid"
 from customer c
 join payment p
 on c.customer_id = p.customer_id
 group by first_name,last_name
 order by last_name;
 -- 7a
 Select title
 from film
 where (title like 'K%' or title like 'Q%') and language_id = 1;
 -- 7b
 select first_name,last_name
 from
 (
 select film_id
 from film
 where title = "Alone Trip") m
 join film_actor f
 on m.film_id = f.film_id
 join actor a
 on a.actor_id = f.actor_id;
 -- 7c
 Select first_name,last_name,email
 from customer c
 join address a
 on c.address_id = a.address_id
 join city t
 on t.city_id = a.city_id
 join country o
 on o.country_id = t.country_id
 where o.country = 'Canada';
 -- 7d
 Select f.title
 from film f
 join film_category fc
 on f.film_id = fc.film_id
 join category c
 on c.category_id = fc.category_id
 where c.name = 'Family';
 -- 7e
 select title
 from(
 Select title,count(*) as cnt
 from film f
  join inventory i
 on i.film_id = f.film_id
  join rental r
 on r.inventory_id = i.inventory_id
 group by title
 order by cnt desc) x;
 -- 7f
 Select s.store_id,format(sum(p.amount),2) amt
 from payment p
 join rental r
 on r.rental_id = p.rental_id
 join inventory i
 on i.inventory_id = r.inventory_id
 join store s
 on s.store_id = i.store_id
 group by s.store_id;
 -- 7g
 select s.store_id,c.city,co.country
 from store s
 join address a
 on a.address_id = s.address_id
 join city c
 on c.city_id = a.city_id
 join country co
 on co.country_id = c.country_id;
 -- 7h
 select ca.name as "Genres",format(sum(p.amount),2) as "Gross Revenue"
 from category ca
 join film_category fc
 on fc.category_id = ca.category_id
 join inventory i
 on i.film_id = fc.film_id
 join rental r
 on r.inventory_id = i.inventory_id
 join payment p
 on p.rental_id = r.rental_id
 group by ca.name
 order by sum(p.amount) desc
 limit 5;
 -- 8a
 CREATE  OR REPLACE VIEW `top_five_genres` AS
select ca.name as "Genres",format(sum(p.amount),2) as "Gross Revenue"
 from category ca
 join film_category fc
 on fc.category_id = ca.category_id
 join inventory i
 on i.film_id = fc.film_id
 join rental r
 on r.inventory_id = i.inventory_id
 join payment p
 on p.rental_id = r.rental_id
 group by ca.name
 order by sum(p.amount) desc
 limit 5;
-- 8b
select * from top_five_genres;
-- 8c
drop view top_five_genres;
 