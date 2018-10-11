use sakila;
show tables;

select * 
from film 
limit 10; 

select * 
from film_actor
limit 10;

select *
from film_category
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

# Goal: Find out how many actors are in a the dataset. 
select count(distinct actor_id)
from film_actor; #200

# Goal: How many of those actors have appear in movies with a rental rate of 4+.
select count(distinct actor_id)
from film_actor
where film_id in (select film_id from film
					where rental_rate > 4); #200

# Goal: Double check that number do it again as a join.                     
select count(distinct actor_id)
from film_actor
join film on film.film_id = film_actor.film_id
where rental_rate > 4; #200

# Goal: How many of those actors achieved that rental rate with rated R movies. 
select count(distinct actor_id)
from film_actor
where film_id in (select film_id from film
					where rental_rate > 4 and rating = 'R'); #163
#--------------------------------------------------------------
# Goal: Find how many actors have been in a movie that has a length over 160
select count(distinct actor_id)
from film_actor
where film_id in (select film_id from film 
					where length > 160); # 199
                    
# Goal: How many of those actors where in movies with length > 160 that were rated G.
select count(distinct actor_id)
from film_actor
where film_id in (select film_id from film 
					where length > 160 and rating = 'G'); # 124
#--------------------------------------------------------------
# Goal: Get the average replacement cost and the standard deviation.
select avg(replacement_cost), std(replacement_cost)
from film; #avg = 19.98, std=6.048

# Goal: How does this change if the video is over 150 min
select avg(replacement_cost), std(replacement_cost)
from film
where length > 150; # avg = 19.90, std = 6.124

# Goal: Get the amount of videos below and above the avg and find max / min 
select count(*), min(replacement_cost)
from film 
where length > 150 and replacement_cost < 19.90; #count = 113, min = 9.99

select count(*), max(replacement_cost)
from film 
where length >150 and replacement_cost > 19.90; #count = 129 and max = 29.99
#----------------------------------------------------------------
# Goal: What acters have videos with a 29.99 replacement cost.  
select distinct actor_id
from film_actor 
where film_id in (select film_id from film
					where replacement_cost = 29.99)
order by actor_id ASC; 

# Goal: How many actors where included in the last statement. 
select count(distinct actor_id)
from film_actor 
where film_id in (select film_id from film
					where replacement_cost = 29.99); #162

# Goal: What actors have been in a movie with a 29.99 replacement cost 
# 		that also have a rental rate of 4.99
select distinct actor_id
from film_actor 
where film_id in (select film_id from film
					where replacement_cost = 29.99 and rental_rate = 4.99)
order by actor_id ASC; 

# Goal: How many actors where included in the last statement. 
select count(distinct actor_id)
from film_actor 
where film_id in (select film_id from film
					where replacement_cost = 29.99 and rental_rate = 4.99); #45 
#---------------------------------------------------------------
