--This package will centralize the logic and provide a shared interface for all roles.
--It has the package Sepecifations and the package body
--Function.sql should be excecuted before executing the below script
-- Start of the package specification
CREATE OR REPLACE PACKAGE UtilityPackage AUTHID DEFINER AS
    -- Procedure to place an order
    PROCEDURE PlaceOrder (
        p_customer_id IN NUMBER,
        p_product_id IN NUMBER,
        p_quantity IN NUMBER,
        p_shipping_address IN VARCHAR2
    );

    -- Procedure to replenish stock
    PROCEDURE ReplenishStock (
        p_product_id IN NUMBER,
        p_warehouse_id IN NUMBER,
        p_quantity IN NUMBER
    );

    -- Procedure to transfer inventory
    PROCEDURE TransferInventory (
        p_source_warehouse_id IN NUMBER,
        p_dest_warehouse_id IN NUMBER,
        p_product_id IN NUMBER,
        p_quantity IN NUMBER
    );

    -- Procedure to check low stock levels
    PROCEDURE CheckLowStock;
END UtilityPackage;
/
-- End of the package specification
