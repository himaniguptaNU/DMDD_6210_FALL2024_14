SET SERVEROUTPUT ON;
-- Start of the package specification
CREATE OR REPLACE PACKAGE InventoryUser AUTHID DEFINER AS
    PROCEDURE CheckLowStock;

    PROCEDURE TransferInventory (
        p_source_warehouse_id IN NUMBER,
        p_dest_warehouse_id IN NUMBER,
        p_product_id IN NUMBER,
        p_quantity IN NUMBER
    );
END InventoryUser;
/
-- End of the package specification

---------------------------------------------------------------------------------------------------------

-- Start of the package body
CREATE OR REPLACE PACKAGE BODY InventoryUser AS
    PROCEDURE CheckLowStock IS
    BEGIN
    -- Validate access
        IF NOT ValidateUserAccess('INVENTORYUSER') THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient privileges to access the InventoryUser package.');
        END IF;
        
        UtilityPackage.CheckLowStock;
    END CheckLowStock;

    PROCEDURE TransferInventory (
        p_source_warehouse_id IN NUMBER,
        p_dest_warehouse_id IN NUMBER,
        p_product_id IN NUMBER,
        p_quantity IN NUMBER
    ) IS
    BEGIN
    -- Validate access
        IF NOT ValidateUserAccess('INVENTORYUSER') THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient privileges to access the InventoryUser package.');
        END IF;
        
        UtilityPackage.TransferInventory(p_source_warehouse_id, p_dest_warehouse_id, p_product_id, p_quantity);
    END TransferInventory;
END InventoryUser;
/
-- End of the package body