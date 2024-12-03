SET SERVEROUTPUT ON;
-- Start of the package specification
CREATE OR REPLACE PACKAGE InventoryManager AUTHID DEFINER AS
    PROCEDURE ReplenishStock (
        p_product_id IN NUMBER,
        p_warehouse_id IN NUMBER,
        p_quantity IN NUMBER
    );

    PROCEDURE CheckLowStock;

    PROCEDURE TransferInventory (
        p_source_warehouse_id IN NUMBER,
        p_dest_warehouse_id IN NUMBER,
        p_product_id IN NUMBER,
        p_quantity IN NUMBER
    );
END InventoryManager;
/
-- End of the package specification

-- Start of the package body
CREATE OR REPLACE PACKAGE BODY InventoryManager AS
    PROCEDURE ReplenishStock (
        p_product_id IN NUMBER,
        p_warehouse_id IN NUMBER,
        p_quantity IN NUMBER
    ) IS
    BEGIN
    -- Validate access
        IF NOT ValidateUserAccess('INVENTORYMANAGER') THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient privileges to access the InventoryManager package.');
        END IF;
        
        UtilityPackage.ReplenishStock(p_product_id, p_warehouse_id, p_quantity);
    END ReplenishStock;

    PROCEDURE CheckLowStock IS
    BEGIN
    -- Validate access
        IF NOT ValidateUserAccess('INVENTORYMANAGER') THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient privileges to access the InventoryManager package.');
        END IF;
    
        UtilityPackage.CheckLowStock;
    END CheckLowStock;