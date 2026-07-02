CREATE OR REPLACE PROCEDURE AddNewCustomer
(
    p_id NUMBER,
    p_name VARCHAR2,
    p_city VARCHAR2
)
IS
BEGIN
    INSERT INTO Customers
    VALUES
    (
        p_id,
        p_name,
        p_city
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Customer Added Successfully.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Customer ID already exists.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

BEGIN
    AddNewCustomer(101,'Ramesh','Hyderabad');
END;
/

SELECT * FROM Customers;

BEGIN
    AddNewCustomer(101,'Suresh','Chennai');
END;
/

SELECT * FROM Accounts;
