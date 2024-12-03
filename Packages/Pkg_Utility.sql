--This package will centralize the logic and provide a shared interface for all roles.
--It has the package Sepecifations and the package body
--Function.sql should be excecuted before executing the below script
SET SERVEROUTPUT ON;
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

-- Start of the package body
--All the shared procedures (PlaceOrder, ReplenishStock, TransferInventory, CheckLowStock) are implemented
CREATE OR REPLACE PACKAGE BODY UtilityPackage AS
    -- PlaceOrder Procedure
    PROCEDURE placeorder (
        p_customer_id      IN NUMBER,
        p_product_id       IN NUMBER,
        p_quantity         IN NUMBER,
        p_shipping_address IN VARCHAR2
    ) AS
        v_order_id     NUMBER;
        v_total_amount NUMBER;
        v_warehouse_id NUMBER;
    BEGIN
    -- Calculate the total amount
        v_total_amount := calculateordertotal(p_product_id, p_quantity);

    -- Find a warehouse with sufficient stock
        SELECT
            warehouse_id
        INTO v_warehouse_id
        FROM
            warehouse_product
        WHERE
                product_id = p_product_id
            AND quantity_in_stock >= p_quantity
        FETCH FIRST ROW ONLY;

    -- Validate stock using GetCurrentStock
        IF getcurrentstock(p_product_id, v_warehouse_id) < p_quantity THEN
            raise_application_error(-20004, 'Insufficient stock for the product.');
        END IF;

    -- Insert the order into Customer_Order
        INSERT INTO customer_order (
            order_id,
            order_date,
            shipping_address,
            status,
            total_amount,
            customer_id,
            warehouse_id
        ) VALUES (
            seq_order_id.NEXTVAL,
            sysdate,
            p_shipping_address,
            'Pending',
            v_total_amount,
            p_customer_id,
            v_warehouse_id
        ) RETURNING order_id INTO v_order_id;

    -- Insert order details
        INSERT INTO order_details (
            order_id,
            product_id,
            quantity,
            unit_price
        )
            SELECT
                v_order_id,
                p_product_id,
                p_quantity,
                price
            FROM
                product
            WHERE
                product_id = p_product_id;

    -- Deduct stock from the warehouse
        UPDATE warehouse_product
        SET
            quantity_in_stock = quantity_in_stock - p_quantity
        WHERE
                product_id = p_product_id
            AND warehouse_id = v_warehouse_id;

        dbms_output.put_line('Order placed successfully with Order ID: ' || v_order_id);
    EXCEPTION
        WHEN no_data_found THEN
            raise_application_error(-20005, 'Product or warehouse not found.');
        WHEN OTHERS THEN
            dbms_output.put_line('Error placing order: ' || sqlerrm);
    END placeorder;

-----------------------------------------------------------------------------------------------------------------------------------

    -- ReplenishStock Procedure
    PROCEDURE replenishstock (
        p_product_id   IN NUMBER,
        p_warehouse_id IN NUMBER,
        p_quantity     IN NUMBER
    ) IS
    BEGIN
    -- Check if the product exists in the warehouse
        IF NOT isproductinwarehouse(p_product_id, p_warehouse_id) THEN
            raise_application_error(-20003, 'Product not found in the specified warehouse.');
        END IF;

    -- Update stock in Warehouse_Product
        UPDATE warehouse_product
        SET
            quantity_in_stock = quantity_in_stock + p_quantity,
            last_updated = sysdate
        WHERE
                product_id = p_product_id
            AND warehouse_id = p_warehouse_id;

        dbms_output.put_line('Stock replenished: Product ID '
                             || p_product_id
                             || ', Warehouse ID '
                             || p_warehouse_id
                             || ', Quantity Added: '
                             || p_quantity);

    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error replenishing stock: ' || sqlerrm);
    END replenishstock;
    
------------------------------------------------------------------------------------------------------------------------------------------

    -- TransferInventory Procedure
    PROCEDURE TransferInventory (
    p_source_warehouse_id IN NUMBER,
    p_dest_warehouse_id IN NUMBER,
    p_product_id IN NUMBER,
    p_quantity IN NUMBER
) IS
    v_current_stock_source NUMBER;
    v_current_stock_dest NUMBER;
