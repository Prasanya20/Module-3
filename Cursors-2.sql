CREATE TABLE Accouns (
    Account_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(50),
    Balance NUMBER(10,2)
);


INSERT INTO Accouns VALUES (101, 'Ravi', 20000);
INSERT INTO Accouns VALUES (102, 'Sita', 15000);
INSERT INTO Accouns VALUES (103, 'Rahul', 10000);

COMMIT;



SET SERVEROUTPUT ON;


DECLARE
    CURSOR ApplyAnnualFee IS
        SELECT Account_ID, Balance
        FROM Accouns
        FOR UPDATE;

    v_account_id Accounts.Account_ID%TYPE;
    v_balance Accounts.Balance%TYPE;
    v_fee NUMBER := 500; 

BEGIN
    OPEN ApplyAnnualFee;

    LOOP
        FETCH ApplyAnnualFee INTO v_account_id, v_balance;
        EXIT WHEN ApplyAnnualFee%NOTFOUND;

        UPDATE Accouns
        SET Balance = Balance - v_fee
        WHERE CURRENT OF ApplyAnnualFee;

        DBMS_OUTPUT.PUT_LINE('Annual fee deducted from Account ID: ' || v_account_id);
    END LOOP;

    CLOSE ApplyAnnualFee;

    COMMIT;
END;
/


SELECT * FROM Accouns;
