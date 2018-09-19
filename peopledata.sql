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