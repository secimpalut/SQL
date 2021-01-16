--CURSORS
--Cursor is a pointer which points Context Area
--Data which Cursor holds is called "Active Set"
?
--There are 2 types of Cursors
    --a)Implicit Cursors (Pre-defined Cursors): Created by Oracle
    --b)Explicit Cursors (User-defined Cursors): Created by user
?
                                                                    --Implicit Cursors:
                                                                    
    --a)%FOUND(Returns Boolean): If INSERT INTO, UPDATE SET, and DELETE commands affects at least 1 records then
    --                           %FOUND Cursor returns true, otherwise it returns false.
    
CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);
?
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);
?
--Example: By getting id from user delete an existing record
--When you execute the following code you will get "Procedure Successfully Completed" message 
--but more specific message like "Record whose id is 10001 is deleted" would be better
DECLARE
    emp_id workers.id%TYPE := '&emp_id';
BEGIN
    DELETE FROM workers WHERE id = emp_id; 
END;
?
--By using Cursor we can achieve to get more specific messages
DECLARE
    emp_id workers.id%TYPE := '&emp_id';
BEGIN
    DELETE FROM workers WHERE id = emp_id; 
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Record is deleted whose id is '||emp_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No record is deleted');
    END IF;    
END;
?
SELECT * FROM workers;
--Example: Raise the salary of a worker whose id will be entered by user.
--         If the salary is raised print name, old salary, and new salary to the console.
--         Use %FOUND Cursor.
?
DECLARE
    emp_id workers.id%TYPE := '&emp_id';
    emp_name workers.name%TYPE;
    emp_old_salary workers.salary%TYPE;
    emp_new_salary workers.salary%TYPE;
BEGIN
    SELECT salary
    INTO emp_old_salary
    FROM workers
    WHERE id = emp_id;
?
    UPDATE workers
    SET salary = salary*1.1
    WHERE id = emp_id;
    
    SELECT name, salary
    INTO emp_name, emp_new_salary
    FROM workers
    WHERE id = emp_id;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Salary is updated '||emp_name||' - '||emp_old_salary||' - '||emp_new_salary);
    END IF;
    
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Salary is not updated');
        
END;
?
    --b)%NOTFOUND(Returns Boolean): If INSERT INTO, UPDATE SET, and DELETE commands affects at least 1 records then
    --                              %NOTFOUND Cursor returns false, otherwise it returns true.
    
    --c)%ROWCOUNT(Returns Integer): It returns the number of records which are affected by INSERT INTO, UPDATE SET, and DELETE statements
    --                              It returns 0, if no record is affected.
?
--Example: Update the salary in workers table. 
--         If no records could be updated return 'No update!'
--         If any records are updated return the number of records which are updated
?
SELECT * FROM workers;
?
DECLARE 
  num_of_rec NUMBER(2);
  emp_id workers.id%TYPE := '&emp_id';
BEGIN
    UPDATE workers
    SET salary = salary + 500
    WHERE id > emp_id;
    
    IF SQL%NOTFOUND THEN
        num_of_rec := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE(num_of_rec || ' records are updated');
    ELSIF SQL%FOUND THEN
        num_of_rec := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE('Number of updated records is '||num_of_rec);
    END IF;     
END;
?
                                                        --Explicit Cursors
--For Explicit Cursors, you have to do 4 steps;
    --a)Declare the Cursor
    --b)Open the Cursor
    --c)Fetch the Cursor
    --d)Close the Cursor
    
--Example: Your manager asked you to prepare a report which displays the raised salaries and worker names.
--         But the manager did not ask you to update the salaries, he wants to see on a report just to 
--         see if the salaries are raised.
--         If the salary is less than 8000 raise it by %20, otherwise %10
?
--CURSOR with "LOOP" 
?
DECLARE
    raised_salary workers.salary%TYPE;
    emp_name workers.name%TYPE;
        CURSOR cursor1 IS SELECT name, salary FROM workers;
BEGIN
        OPEN cursor1;
    
    LOOP
       FETCH cursor1 INTO emp_name, raised_salary;
       IF raised_salary < 8000 THEN
        raised_salary := raised_salary*1.2;
       ELSE
        raised_salary := raised_salary*1.1;
       END IF; 
       
       EXIT WHEN cursor1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(emp_name||' --> '||raised_salary);
    END LOOP;     
       CLOSE cursor1;
END;
?
?
                                    --CURSOR with "FOR LOOP"
--When you use Cursor with "for loop" just Declaration of Cursor is enough.
--No need to OPEN, no need to FETCH, no need to CLOSE cursor
?
--When you use Cursor with "for loop" no need to use variables
--because every data will be in "r" variable
DECLARE
     CURSOR cursor2 IS SELECT name, salary FROM workers;
BEGIN   
    FOR r IN cursor2 LOOP
    
       IF r.salary < 8000 THEN
            r.salary := r.salary*1.2;
       ELSE
            r.salary := r.salary*1.1;
       END IF; 
       
       EXIT WHEN cursor2%NOTFOUND;--You may keep or remove EXIT part
            DBMS_OUTPUT.PUT_LINE(r.name||' --> '||r.salary);
            
    END LOOP;     
END;
?
                                    --CURSOR with "WHILE LOOP"
--When you use Cursor with "while loop" you need to DECLARE, to OPEN, to FETCH, to CLOSE cursor
DECLARE
?
        CURSOR cursor3 IS SELECT name, salary FROM workers;
        r cursor3%ROWTYPE;
BEGIN
        OPEN cursor3;
        FETCH cursor3 INTO r;
?
    WHILE cursor3%FOUND LOOP   
       IF r.salary < 8000 THEN
        r.salary := r.salary*1.2;
       ELSE
        r.salary := r.salary*1.1;
       END IF; 
       DBMS_OUTPUT.PUT_LINE(r.name||' --> '||r.salary);
       FETCH cursor3 INTO r;
    END LOOP;     
       CLOSE cursor3;
END;