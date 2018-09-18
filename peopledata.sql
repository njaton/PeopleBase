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
    
update peopledata.new_table 
set Name = 'Tom'
where id = '1';

#Get General Demographics
select avg(salary)
from peopledata.new_table; #59700,00

select min(salary)
from peopledata.new_table; #24000

select max(salary)
from peopledata.new_table; #1040000

select stddev(salary)
from peopledata.new_table; #21123.683