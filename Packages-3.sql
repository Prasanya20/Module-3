SET SERVEROUTPUT ON;

DROP TABLE Accounts CASCADE CONSTRAINTS;

CREATE TABLE Accounts
(
    Account_ID NUMBER PRIMARY KEY,
    Customer_ID NUMBER,
    Customer_Name VARCHAR2(50),
    Balance NUMBER(10,2)
);

INSERT INTO Accounts
VALUES(101,1,'Rahul',10000);

INSERT INTO Accounts
VALUES(102,1,'Rahul',5000);

COMMIT;


CREATE OR REPLACE PACKAGE AccountOperations AS

PROCEDURE OpenAccount
(
    p_accid NUMBER,
    p_custid NUMBER,
    p_name VARCHAR2,
    p_balance NUMBER
);

PROCEDURE CloseAccount
(
    p_accid NUMBER
);

FUNCTION TotalBalance
(
    p_custid NUMBER
)
RETURN NUMBER;

END AccountOperations;
/


CREATE OR REPLACE PACKAGE BODY AccountOperations AS

PROCEDURE OpenAccount
(
    p_accid NUMBER,
    p_custid NUMBER,
    p_name VARCHAR2,
    p_balance NUMBER
)
IS
BEGIN

INSERT INTO Accounts
VALUES
(
p_accid,
p_custid,
p_name,
p_balance
);

COMMIT;

END;

PROCEDURE CloseAccount
(
p_accid NUMBER
)
IS
BEGIN

DELETE FROM Accounts
WHERE Account_ID=p_accid;

COMMIT;

END;

FUNCTION TotalBalance
(
p_custid NUMBER
)
RETURN NUMBER
IS
v_total NUMBER;
BEGIN

SELECT SUM(Balance)
INTO v_total
FROM Accounts
WHERE Customer_ID=p_custid;

RETURN v_total;

END;

END AccountOperations;
/



BEGIN

AccountOperations.OpenAccount
(
103,
1,
'Rahul',
7000
);

AccountOperations.CloseAccount
(
102
);

DBMS_OUTPUT.PUT_LINE
(
'Total Balance = '||
AccountOperations.TotalBalance(1)
);

END;
/

SELECT * FROM Accounts;
