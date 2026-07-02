SET SERVEROUTPUT ON;

DROP TABLE Employees CASCADE CONSTRAINTS;

CREATE TABLE Employees
(
    Employee_ID NUMBER PRIMARY KEY,
    Employee_Name VARCHAR2(50),
    Salary NUMBER(10,2),
    Department VARCHAR2(50)
);

INSERT INTO Employees
VALUES(1,'John',40000,'HR');

COMMIT;


CREATE OR REPLACE PACKAGE EmployeeManagement AS

PROCEDURE HireEmployee(
    p_id NUMBER,
    p_name VARCHAR2,
    p_salary NUMBER,
    p_dept VARCHAR2
);

PROCEDURE UpdateEmployee(
    p_id NUMBER,
    p_salary NUMBER
);

FUNCTION AnnualSalary(
    p_id NUMBER
)
RETURN NUMBER;

END EmployeeManagement;
/



CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

PROCEDURE HireEmployee(
    p_id NUMBER,
    p_name VARCHAR2,
    p_salary NUMBER,
    p_dept VARCHAR2
)
IS
BEGIN
    INSERT INTO Employees
    VALUES(p_id,p_name,p_salary,p_dept);

    COMMIT;
END;

PROCEDURE UpdateEmployee(
    p_id NUMBER,
    p_salary NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary=p_salary
    WHERE Employee_ID=p_id;

    COMMIT;
END;

FUNCTION AnnualSalary(
    p_id NUMBER
)
RETURN NUMBER
IS
    v_salary NUMBER;
BEGIN
    SELECT Salary
    INTO v_salary
    FROM Employees
    WHERE Employee_ID=p_id;

    RETURN v_salary*12;
END;

END EmployeeManagement;
/


BEGIN

EmployeeManagement.HireEmployee
(
2,
'Sara',
50000,
'Finance'
);

EmployeeManagement.UpdateEmployee
(
1,
45000
);

DBMS_OUTPUT.PUT_LINE
(
'Annual Salary = '||
EmployeeManagement.AnnualSalary(1)
);

END;
/

SELECT * FROM Employees;
