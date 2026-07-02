CREATE TABLE Transactions (
    Transaction_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(50),
    Transaction_Date DATE,
    Transaction_Type VARCHAR2(20),
    Amount NUMBER(10,2)
);



INSERT INTO Transactions VALUES
(101, 'Ravi', TO_DATE('05-07-2026','DD-MM-YYYY'), 'Deposit', 5000);

INSERT INTO Transactions VALUES
(102, 'Ravi', TO_DATE('15-07-2026','DD-MM-YYYY'), 'Withdrawal', 2000);

INSERT INTO Transactions VALUES
(103, 'Sita', TO_DATE('10-07-2026','DD-MM-YYYY'), 'Deposit', 7000);

INSERT INTO Transactions VALUES
(104, 'Rahul', TO_DATE('20-06-2026','DD-MM-YYYY'), 'Withdrawal', 1000);

COMMIT;



SET SERVEROUTPUT ON;



DECLARE
    CURSOR GenerateMonthlyStatements IS
        SELECT Customer_Name,
               Transaction_Date,
               Transaction_Type,
               Amount
        FROM Transactions
        WHERE EXTRACT(MONTH FROM Transaction_Date) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM Transaction_Date) = EXTRACT(YEAR FROM SYSDATE);

    v_customer Transactions.Customer_Name%TYPE;
    v_date Transactions.Transaction_Date%TYPE;
    v_type Transactions.Transaction_Type%TYPE;
    v_amount Transactions.Amount%TYPE;

BEGIN
    OPEN GenerateMonthlyStatements;

    LOOP
        FETCH GenerateMonthlyStatements
        INTO v_customer, v_date, v_type, v_amount;

        EXIT WHEN GenerateMonthlyStatements%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Customer: ' || v_customer ||
            ', Date: ' || TO_CHAR(v_date,'DD-MON-YYYY') ||
            ', Type: ' || v_type ||
            ', Amount: ' || v_amount
        );
    END LOOP;

    CLOSE GenerateMonthlyStatements;
END;
/
