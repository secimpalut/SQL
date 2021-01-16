CREATE TABLE workers 
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    CONSTRAINT id4_pk PRIMARY KEY(id)
);

INSERT INTO workers VALUES(1001, 'Ali Can', 12000);
INSERT INTO workers VALUES(1002, 'Veli Han', 2000);
INSERT INTO workers VALUES(1003, 'Mary Star', 7000);
INSERT INTO workers VALUES(1004, 'Angie Ocean', 8500);

SELECT * FROM workers;

UPDATE workers
SET salary = ( SELECT MAX(salary)*0.60
                FROM workers
              )
WHERE name = 'Veli Han';

UPDATE workers
SET salary = ( SELECT MIN(salary)*1.3
                FROM workers
              )
WHERE name = 'Mary Star';

CREATE TABLE parents
(
    id char(5),
    num_of_kids number(2),
    total_income number(5),
    CONSTRAINT id6_fk FOREIGN KEY(id) REFERENCES workers(id),
    CONSTRAINT check_num_of_kids CHECK(num_of_kids>=0)
);

INSERT INTO parents VALUES(10001,4,17000);
INSERT INTO parents VALUES(10002,2,11000);
INSERT INTO parents VALUES(10003,1,9100);
INSERT INTO parents VALUES(10004,0,10000);

SELECT * FROM parents;

--- IS NULL 

CREATE TABLE people
(
 ssn char(9),
 name varchar2(50),
 address varchar2(50)
);

INSERT INTO people VALUES(123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES(234567890, 'Angie Way', null);
INSERT INTO people VALUES(345678901, 'Maryy Tien', null);
INSERT INTO people(ssn, address) VALUES(456789012, null);
INSERT INTO people(ssn, address) VALUES(567890123, 'California');


SELECT * FROM people;

---UPDATE all nulls to Not Inserted Yet!'
---1.Way
UPDATE people
SET name = 'name is Not Inserted yet!'
WHERE name IS NULL;
    

UPDATE people
SET address = 'name is Not Inserted yet!'
WHERE address IS NULL;

---2.Way:
UPDATE people
SET name = COALESCE(name,'name is not Inserted yet!'),
    address = COALESCE(address, 'address is not Inserted yet!');



--- HOW TO DELETE DATA

--- DELETE command deletes records from a table
--- DELETE FROM people; ==> delete all records but it does not destroy the table
--- If you delete data by using DELETE Command, the data can be rollad back

DELETE FROM people;

DELETE FROM people
WHERE name IS NULL;

DELETE FROM people
WHERE address IS NOT NULL;


DELETE FROM people
WHERE name IS NULL OR address IS NULL;

DELETE FROM people
WHERE name IS NULL AND address IS NULL;

DELETE FROM people
WHERE name = 'Mark Star' AND address = 'California';

--- How to TRUNCATE data

---TRUNCATE Command does the same with DELETE Command but you use TRANCATE you caanot get the data back after removing
---As you know when we use DELETE the data can be rolled back

TRUNCATE TABLE people;

SELECT * FROM people;

---how to drop table
DROP TABLE people;

DROP TABLE people PURGE;

        --- SELECT Query
---1. To get all records from a table
SELECT * FROM workers;

---2. To get specific cloumn/cloums from a table
SELECT name
FROM workers;

SELECT name,salary
FROM workers;

---3. ,to get a specific data from a cloumn
SELECT *
From workers
WHERE id = 1001;



SELECT *
From workers
WHERE LENGTH(name) > 8;

SELECT *
From workers
WHERE salary = (SELECT MAX(salary)
                FROM workers);
                
SELECT name
From workers
WHERE salary = (SELECT MIN(salary)
                FROM workers);

SELECT name,salary
FROM workers
WHERE salary = (SELECT MIN(salary) FROM workers) OR salary = (SELECT MAX(salary) FROM workers);



SELECT MAX(salary) AS second_highest_salary
FROM workers
WHERE salary < (SELECT MAX (salary)
                FROM workers
                );
                
SELECT MIN(salary)
FROM workers
WHERE salary > (SELECT MIN (salary)
                FROM workers
                );

---Task Homework: Select the Third highest salary from workers table



