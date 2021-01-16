CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    CONSTRAINT id4_pk PRIMARY KEY(id)
);

INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);
INSERT INTO workers VALUES(10005, 'Tom Hanks', 6000);
INSERT INTO workers VALUES(10006, 'Eddie Murphy', 9500);

INSERT INTO workers VALUES(10007, 'Mark J', 5000);
INSERT INTO workers VALUES(10008, 'Walker Tom', 7200);

--Select the names and salaries of the workers whose ids are 10001, 10002, 10004
--1.Way:
SELECT name, salary
FROM workers
WHERE id = 10001 OR id = 10002 OR id = 10004;

SELECT name, salary
FROM workers
WHERE id IN(10001,10002,10004);


--BETWEEN
-- Boundries are inclusive

SELECT name, salary
FROM workers
WHERE id>=10002 AND id<=10005;

SELECT name, salary
FROM workers
WHERE id BETWEEN 10002 AND 10005;


-- NOT BETWEEN CONDITION

SELECT name, salary
FROM workers
WHERE id < 10002 OR id >10005;

SELECT name, salary
FROM workers
WHERE id NOT BETWEEN 10002 AND 10005;

--Practice
SELECT salary
FROM workers
WHERE name BETWEEN 'Eddie Murphy' AND 'Tom Hanks';

--EXISTS Condition
--When you use EXISTS Condition you need to type a subquery after Where clause
--If the subquery has any result it will retun data otherwise it will not

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

SELECT * FROM customers_products;


CREATE TABLE customers_likes
( 
  product_id number(10),
  customer_name varchar2(50),
  liked_product varchar2(50)
);


INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');


SELECT * FROM customers_products;
SELECT * FROM customers_likes;

--Select Customer names who have same product id in the tables

SELECT customer_name
FROM customers_products
WHERE EXISTS(SELECT product_id 
            FROM customers_lýkes 
            WHERE customers_products.product_id = customers_lýkes.product_id);


SELECT name, salary, (SELECT AVG(salary) FROM workers )average_salary
FROM workers;

--- Crate a report to display name salry max min salary for every record

SELECT name, salary, 
        (SELECT MIN(salary) From workers)max_salary,
        (SELECT MAX(salary) From workers)min_salary
FROM workers;

-- SELECT product_name, liked_products
-- FROM customers_products,(SELECT count(liked_products)
--                        FROM customers_liked)num_of_liked_products;
-- After learning "Group By"


--LIKE Conditon
--Select record which have workers whose names are starting with 'A'
-->
SELECT * 
FROM workers
WHERE name LIKE 'A%';

SELECT *
FROM workers
WHERE name LIKE '%n';

SELECT *
FROM workers
WHERE name LIKE '%an%';

SELECT *
FROM workers
WHERE name LIKE '_li%';

SELECT *
FROM workers
WHERE name LIKE '_a_y%';

SELECT * FROM workers;

SELECT *
FROM workers
WHERE name LIKE '__r___';

SELECT *
FROM workers
WHERE name LIKE '__r___%';

SELECT *
FROM workers
WHERE name LIKE 'A__%n';

--How to use REGEX(Regular Expression)
CREATE TABLE words
( 
    word_id char(3),
    word VARCHAR(15),
    word_length NUMBER(2)
);

INSERT INTO words VALUES('101','hat', 3);
INSERT INTO words VALUES('102','hot', 3);
INSERT INTO words VALUES('103','hit', 3);
INSERT INTO words VALUES('104','hut', 3);
INSERT INTO words VALUES('104','selena', 6);
INSERT INTO words VALUES('104','yusuf', 5);
INSERT INTO words VALUES('104','adem', 4);
INSERT INTO words VALUES('104','hct', 3);

SELECT * FROM words;

--Select the words starting with'h' ending 't' and 

--First way: Recomended
SELECT *
FROM words
WHERE REGEXP_LIKE (word,'h[aio]t');

--Second Way
SELECT *
FROM words
WHERE REGEXP_LIKE (word,'h(a|i|o)t');


SELECT *
FROM words
WHERE REGEXP_LIKE (word,'h[a-i]t');

SELECT *
FROM words
WHERE REGEXP_LIKE(word,'[aie](*)'); -- [aie](*) and [aie] are the same but first one is better

SELECT *
FROM words
WHERE REGEXP_LIKE(word,'^[sya](*)'); -- ^ this means strating with

SELECT *
FROM words
WHERE REGEXP_LIKE(word,'[afm]$(*)'); -- $ this means ending with







