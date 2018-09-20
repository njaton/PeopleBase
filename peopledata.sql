create schema peopledata;

INSERT INTO `peopledata`.`new_table`
(`ID`,`Name`,`Age`,`Job`,`Salary`)
VALUES (1,'tom',22,'Retail Manager',24000);

select * 
from peopledata.new_table;

SET SQL_SAFE_UPDATES = 0;
delete from peopledata.new_table where id = '2';

INSERT INTO `peopledata`.`new_table`
(`ID`,`Name`,`Age`,`Job`,`Salary`)
values 
	(2,'Sam', 22, 'Accountant',50000),
	(3,'John', 24, 'Software Engineer',54000),
	(4,'Jack', 32, 'Bi developer',65000),
	(5,'Sean', 32, 'Sales manager',85000),
    (6,'Mattie', 25, 'Insurance Sales Person',49000),
    (7,'Becky', 36, 'Data Analyst',68000),
    (8,'Jessica', 24, 'IT analyst',46000),
    (9,'Bruce', 19, 'Car Sales Person',52000),
	(10,'Freddy', 34, 'CEO',104000);
    
INSERT INTO `peopledata`.`new_table`
(`ID`,`Name`,`Age`,`Job`,`Salary`)
values 
	(11,'Josh', 42, 'Aerospace Engineer', 95000),
	(12,'Asheley', 22, 'database Admin',59000),
	(13,'John', 33, 'Civil Engineer', 74000),
	(14,'Jackie', 32, 'CIO',125000),
    (15,'Matt', 29, 'Consultant',92000),
    (16,'Zach', 36, 'Data Scientist',99000),
    (17,'Jesse', 24, 'Actress', 22000),
    (18,'Forest', 27, 'Musician', 17000),
	(19,'Anna', 38, 'Police Officier',104000);
    
update peopledata.new_table 
set Name = 'Tom'
where id = '1';

update peopledata.new_table
set Job = 'Database Admin'
where ID = '12';

alter table peopledata.new_table
add column Degree varchar(60) after Age;
 
set sql_mode='';
insert into `peopledata`.`new_table`
	(`ID`,`Degree`)
values 
	(1,'BA'),
    (2,'BS'),
    (3,'BS'),
    (4,'BS'),
    (5,'None'),
    (6,'MA'),
    (7,'BS'),
    (8,'BA'),
    (9,'BS'),
    (10,'None'),
    (11,'MS'),
    (12,'BS'),
    (13,'BS'),
    (14,'PhD'),
    (15,'None'),
    (16,'MS'),
    (17,'None'),
    (18,'MA'),
    (19,'BS')
on duplicate key update `id`=values(`id`), Degree=values(`Degree`);


#Get General Demographics
select avg(salary)
from peopledata.new_table; #67578.95

select min(salary)
from peopledata.new_table; #17000

select max(salary)
from peopledata.new_table; #125000

select stddev(salary)
from peopledata.new_table; #29729.16

select count(*)
from peopledata.new_table
where Degree = 'BS'; #8

select avg(salary)
from peopledata.new_table
where degree = 'BS'; #65750.00

select avg(salary)
from peopledata.new_table
where degree = 'BS' and age > '24'; #77750.00

#Second table
CREATE TABLE `peopledata`.`Second_Table` (
  `idnew_table` INT NOT NULL,
  `House / Apartment` VARCHAR(45) NOT NULL,
  `Home_Value` INT NOT NULL,
  PRIMARY KEY (`idnew_table`));
  
alter table `peopledata`.`Second_Table`modify `Home_Value` int;

insert into `peopledata`.`Second_Table` (`idnew_table`,`House / Apartment`,`Home_Value`)
value
	(1, 'House', '105000'),
    (2, 'Apartment', NULL),
    (3, 'House', '135000'),
    (4, 'House', '205000'),
    (5, 'Apartment', NULL),
    (6, 'Apartment', '128000'),
    (7, 'House', '165000'),
    (8, 'House', '153000'),
    (9, 'House', '105000'),
    (10, 'Apartment', NULL),
    (11, 'Apartment', NULL),
    (12, 'House', '200000'),
    (13, 'House', '210000'),
    (14, 'House', '265000'),
    (15, 'Apartment', NULL),
    (16, 'House', '125000'),
    (17, 'House', '99000'),
    (18, 'Apartment', NULL),
    (19, 'House', '175000');
    
select * 
from peopledata.Second_Table;

#Join Options
 
select *
from peopledata.new_table
inner join peopledata.Second_Table
on ID=idnew_table;

select ID, Age, Salary, Home_Value
from peopledata.new_table
left outer join peopledata.Second_Table
	on ID = idnew_table
where Home_Value is not null and salary >= 60000
group by ID DESC;

#Get General Demographics
select avg(Salary) 
from peopledata.new_table
where ID in (select idnew_table from peopledata.Second_Table
				where `House / Apartment` is not null) and age <= 40; #66055.55
 
select avg(Age)
from peopledata.new_table
where ID in (select idnew_table
				from peopledata.Second_Table
                where `Home_Value` >= 120 and `Home_Value` <= 200000); #27.000
                
                
select stddev(Age)
from peopledata.new_table
where ID in (select idnew_table
				from peopledata.Second_Table
                where `Home_Value` >= 120 and `Home_Value` <= 200000); #6.5422
                