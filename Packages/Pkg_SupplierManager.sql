SET SERVEROUTPUT ON;
-- Start of the package specification
CREATE OR REPLACE PACKAGE SupplierManager AUTHID DEFINER AS
    PROCEDURE CheckLowStock;
END SupplierManager;
/
-- End of the package specification