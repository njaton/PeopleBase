create schema peopledata;

INSERT INTO `peopledata`.`new_table`
(`ID`,`Name`,`Age`,`Job`,`Salary`)
VALUES (1,'tom',22,'Retail Manager',24000);

SELECT 
    *
FROM
    peopledata.new_table;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM peopledata.new_table 
WHERE
    id = '2';

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
    
UPDATE peopledata.new_table 
SET 
    Name = 'Tom'
WHERE
    id = '1';

UPDATE peopledata.new_table 
SET 
    Job = 'Database Admin'
WHERE
    ID = '12';

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


SELECT 
    AVG(salary)
FROM
    peopledata.new_table;SELECT 
    MIN(salary)
FROM
    peopledata.new_table;SELECT 
    MAX(salary)
FROM
    peopledata.new_table;SELECT 
    STDDEV(salary)
FROM
    peopledata.new_table;SELECT 
    COUNT(*)
FROM
    peopledata.new_table
WHERE
    Degree = 'BS';SELECT 
    AVG(salary)
FROM
    peopledata.new_table
WHERE
    degree = 'BS';SELECT 
    AVG(salary)
FROM
    peopledata.new_table
WHERE
    degree = 'BS' AND age > '24';CREATE TABLE `peopledata`.`Second_Table` (
    `idnew_table` INT NOT NULL,
    `House / Apartment` VARCHAR(45) NOT NULL,
    `Home_Value` INT NOT NULL,
    PRIMARY KEY (`idnew_table`)
);
  
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
    
SELECT 
    *
FROM
    peopledata.Second_Table;

SELECT 
    *
FROM
    peopledata.new_table
        INNER JOIN
    peopledata.Second_Table ON ID = idnew_table;

SELECT 
    ID, Age, Salary, Home_Value
FROM
    peopledata.new_table
        LEFT OUTER JOIN
    peopledata.Second_Table ON ID = idnew_table
WHERE
    Home_Value IS NOT NULL
        AND salary >= 60000
GROUP BY ID DESC;

SELECT 
    AVG(Salary)
FROM
    peopledata.new_table
WHERE
    ID IN (SELECT 
            idnew_table
        FROM
            peopledata.Second_Table
        WHERE
            `House / Apartment` IS NOT NULL)
        AND age <= 40;SELECT 
    AVG(Age)
FROM
    peopledata.new_table
WHERE
    ID IN (SELECT 
            idnew_table
        FROM
            peopledata.Second_Table
        WHERE
            `Home_Value` >= 120
                AND `Home_Value` <= 200000);SELECT 
    STDDEV(Age)
FROM
    peopledata.new_table
WHERE
    ID IN (SELECT 
            idnew_table
        FROM
            peopledata.Second_Table
        WHERE
            `Home_Value` >= 120
                AND `Home_Value` <= 200000); #6.5422
                