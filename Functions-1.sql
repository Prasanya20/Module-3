CREATE TABLE Customers (
    Customer_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(50),
    Date_Of_Birth DATE
);


INSERT INTO Customers VALUES (101, 'Ravi', TO_DATE('15-08-2000','DD-MM-YYYY'));
INSERT INTO Customers VALUES (102, 'Sita', TO_DATE('10-05-1998','DD-MM-YYYY'));
INSERT INTO Customers VALUES (103, 'Rahul', TO_DATE('25-12-2003','DD-MM-YYYY'));

COMMIT;


CREATE OR REPLACE FUNCTION CalculateAge(
    p_dob IN DATE
)
RETURN NUMBER
IS
    v_age NUMBER;
BEGIN
    v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_age;
END;
/


SELECT Customer_ID,
       Customer_Name,
       Date_Of_Birth,
       CalculateAge(Date_Of_Birth) AS Age
FROM Customers;
