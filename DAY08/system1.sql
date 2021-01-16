--Create a procedure to calculate the square of a number
DECLARE
num NUMBER := '&numberToCalculateSquare';

PROCEDURE sqrNumP(x IN OUT NUMBER) IS 

BEGIN
    x := x*x;
END;

BEGIN
    sqrNumP(num);
    DBMS_OUTPUT.PUT('The square: ' || num);
END;