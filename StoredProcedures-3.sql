CREATE TABLE Account (
    Account_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(50),
    Balance NUMBER(10,2)
);


INSERT INTO Account VALUES (101, 'Ravi', 20000);
INSERT INTO Account VALUES (102, 'Sita', 15000);
INSERT INTO Account VALUES (103, 'Rahul', 10000);

COMMIT;



SELECT * FROM Account;



CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE Account_ID = p_from_account;

    IF v_balance >= p_amount THEN

        UPDATE Account
        SET Balance = Balance - p_amount
        WHERE Account_ID = p_from_account;

        UPDATE Account
        SET Balance = Balance + p_amount
        WHERE Account_ID = p_to_account;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');

    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient balance. Transfer failed.');
    END IF;

END;
/


BEGIN
    TransferFunds(101, 102, 5000);
END;
/


SELECT * FROM Account;


BEGIN
    TransferFunds(103, 101, 30000);
END;
/


SELECT * FROM Account;
