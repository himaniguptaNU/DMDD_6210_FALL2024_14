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

-- This function checks the stock level and return Low or Sufficient based on reorder_level
CREATE OR REPLACE FUNCTION CheckStockStatus (
    p_product_id IN NUMBER,
    p_warehouse_id IN NUMBER
) RETURN VARCHAR2 IS
    v_status VARCHAR2(20);
BEGIN
    SELECT CASE 
               WHEN quantity_in_stock <= reorder_level THEN 'Low'
               ELSE 'Sufficient'
           END
    INTO v_status
    FROM Warehouse_Product
    WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;

    RETURN v_status;
END;
/

--This function retrieves the current stock level in warehouse
CREATE OR REPLACE FUNCTION GetCurrentStock (
    p_product_id IN NUMBER,
    p_warehouse_id IN NUMBER
) RETURN NUMBER IS
    v_quantity NUMBER;
BEGIN
    SELECT quantity_in_stock
    INTO v_quantity
    FROM Warehouse_Product
    WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;

    RETURN v_quantity;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL; -- Return NULL if no record exists
END;
/


--This function checks if a product is there in warehouse
CREATE OR REPLACE FUNCTION IsProductInWarehouse (
    p_product_id IN NUMBER,
    p_warehouse_id IN NUMBER
) RETURN BOOLEAN IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Warehouse_Product
    WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;

    RETURN v_count > 0;
END;
/

CREATE OR REPLACE FUNCTION ValidateUserAccess (
    p_package_name IN VARCHAR2
) RETURN BOOLEAN IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM user_tab_privs
    WHERE grantee = USER
          AND privilege = 'EXECUTE'
          AND table_name = UPPER(p_package_name);

    RETURN v_count > 0;
END;
/