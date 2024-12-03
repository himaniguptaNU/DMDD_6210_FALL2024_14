SET SERVEROUTPUT ON;
-- Start of the package specification
CREATE OR REPLACE PACKAGE SupplierManager AUTHID DEFINER AS
    PROCEDURE CheckLowStock;
END SupplierManager;
/
-- End of the package specification

----------------------------------------------------------------------------------------------------------------
-- Start of the package body
CREATE OR REPLACE PACKAGE BODY SupplierManager AS
    -- Placeholder package body
    PROCEDURE CheckLowStock IS
    BEGIN
    -- Validate access
        IF NOT ValidateUserAccess('SUPPLIERMANAGER') THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient privileges to access the SupplierManager package.');
        END IF;
        
        UtilityPackage.CheckLowStock;
    END CheckLowStock;
END SupplierManager;
/
-- End of the package body