BEGIN
    -- Check if the product exists in the source warehouse
    IF NOT IsProductInWarehouse(p_product_id, p_source_warehouse_id) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Product not found in source warehouse.');
    END IF;

    -- Check if the product exists in the destination warehouse
    IF NOT IsProductInWarehouse(p_product_id, p_dest_warehouse_id) THEN
        -- Automatically add a default entry for the product in the destination warehouse
        INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
        VALUES (p_dest_warehouse_id, p_product_id, 0, 20, SYSDATE);
        DBMS_OUTPUT.PUT_LINE('Default entry created for Product ID ' || p_product_id || 
                             ' in Destination Warehouse ID ' || p_dest_warehouse_id);
    END IF;

    -- Check the current stock level in the source warehouse
    v_current_stock_source := GetCurrentStock(p_product_id, p_source_warehouse_id);

    -- Handle stock-related issues
    IF v_current_stock_source IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'No stock entry found for Product ID ' || p_product_id || 
                                      ' in Source Warehouse ID ' || p_source_warehouse_id);
    ELSIF v_current_stock_source < p_quantity THEN
        RAISE_APPLICATION_ERROR(-20003, 'Insufficient stock in Source Warehouse ID ' || p_source_warehouse_id ||
                                      ' for Product ID ' || p_product_id || '. Available: ' || v_current_stock_source || 
                                      ', Requested: ' || p_quantity);
    END IF;

    -- Deduct stock from the source warehouse
    UPDATE Warehouse_Product
    SET quantity_in_stock = quantity_in_stock - p_quantity,
        last_updated = SYSDATE
    WHERE product_id = p_product_id AND warehouse_id = p_source_warehouse_id;

    -- Add stock to the destination warehouse
    UPDATE Warehouse_Product
    SET quantity_in_stock = quantity_in_stock + p_quantity,
        last_updated = SYSDATE
    WHERE product_id = p_product_id AND warehouse_id = p_dest_warehouse_id;

    -- Get updated stock level in the destination warehouse
    v_current_stock_dest := GetCurrentStock(p_product_id, p_dest_warehouse_id);

    -- Output success message
    DBMS_OUTPUT.PUT_LINE('Inventory transferred successfully: Product ID ' || p_product_id ||
                         ', Source Warehouse ID ' || p_source_warehouse_id ||
                         ', Destination Warehouse ID ' || p_dest_warehouse_id ||
                         ', Quantity Transferred: ' || p_quantity ||
                         ', Updated Stock in Destination Warehouse: ' || v_current_stock_dest);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error transferring inventory: ' || SQLERRM);
END TransferInventory;

--------------------------------------------------------------------------------------------------------------------

    -- CheckLowStock Procedure
    PROCEDURE checklowstock IS
        v_status VARCHAR2(20);
    BEGIN
        FOR record IN (
            SELECT
    "A1"."PRODUCT_ID"        "PRODUCT_ID",
    "A1"."WAREHOUSE_ID"      "WAREHOUSE_ID",
    "A1"."QUANTITY_IN_STOCK" "QUANTITY_IN_STOCK",
    "A1"."REORDER_LEVEL"     "REORDER_LEVEL"
FROM
    "SUPERVISOR"."WAREHOUSE_PRODUCT" "A1"
        ) LOOP
        -- Get stock status using the CheckStockStatus function
            v_status := checkstockstatus(record.product_id, record.warehouse_id);
            IF v_status = 'Low' THEN
                dbms_output.put_line('Low stock detected: Product ID '
                                     || record.product_id
                                     || ', Warehouse ID '
                                     || record.warehouse_id
                                     || ', Current Stock: '
                                     || record.quantity_in_stock
                                     || ', Reorder Level: '
                                     || record.reorder_level);

            ELSE
                dbms_output.put_line('Stock is sufficient: Product ID '
                                     || record.product_id
                                     || ', Warehouse ID '
                                     || record.warehouse_id
                                     || ', Current Stock: '
                                     || record.quantity_in_stock
                                     || ', Reorder Level: '
                                     || record.reorder_level);
            END IF;

        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error checking stock: ' || sqlerrm);
    END checklowstock;
END UtilityPackage;
/
-- End of the package body
