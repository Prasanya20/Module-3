CREATE TABLE Loans (
    Loan_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(50),
    Loan_Amount NUMBER(10,2),
    Interest_Rate NUMBER(5,2),
    Loan_Duration_Years NUMBER
);



INSERT INTO Loans VALUES (101, 'Ravi', 500000, 10, 5);
INSERT INTO Loans VALUES (102, 'Sita', 300000, 8, 3);
INSERT INTO Loans VALUES (103, 'Rahul', 200000, 12, 2);

COMMIT;



CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    p_loan_amount IN NUMBER,
    p_interest_rate IN NUMBER,
    p_duration_years IN NUMBER
)
RETURN NUMBER
IS
    v_monthly_installment NUMBER;
BEGIN
    v_monthly_installment :=
        (p_loan_amount +
        (p_loan_amount * p_interest_rate * p_duration_years / 100))
        / (p_duration_years * 12);

    RETURN ROUND(v_monthly_installment, 2);
END;
/



SELECT Loan_ID,
       Customer_Name,
       Loan_Amount,
       Interest_Rate,
       Loan_Duration_Years,
       CalculateMonthlyInstallment(
           Loan_Amount,
           Interest_Rate,
           Loan_Duration_Years
       ) AS Monthly_Installment
FROM Loans;
