DECLARE
    CURSOR cust_cursor IS
        SELECT c.CustomerID, c.Age, l.LoanID, l.InterestRate
        FROM Customers c
        JOIN Loans l
        ON c.CustomerID = l.CustomerID;

BEGIN
    FOR rec IN cust_cursor LOOP
        IF rec.Age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = rec.LoanID;

            DBMS_OUTPUT.PUT_LINE('1% discount applied to Loan ID: ' || rec.LoanID);
        END IF;
    END LOOP;

    COMMIT;
END;
/
