-- Enable DBMS_OUTPUT for feedback
SET SERVEROUTPUT ON;

-- Step 1: Truncate All Tables in Correct Order to Avoid Foreign Key Constraints
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE ORDER_DETAILS';
    DBMS_OUTPUT.PUT_LINE('Table ORDER_DETAILS truncated successfully.');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE CUSTOMER_ORDER';
    DBMS_OUTPUT.PUT_LINE('Table CUSTOMER_ORDER truncated successfully.');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE INVENTORY_TRANSFER';
    DBMS_OUTPUT.PUT_LINE('Table INVENTORY_TRANSFER truncated successfully.');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE WAREHOUSE_PRODUCT';
    DBMS_OUTPUT.PUT_LINE('Table WAREHOUSE_PRODUCT truncated successfully.');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE SUPPLIER_PRODUCT';
    DBMS_OUTPUT.PUT_LINE('Table SUPPLIER_PRODUCT truncated successfully.');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE CUSTOMER';
    DBMS_OUTPUT.PUT_LINE('Table CUSTOMER truncated successfully.');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE WAREHOUSE';
    DBMS_OUTPUT.PUT_LINE('Table WAREHOUSE truncated successfully.');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE PRODUCT';
    DBMS_OUTPUT.PUT_LINE('Table PRODUCT truncated successfully.');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE SUPPLIER';
    DBMS_OUTPUT.PUT_LINE('Table SUPPLIER truncated successfully.');
