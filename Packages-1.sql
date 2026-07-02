SET SERVEROUTPUT ON;

DROP TABLE Customers CASCADE CONSTRAINTS;

CREATE TABLE Customers (
    Customer_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(50),
    City VARCHAR2(50),
    Balance NUMBER(10,2)
);

INSERT INTO Customers VALUES (101,'Rahul','Hyderabad',5000);
INSERT INTO Customers VALUES (102,'Priya','Chennai',7000);
COMMIT;

CREATE OR REPLACE PACKAGE CustomerManagement AS

    PROCEDURE AddCustomer(
        p_id NUMBER,
        p_name VARCHAR2,
        p_city VARCHAR2,
        p_balance NUMBER
    );

    PROCEDURE UpdateCustomer(
        p_id NUMBER,
        p_city VARCHAR2
    );

    FUNCTION GetBalance(
        p_id NUMBER
    ) RETURN NUMBER;

END CustomerManagement;
/


CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

PROCEDURE AddCustomer(
    p_id NUMBER,
    p_name VARCHAR2,
    p_city VARCHAR2,
    p_balance NUMBER
)
IS
BEGIN
    INSERT INTO Customers
    VALUES(p_id,p_name,p_city,p_balance);

    COMMIT;
END;

PROCEDURE UpdateCustomer(
    p_id NUMBER,
    p_city VARCHAR2
)
IS
BEGIN
    UPDATE Customers
    SET City=p_city
    WHERE Customer_ID=p_id;

    COMMIT;
END;

FUNCTION GetBalance(
    p_id NUMBER
)
RETURN NUMBER
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Customers
    WHERE Customer_ID=p_id;

    RETURN v_balance;
END;

END CustomerManagement;
/


BEGIN
    CustomerManagement.AddCustomer(103,'Kiran','Bangalore',8000);
    CustomerManagement.UpdateCustomer(101,'Mumbai');

    DBMS_OUTPUT.PUT_LINE(
        'Balance = '||
        CustomerManagement.GetBalance(102)
    );
END;
/

SELECT * FROM Customers;
