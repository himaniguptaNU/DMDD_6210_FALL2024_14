SET SERVEROUTPUT ON;
-- Start of the package specification
CREATE OR REPLACE PACKAGE SalesManager AUTHID DEFINER AS
    PROCEDURE PlaceOrder (
        p_customer_id IN NUMBER,
        p_product_id IN NUMBER,
        p_quantity IN NUMBER,
        p_shipping_address IN VARCHAR2
    );
END SalesManager;
/
-- End of the package specification

-- Start of the package body
CREATE OR REPLACE PACKAGE BODY SalesManager AS
    PROCEDURE PlaceOrder (
        p_customer_id IN NUMBER,
        p_product_id IN NUMBER,
        p_quantity IN NUMBER,
        p_shipping_address IN VARCHAR2
    ) IS
    BEGIN
    -- Validate access
        IF NOT ValidateUserAccess('SALESMANAGER') THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient privileges to access the SalesManager package.');
        END IF;
        UtilityPackage.PlaceOrder(p_customer_id, p_product_id, p_quantity, p_shipping_address);
    END PlaceOrder;
END SalesManager;
/
-- End of the package body
