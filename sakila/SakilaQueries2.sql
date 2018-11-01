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

