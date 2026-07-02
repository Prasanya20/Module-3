CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE
ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/
UPDATE Customers
SET City='Bangalore'
WHERE Customer_ID=101;

COMMIT;
SELECT * FROM Customers;
