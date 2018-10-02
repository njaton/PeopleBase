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
# Goal: Find out how many countries start with an H.

select count(distinct Name)
from world.country
where `Name` like "H%";
 #There are 6 
 
#--------------------------------------------------------------
# Goal: Find the countries with a population over 5,000,000 that start with an S or A.

select * 
from world.country
where `Name` like "A%" or `Name` like "S" and `Population` > 5000000
order by `Population`DESC;

# Goal: Alter query to get the average Population and Life Expectancy.

select AVG(`Population`), AVG(`LifeExpectancy`)
from world.country
where `Name` like "A%" or `Name` like "S" and `Population` > 5000000;
#Pop = 9737266.6667, LE = 69.35714
#--------------------------------------------------------------- 
# Goal: Find out how many countries have English and Pashto as their official language.

select count(*)
from world.countrylanguage
where `Language` = 'English' and `IsOfficial` = 'T';
# 44 Countries 

select count(*)
from world.countrylanguage
where `Language` = 'Pashto' and `IsOfficial` = 'T';
# 1 Country
#--------------------------------------------------------------
# Goal: Find the average life Expectancy of the one country that uses Pashto officailly. 

select avg(LifeExpectancy)
from world.country
join world.countrylanguage on `Code` = `CountryCode`
where `language` = 'Pashto' and `IsOfficial` = 'T'group by `language`
order by avg(LifeExpectancy);

# 45.9 years
#-------------------------------------------------------------
# Goal: Find the amount of North American countries have spanish as their official language.

select count(*)
from world.country 
join world.countrylanguage on `Code` = `CountryCode`
where `language` = 'Spanish' and `IsOfficial` = 'T'group by `language` and Continent = 'North American';
#20 

# Goal: Get a idea of the current GNP status of said countries. 
select min(GNP), max(GNP), avg(GNP), stddev(GNP)
from world.country 
join world.countrylanguage on `Code` = `CountryCode`
where `language` = 'Spanish' and `IsOfficial` = 'T'group by `language` and Continent = 'North American';
# min = 1988.00, max = 553233.00, avg = 91320.250000, std = 151611.22998771397
#------------------------------------------------------------
# Goal: Find the top 3 most populated cities.

select *
from world.city
order by Population desc 
limit 3;
# Mumbai(Bombay) = 10500000, Seoul = 9981619 , Saeo Paulo = 9968485

# Goal: find the mean life expectancy of the countries they belong to. 
select avg(LifeExpectancy)
from world.country 
join world.city on `Code` = `CountryCode`
where world.city.Population > 9950000;
# 66.60000 years 

# Goal: Compare that value with the average life expectancy
select avg(LifeExpectancy)
from world.country;
# 66.48604
#pretty similar! 
#------------------------------------------------------------
# Goal: How many countries have over 5,000,000 people

select count(*) 
from world.city
where world.city.Population > 5000000;
#24 

# Goal: How many of these cities are in North America 
select count(*)
from world.country 
join world.city on `Code` = `CountryCode`
where world.city.Population > 5000000 and world.country.Continent = 'North America';
# 2

# Goal: Who are these cities
select world.city.Name
from world.country 
join world.city on `Code` = `CountryCode`
where world.city.Population > 5000000 and world.country.Continent = 'North America';
#Ciudad de MÃ©xico, New York
#-----------------------------------------------------------
# Goal: Determine the most popular forms of Government 

select GovernmentForm, count(GovernmentForm)
from world.country
group by GovernmentForm 
order by count(GovernmentForm) DESC
limit 5;

# Top 5: Republic, Constitutional Monarchy, Federal Republic, Dependent Territory of the UK,Monarchy


# Goal: How does this compare with the governments found in Asia

select GovernmentForm, count(GovernmentForm)
from world.country
where Continent = 'Asia' 
group by GovernmentForm 
order by count(GovernmentForm) DESC
limit 5;

# Top 5: Republic, Constitutional Monarchy, Monarchy, Special Administrative Region of China, Monarchy (Sultanate)
# Rather similar to the total.
#-----------------------------------------------------------