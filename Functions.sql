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
