--trigger to check the low stock
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER trg_notify_low_stock
AFTER UPDATE OR INSERT ON Warehouse_Product
FOR EACH ROW
BEGIN
    IF :NEW.quantity_in_stock < 10 THEN
        DBMS_OUTPUT.PUT_LINE('Low Stock Alert: Warehouse ID: ' || :NEW.warehouse_id ||
                             ', Product ID: ' || :NEW.product_id ||
                             '. Current stock is ' || :NEW.quantity_in_stock ||
                             '. Please place an order with the supplier.');
    END IF;
END;
/

--trigger to update inventory transfer status
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER trg_update_inventory_transfer_status
BEFORE UPDATE OR INSERT ON Inventory_Transfer
FOR EACH ROW
BEGIN
    -- Ensure quantity respects constraints
    IF :NEW.quantity <= 1 THEN
        :NEW.quantity := 1; -- Enforce minimum allowed value to avoid violations
        :NEW.status := 'Completed';
        DBMS_OUTPUT.PUT_LINE('Transfer ID: ' || :NEW.transfer_id || 
                             ' is marked as "Completed". Quantity set to 1 (minimum allowed).');

    -- Handle low stock
    ELSIF :NEW.quantity < 5 THEN
        :NEW.status := 'Pending';
        DBMS_OUTPUT.PUT_LINE('Transfer ID: ' || :NEW.transfer_id || 
                             ' has low stock of ' || :NEW.quantity || 
                             '. Status set to "Pending". Consider restocking.');

    -- Handle sufficient stock
    ELSE
        :NEW.status := 'Stock Available';
        DBMS_OUTPUT.PUT_LINE('Transfer ID: ' || :NEW.transfer_id || 
                             ' has sufficient stock. Status set to "Stock Available".');
    END IF;
END;
/


