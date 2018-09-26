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
#--------------------------------------------------------------
#Goal: Find the 3 languages that appear in the most countries 

select count(*),`language`, AVG(Percentage)
from world.countrylanguage
group by `language`
order by count(*) DESC; #English, Arabic, and Spanish are the most common. 
#--------------------------------------------------------------
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
#--------------------------------------------------------------
#Goal: Get the mean Surface Area of countries that start with an "A"

select AVG(world.country.SurfaceArea) 
from world.country
where `Name` like "A%";

#1876837.066667
#--------------------------------------------------------------
#Goal: Find the average surface area of a all dutch speaking countries

select AVG(world.country.SurfaceArea)
from world.country
join world.countrylanguage on `Code` = `CountryCode`
where `language` = 'Dutch'
group by `language`;

#The average surface area is 2008729.400000
#--------------------------------------------------------------
#Goal: Determine mean life expectancy of countries that speak French, Chinese and Russian. 
#	Then compare their standard deviation.

select AVG(world.country.LifeExpectancy), STD(world.country.LifeExpectancy), `language`
from world.country
left outer join world.countrylanguage on `Code` = `CountryCode`
where `language` = 'French'  or`language` = 'Russian' or `language` = 'Chinese' 
group by `language`
order by AVG(world.country.LifeExpectancy);

# Russian AVG = 66.96250, STD = 4.812597070433529
# French AVG = 70.30000, STD = 11.6967006231994
# Chinese AVG = 72.26667, STD = 6.072341614054272

#---------------------------------------------------------------

