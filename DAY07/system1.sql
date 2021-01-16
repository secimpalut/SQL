--Functions are created mainly for 2 reasons;
--1)To do some calculations like tax calculation etc.
--2)To fetch data from database like student names and average scores from students table
?
--Creating functions is very useful for reusability
?
--1)Functions must return a value for every condition
--2)In SQL, there are 3 types of parameters a)IN Parameter (used to send data into the function)
--                                          b)OUT Parameter (Used to get data from the function operation)  
--                                          c)IN/OUT Parameter (used to send data into the function and get data from the function operations)
--  Functions use "IN" parameter everytime. Because of that we do not declare parameters as "IN" "OR" or "IN/OUT" in the functions.
--3)We can use functions in SQL statements like SELECT, INSERT, UPDATE, DELETE etc.
--4)We cannot call procedures from inside the functions
?
--DUAL Table
--1)DUAL table is created by Oracle DBMS, no need to create it.
--  If you create DUAL Table, you cannot use Oracle's DUAL Table  anymore
--2)DUAL Table has 1 row, 1 column
--3)Row default value is "X", data type of the "X" is VARCHAR2(1)
--  Column name is "DUMMY" as default
--4)DUAL table has 1 row, 1 column so it has just a single data in it
?
SELECT * FROM DUAL;
?
--Usage Examples of DUAL Table
SELECT sysdate FROM DUAL;
SELECT user FROM DUAL;
SELECT (3+5)/2 AS AVG FROM DUAL;

CREATE TABLE students
(
    name VARCHAR2(50),
    avg_score NUMBER(4,2),
    modified_date DATE,
    modifier VARCHAR2(50)
);

DECLARE
    cur_date students.modify_date%TYPE;
    modifier_name students.modifier%TYPE;
    
BEGIN
    SELECT sysdate, user
    INTO cur_date, modifier_name
    FROM DUAL;
    
    INSERT INTO students VALUES('Ali Can', 87.54, cur_date, modifier_name);
    INSERT INTO students VALUES('Veli Han', 63.45, cur_date, modifier_name);
    INSERT INTO students VALUES('Ayse Tan', 97.54, cur_date, modifier_name);
END;    
?
SELECT * FROM students;

--How to create Functions
?
    --1)Create a function which adds 2 numbers
        CREATE OR REPLACE FUNCTION addf(a NUMBER, b NUMBER) 
        RETURN NUMBER IS
        BEGIN
        
        RETURN a+b;
        
        END;
--How to call a function
    --1.Way
    SELECT addf(10, 20) FROM DUAL;
    
    --2.Way: Recommended
    EXECUTE DBMS_OUTPUT.PUT_LINE('Sum of the numbers is '||addf(10, 20));
    
    --3.Way
    --In Java we were using "=" to make assignment, in SQL we use ":="
    VARIABLE result NUMBER
    EXECUTE :result := addf(10, 20); 
    PRINT result;

--How to create Functions
?
--2)Create a function which can do 4 mathematical operations with 2 numbers
CREATE OR REPLACE FUNCTION calcf(a NUMBER, b NUMBER, operator CHAR)
RETURN NUMBER IS
?
BEGIN
    IF operator = '+' THEN
    RETURN a+b;   
    ELSIF operator = '-' THEN
    RETURN a-b;  
    ELSIF operator = '*' THEN
    RETURN a*b;    
    ELSIF operator = '/' THEN
    RETURN a/b;   
    ELSE 
        dbms_output.put_line('You should select one of the +, -, *, /');
        RETURN 0;
    END IF;
    
    EXCEPTION 
    WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('You should not divide by zero!');
    RETURN 0;
?
END;
?
--How to call function
--1.Way:
SELECT calcf(10, 0, '/') FROM DUAL;
?
--2.Way: Recommended
EXECUTE dbms_output.put_line(calcf(10, 0, '/'));
?
--3.Way
VARIABLE result NUMBER;
EXECUTE :result := calcf(10, 0, '/');
PRINT result;


CREATE OR REPLACE FUNCTION greater_number(a NUMBER, b NUMBER)
RETURN NUMBER IS
BEGIN
    IF a>b THEN
    RETURN a;
    ELSE
    RETURN b;
 END IF;
 END;

--1.WAY 
SELECT greater_number(11,3) FROM DUAL;

--2.WAY
EXECUTE dbms_output.put_line('MAZIMIM ONE IS '||greater_number(112,5);

VARIABLE result NUMBER;
EXECUTE :result := greater_number(110,110);
PRINT result;


DECLARE
a NUMBER := '&firstNum';
b NUMBER := '&secondNumber';
FUNCTION findGreaterf(x NUMBER, y NUMBER)
RETURN NUMBER IS
BEGIN
    IF x>y THEN
    RETURN x;
    ELSE
    RETURN y;
    END IF;
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE('MAXIMUM ONE IS ' || findGreaterf(a,b));
END;

--faktoriyel

--Create a function to calculate factorial, get the number from user
DECLARE
a NUMBER := '&numberToCalculateFactorial';
?
FUNCTION factorialf(x NUMBER)
RETURN NUMBER IS
?
BEGIN
    IF x<0 THEN
    DBMS_OUTPUT.PUT_LINE('Do not use negative numbers for factorial operation');
    RETURN 0;
    ELSIF x=0 THEN
    RETURN 1;
    ELSE 
    RETURN x * factorialf(x-1);
    END IF;
END;
?
BEGIN
    DBMS_OUTPUT.PUT_LINE(a||'! = '||factorialf(a));
END;
















 