END;
/
-- Step 2: Insert Data with Exception Handling to Avoid Duplicate Errors
DECLARE
BEGIN
    -- Supplier records
    BEGIN
        INSERT INTO Supplier (supplier_id, name, contact_info, address)
        VALUES (1000, 'Supplier A', 'contactA@example.com', '123 Supplier St');
        INSERT INTO Supplier (supplier_id, name, contact_info, address)
        VALUES (1001, 'Supplier B', 'contactB@example.com', '456 Supplier Ave');
        INSERT INTO Supplier (supplier_id, name, contact_info, address)
        VALUES (1002, 'Supplier C', 'contactC@example.com', '789 Supplier Rd');
        INSERT INTO Supplier (supplier_id, name, contact_info, address)
        VALUES (1003, 'Supplier D', 'contactD@example.com', '101 Supplier Ln');
        INSERT INTO Supplier (supplier_id, name, contact_info, address)
        VALUES (1004, 'Supplier E', 'contactE@example.com', '202 Supplier Blvd');
        DBMS_OUTPUT.PUT_LINE('Supplier records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Supplier records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Supplier: ' || SQLERRM);
    END;

    -- Product records
    BEGIN
        INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
        VALUES (2000, 'Product A', 'High quality product A', 'Electronics', 100.50, 1.2, '10x10x5');
        INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
        VALUES (2001, 'Product B', 'High quality product B', 'Home Goods', 45.00, 0.8, '8x8x4');
        INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
        VALUES (2002, 'Product C', 'Eco-friendly product', 'Garden', 60.75, 1.5, '12x12x6');
        INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
        VALUES (2003, 'Product D', 'Durable and reliable', 'Tools', 75.00, 2.0, '15x15x7');
        INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
        VALUES (2004, 'Product E', 'Long-lasting', 'Furniture', 120.00, 15.5, '30x20x10');
        DBMS_OUTPUT.PUT_LINE('Product records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Product records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Product: ' || SQLERRM);
    END;

    -- Warehouse records
    BEGIN
        INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
        VALUES (3000, 'Warehouse A Location', 1000, 'Manager A');
        INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
        VALUES (3001, 'Warehouse B Location', 1500, 'Manager B');
        INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
        VALUES (3002, 'Warehouse C Location', 1200, 'Manager C');
        INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
        VALUES (3003, 'Warehouse D Location', 1300, 'Manager D');
        INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
        VALUES (3004, 'Warehouse E Location', 2000, 'Manager E');
        DBMS_OUTPUT.PUT_LINE('Warehouse records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Warehouse records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Warehouse: ' || SQLERRM);
    END;

    -- Customer records
    BEGIN
        INSERT INTO Customer (customer_id, name, email, phone, address)
        VALUES (4000, 'Alice Smith', 'alice_smith@example.com', '555-1234', '123 Elm St');
        INSERT INTO Customer (customer_id, name, email, phone, address)
        VALUES (4001, 'Bob Jones', 'bob_jones@example.com', '555-5678', '456 Maple Ave');
        INSERT INTO Customer (customer_id, name, email, phone, address)
        VALUES (4002, 'Carol White', 'carol_white@example.com', '555-8765', '789 Oak Rd');
        INSERT INTO Customer (customer_id, name, email, phone, address)
        VALUES (4003, 'David Brown', 'david_brown@example.com', '555-2345', '101 Pine St');
        INSERT INTO Customer (customer_id, name, email, phone, address)
        VALUES (4004, 'Eva Green', 'eva_green@example.com', '555-3456', '202 Birch St');
        DBMS_OUTPUT.PUT_LINE('Customer records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Customer records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Customer: ' || SQLERRM);
    END;

    -- Warehouse_Product records
    BEGIN
        INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
        VALUES (3000, 2000, 50, 20, SYSDATE);
        INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
        VALUES (3001, 2001, 100, 30, SYSDATE);
        INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
        VALUES (3002, 2002, 150, 25, SYSDATE);
        INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
        VALUES (3003, 2003, 200, 40, SYSDATE);
        INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
        VALUES (3004, 2004, 120, 50, SYSDATE);
        DBMS_OUTPUT.PUT_LINE('Warehouse_Product records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Warehouse_Product records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Warehouse_Product: ' || SQLERRM);
    END;

    -- Inventory_Transfer records
    BEGIN
        INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
        VALUES (6000, 3000, 3001, 2000, 15, SYSDATE - 2, 'Completed');
        INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
        VALUES (6001, 3001, 3002, 2001, 10, SYSDATE - 5, 'Pending');
        INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
        VALUES (6002, 3002, 3003, 2002, 20, SYSDATE - 3, 'Completed');
        INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
        VALUES (6003, 3003, 3004, 2003, 25, SYSDATE - 1, 'Pending');
        INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
        VALUES (6004, 3004, 3000, 2004, 12, SYSDATE - 4, 'Completed');
        DBMS_OUTPUT.PUT_LINE('Inventory_Transfer records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Inventory_Transfer records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Inventory_Transfer: ' || SQLERRM);
    END;

    -- Customer_Order records
    BEGIN
        INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
        VALUES (5000, SYSDATE, '123 Elm St', 'Shipped', 150.75, 4000, 3000);
        INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
        VALUES (5001, SYSDATE - 1, '456 Maple Ave', 'Pending', 95.50, 4001, 3001);
        INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
        VALUES (5002, SYSDATE - 2, '789 Oak Rd', 'Delivered', 60.75, 4002, 3002);
        INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
        VALUES (5003, SYSDATE - 3, '101 Pine St', 'Cancelled', 120.00, 4003, 3003);
        INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
        VALUES (5004, SYSDATE - 4, '202 Birch St', 'Shipped', 200.25, 4004, 3004);
        DBMS_OUTPUT.PUT_LINE('Customer_Order records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Customer_Order records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Customer_Order: ' || SQLERRM);
    END;

    -- Order_Details records
     BEGIN
        INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
        VALUES (5000, 2000, 2, 75.00);
        INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
        VALUES (5001, 2001, 1, 45.00);
        INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
        VALUES (5002, 2002, 3, 60.75);
        INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
        VALUES (5003, 2003, 4, 80.00);
        INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
        VALUES (5004, 2004, 5, 100.25);
        DBMS_OUTPUT.PUT_LINE('Order_Details records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Order_Details records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Order_Details: ' || SQLERRM);
    END;

    -- Supplier_Product records
    BEGIN
        INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
        VALUES (1000, 2000, 95.00, 7);
        INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
        VALUES (1001, 2001, 42.00, 10);
        INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
        VALUES (1002, 2002, 55.00, 5);
        INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
        VALUES (1003, 2003, 70.00, 8);
        INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
        VALUES (1004, 2004, 110.00, 12);
        DBMS_OUTPUT.PUT_LINE('Supplier_Product records inserted.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Duplicate Supplier_Product records detected. Skipping insertions.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inserting records into Supplier_Product: ' || SQLERRM);
    END;

END;
/
