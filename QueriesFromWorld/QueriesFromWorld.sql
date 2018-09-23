#This project is using the "world" database found here : https://dev.mysql.com/doc/world-setup/en/
#Queries written by Nicholas Jaton
use world;
show tables;

#View the data to get an idea of how to go about working with each table
select * 
from world.city
limit 10;

select * 
from world.country
limit 10;

select * 
from world.countrylanguage
limit 10;

#Goal: Find the 3 languages that appear in the most countries 

select count(*),`language`, AVG(Percentage)
from world.countrylanguage
group by `language`
order by count(*) DESC; #English, Arabic, and Spanish are the most common. 

#Goal: Out of the 10 most spread out languages. What languages carry the highest percentage of use and grab STDDEV. 

select AVG(Percentage), stddev(Percentage), count(*), `language`
from world.countrylanguage
where `language` in (select * from (select `language`
						from world.countrylanguage
                        group by `language`
                        order by count(*) DESC
                        limit 10) temp_tab)
group by `language`
order by AVG(Percentage) DESC; 

select `language`, AVG(Population)
from world.country
left outer join world.countrylanguage on `Code` = `CountryCode`
where `language`= 'English' or `language`= 'Spanish' or `language`= 'Arabic'
group by `language` 
order by AVG(Population) DESC;

# Spanish = 26796314.2857, Arabic = 16728639.3939, English = 10456971.6667

