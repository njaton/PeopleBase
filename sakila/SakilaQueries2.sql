select * 
from sakila.language;

select count(*) 
from sakila.language;
#---------------------------------------------------
select *
from sakila.payment;

# Goal: Find average amount paid.
select avg(amount)
from sakila.payment; #4.200667

# Goal: Find the stddev, min and max amounts paid. 
select stddev(amount), min(amount), max(amount)
from sakila.payment; # stddev = 2.36, min = 0.00, max = 11.99

# Goal: Get the customer id's that have spent over $10 
select customer_id
from sakila.payment
where amount > 10.00;

# How many of those customers are there? what is their average payment amount? 
select count(customer_id), avg(amount)
from sakila.payment
where amount > 10.00; # count = 114, average payment is 11.08

#--------------------------------------------------
select * 
from sakila.rental;

# Goal: Get the earliest and latest rental date.
select min(rental_date), max(rental_date) 
from sakila.rental; # Min = 2005-05-24 22:53:30, Max = 2006-02-14 15:16:03

# Goal: Get all data that involves staff_id 1
select * 
from sakila.rental
where staff_id = 1;

# Goal: Compare the amount of rentals between staff_id 1 & 2
select count(rental_id)
from sakila.rental
where staff_id = 1; #8040

select count(rental_id)
from sakila.rental
where staff_id = 2; #8004

#------------------------------------------
select * 
from sakila.address;

# Goal: Get all the infromation from addresses in california or alberta. 
select * 
from sakila.address
where district = 'California' or district = 'Alberta';

# Goal: What are the 3 smallest address_ids for this data set. 
select *
from sakila.address
where district = 'California' or district = 'Alberta'
order by address_id ASC
limit 3;

# Goal: What is the most common district in this dataset
select district, count(*)
from sakila.address
group by district
order by count(*) DESC
limit 1; # Buenos Aires at 10.

#Goal: Find the 3 most common district with city_id's over 250 
select district, count(*)
from sakila.address
where city_id > 250
group by district
order by count(*) DESC
limit 3; # England = 6, Shandong = 6, So Paulo = 6

#-----------------------------------------

