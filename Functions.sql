--This function calculates the total cost of an order for a given product and quantity.
CREATE OR REPLACE FUNCTION CalculateOrderTotal (
    p_product_id IN NUMBER,
    p_quantity IN NUMBER
) RETURN NUMBER IS
    v_total_amount NUMBER;
BEGIN
    SELECT price * p_quantity INTO v_total_amount
    FROM Product
    WHERE product_id = p_product_id;

    RETURN v_total_amount;
END;
/

--This function retrieves the warehouse ID that has sufficient stock for a given product.
CREATE OR REPLACE FUNCTION FindWarehouseWithStock (
    p_product_id IN NUMBER,
    p_quantity IN NUMBER
) RETURN NUMBER IS
    v_warehouse_id NUMBER;
BEGIN
    SELECT warehouse_id
    INTO v_warehouse_id
    FROM Warehouse_Product
    WHERE product_id = p_product_id AND quantity_in_stock >= p_quantity
    FETCH FIRST ROW ONLY;

    RETURN v_warehouse_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL; -- Returns NULL if no warehouse has sufficient stock
END;
/