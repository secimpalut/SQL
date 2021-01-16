--Note: When you use UNION - UNION ALL -INTERSECT - MINUS

CREATE TABLE employees1 
(  
  id number(9), 
  name varchar2(50), 
  state varchar2(50), 
  salary number(20),
  company varchar2(20)
);

INSERT INTO employees1 VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees1 VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees1 VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees1 VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees1 VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees1 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees1 VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT name,state
FROM employees1

UNION

SELECT name, state, salary
FROM employees1;

SELECT name,state
FROM employees1

UNION

SELECT name, salary
FROM employees1;

--Following code works, because given rules above is fine
SELECT name,state
FROM employees1

UNION

SELECT state, name
FROM employees1;

INSERT INTO orders1 VALUES(11, 101, '17-04-2020');
INSERT INTO orders1 VALUES(22, 102, '18-04-2020');
INSERT INTO orders1 VALUES(33, 103, '19-04-2020');
INSERT INTO orders1 VALUES(44, 104, '20-04-2020');
INSERT INTO orders1 VALUES(55, 105, '21-04-2020');


--2=) LEFT JOIN : Returns all data from the first table

SELECT c.company_name, o.company_ýd, o.order_date
FROM companýes1 c LEFT JOIN orders1 o
ON c.company_id = o.company_id;


--3=) RIGHT JOIN : Returns all data from the first table

SELECT c.company_name, o.company_ýd, o.order_date
FROM companýes1 c RIGHT JOIN orders1 o
ON c.company_id = o.company_id;


CREATE TABLE employees2 
(  
  id number(2), 
  name varchar2(20),
  title varchar2(60),
  manager_id number(2) 
);

INSERT INTO employees2 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO employees2 VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO employees2 VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO employees2 VALUES(4, 'Amy Sky', 'CEO', 5);


SELECT t1.name AS emp_name, t2.name AS mng_name
FROM employees2 t1 INNER JOIN employees2 t2
ON t1.manager_id = t2.id;

--PIVOT Clause: used to make record data colýmn name

CREATE TABLE customers_products
( 
  product_id number(10),
  customer_name varchar2(50),
  product_name varchar2(50)
);

INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (20, 'John', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy', 'Palm');
INSERT INTO customers_products VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_products VALUES (40, 'John', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie', 'Apple');

SELECT *
FROM (SELeCT customer_name,product_name FROM customers_products)

PIVOT

(COUNT(product_name) FOR product_name IN('Orange','Palm'));

--Display which product is bought how many times from which customer

SELECT *
FROM (SELeCT product_name AS Fruit, customer_name FROM customers_products)

PIVOT

(COUNT(customer_name) FOR customer_name IN('Mark','Amy','John'));


--How to AlTER tables
--1. How to add cloumn or cloumns into a table?

ALTER TABLE customers_products 
ADD lastname VARCHAR2(25);

ALTER TABLE customers_products 
ADD address VARCHAR2(50);


--How to add multiple columns?
ALTER TABLE customers_products 
ADD (county varchar2(15),
     city varchar2(15));
     
SELECT * FROM customers_products;

ALTER TABLE customers_products 
DROP (county ,city);


ALTER TABLE customers_products 
DROP (lastname);

ALTER TABLE customers_products 
DROP (address);

--3. How to rename a column
ALTER TABLE customers_products
RENAME COLUMN product_name TO fruit_name;


--4 How to rename a table ?
ALTER TABLE customers_products
RENAME TO c_p;

SELECT * FROM c_p;


--5 How to modify a cloumn structure
ALTER TABLE c_p
MODIFY fruit_name varchar2(20) NOT NULL;

--Add Price Column to c_p table with default value 0.00
--Modify the Price Column by using UNIQUE Constraint, make the precision 5 and scale 2
--Drop the Price Column

ALTER TABLE c_p
ADD price NUMBER(2) DEFAULT 0.00;

ALTER TABLE c_p
MODIFY price NUMBER(5,2) UNIQUE;

ALTER TABLE c_p
DROP (price);

---EXCEPTIONS
--PRE DEFINED EXCEPTIONS

CREATE TABLE students
(
id char(11),
name VARCHAR2(50),
grade number(3),
address VARCHAR2(80),
update_date date
);

INSERT INTO students VALUES(123456789, 'John Walker', 11, '1234 Texas', '14-04-2020');
INSERT INTO students VALUES(223456789, 'Johnny Walker', 12, '1234 Florida', '14-04-2020');


SELECT
    *
FROM students;

DECLARE 
    emp_id char(11);
    emp_name varchar2(50);
    
BEGIN 
        SELECT id,name
        INTO emp_id,emp_name
        FROM students;
        DBMS_OUTPUT.PUT_LINE(emp_id);
        DBMS_OUTPUT.PUT_LINE(emp_name);   
    EXCEPTION
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('I NEED ONE ROW BUT QUEERY RETURNED MULTÝPLE ROWS');
END;


DELETE FROM students
WHERE id = '223456789';

















