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