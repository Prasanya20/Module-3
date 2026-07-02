CREATE TABLE Loan (
    Loan_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(50),
    Loan_Amount NUMBER(10,2),
    Interest_Rate NUMBER(5,2)
);



INSERT INTO Loan VALUES (101, 'Ravi', 500000, 10);
INSERT INTO Loan VALUES (102, 'Sita', 300000, 8);
INSERT INTO Loan VALUES (103, 'Rahul', 200000, 12);

COMMIT;


SET SERVEROUTPUT ON;


DECLARE
    CURSOR UpdateLoanInterestRates IS
        SELECT Loan_ID, Interest_Rate
        FROM Loan
        FOR UPDATE;

    v_loan_id Loan.Loan_ID%TYPE;
    v_interest_rate Loan.Interest_Rate%TYPE;

BEGIN
    OPEN UpdateLoanInterestRates;

    LOOP
        FETCH UpdateLoanInterestRates
        INTO v_loan_id, v_interest_rate;

        EXIT WHEN UpdateLoanInterestRates%NOTFOUND;

        UPDATE Loan
        SET Interest_Rate = Interest_Rate + 1
        WHERE CURRENT OF UpdateLoanInterestRates;

        DBMS_OUTPUT.PUT_LINE('Interest rate updated for Loan ID: ' || v_loan_id);
    END LOOP;

    CLOSE UpdateLoanInterestRates;

    COMMIT;
END;
/


SELECT * FROM Loan;
