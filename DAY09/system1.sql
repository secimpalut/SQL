CREATE TABLE bank_customers
(
    customer_order_number NUMBER(3),
    customer_name VARCHAR2(50)
);

CREATE SEQUENCE seq1 
START WITH 101
INCREMENT BY 2
MAXVALUE 105;

--If you want to alter a sequence -you can alter invrement by, maxvalue minvalue
-- open a CYCLE
--BUT YOU CAN NOT ALTER START WITH
--Note: if you need to alter start with, dropping Sequence and creating again is recomended

-- incrase maxvalur 107
ALTER SEQUENCE seq1
MAXVALUE 107;

INSERT INTO bank_customers VALUES(seq1.NEXTVAL,'&customer_name');

SELECT * FROM bank_customers;

ALTER SEQUENCE seq1
INCREMENT BY 1;

INSERT INTO bank_customers VALUES(seq1.NEXTVAL,'&customer_name');

DROP SEQUENCE seq1;
