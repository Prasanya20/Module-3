

CREATE TABLE Accounts (
    Account_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(50),
    Balance NUMBER(10,2)
);


INSERT INTO Accounts VALUES (101, 'Ravi', 20000);
INSERT INTO Accounts VALUES (102, 'Sita', 15000);
INSERT INTO Accounts VALUES (103, 'Rahul', 10000);

COMMIT;


CREATE OR REPLACE FUNCTION HasSufficientBalance(
    p_account_id IN NUMBER,
    p_amount IN NUMBER
)
RETURN BOOLEAN
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE Account_ID = p_account_id;

    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/


SET SERVEROUTPUT ON;

BEGIN
    IF HasSufficientBalance(101, 5000) THEN
        DBMS_OUTPUT.PUT_LINE('Sufficient Balance');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient Balance');
    END IF;

    IF HasSufficientBalance(103, 15000) THEN
        DBMS_OUTPUT.PUT_LINE('Sufficient Balance');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient Balance');
    END IF;
END;
/
