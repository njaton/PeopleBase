use sakila;
show tables;

select * 
from film 
limit 10; 
#-------------------------------------------------------------
# Goal: Get average movie length 
select AVG(length) 
from film; #115.2720 Min 

# Goal: find average movie length of PG movies and compare it to PG-13 movies. 
select avg(length)
from film
where rating = 'PG'; #112.0052

select avg(length)
from film 
where rating = 'PG-13'; #120.4439
#-------------------------------------------------------------
# Goal: Query the movies that have a less than average length and have a rental rate of 3+
select * 
from film 
where length < 115.27 and rental_rate > 3;

# Goal: find the amounts of these films in each rating bracket.
select count(*) , rating
from film
where length < 115.27 and rental_rate > 3
group by rating; #G = 31, PG-13 = 30, R = 33, NC-17 = 35, PG = 38

#Goal: find the standard deviation and average length of rate R movies in the previous data set. 
select std(length), avg(length)
from film
where length < 115.27 and rental_rate > 3 and rating = 'R'
group by rating; #std = 20.15, avg = 80.333
#---------------------------------------------------------------