CREATE OR REPLACE PROCEDURE UpdateSalary
(
    p_empid NUMBER,
    p_percentage NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_percentage/100)
    WHERE Employee_ID = p_empid;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Salary Updated Successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Employee ID does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

BEGIN
    UpdateSalary(1,10);
END;
/

SELECT * FROM Employees;
BEGIN
    UpdateSalary(5,20);
END;
/
