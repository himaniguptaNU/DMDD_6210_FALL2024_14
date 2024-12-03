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