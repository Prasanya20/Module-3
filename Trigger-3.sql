SET SERVEROUTPUT ON;
CREATE TABLE Accounts (
    Account_ID NUMBER PRIMARY KEY,
    Account_Name VARCHAR2(50),
    Balance NUMBER(10,2)
);
INSERT INTO Accounts VALUES (101,'Rahul',10000);
INSERT INTO Accounts VALUES (102,'Priya',5000);
COMMIT;
CREATE TABLE Transactions (
    Transaction_ID NUMBER PRIMARY KEY,
    Account_ID NUMBER,
    Transaction_Type VARCHAR2(20),
    Amount NUMBER(10,2),

    FOREIGN KEY(Account_ID)
    REFERENCES Accounts(Account_ID)
);
CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT
ON Transactions
FOR EACH ROW

DECLARE
    v_balance NUMBER;

BEGIN

    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE Account_ID = :NEW.Account_ID;

    IF UPPER(:NEW.Transaction_Type)='WITHDRAWAL' THEN

        IF :NEW.Amount > v_balance THEN

            RAISE_APPLICATION_ERROR
            (-20001,'Insufficient Balance');

        END IF;

    ELSIF UPPER(:NEW.Transaction_Type)='DEPOSIT' THEN

        IF :NEW.Amount<=0 THEN

            RAISE_APPLICATION_ERROR
            (-20002,'Deposit Amount Must Be Positive');

        END IF;

    END IF;

END;
/
