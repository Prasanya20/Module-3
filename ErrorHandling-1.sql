CREATE OR REPLACE PROCEDURE SafeTransferFunds
(
    p_from_account NUMBER,
    p_to_account NUMBER,
    p_amount NUMBER
)
IS
    v_balance NUMBER;
BEGIN

    -- Get Sender Balance
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE Account_ID = p_from_account;

    -- Check Balance
    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001,'Insufficient Funds');
    END IF;

    -- Deduct Amount
    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE Account_ID = p_from_account;

    -- Add Amount
    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE Account_ID = p_to_account;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Transfer Successful.');

EXCEPTION

    WHEN OTHERS THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE('Error : ' || SQLERRM);

END;
/

BEGIN
    SafeTransferFunds(101,102,1000);
END;
/
SELECT * FROM Accounts;

BEGIN
    SafeTransferFunds(101,102,10000);
END;
/
