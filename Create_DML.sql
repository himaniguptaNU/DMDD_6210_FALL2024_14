-- Enable DBMS_OUTPUT for feedback
SET SERVEROUTPUT ON;

-- Step 1: Truncate All Tables in Correct Order to Avoid Foreign Key Constraints
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE ORDER_DETAILS';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE CUSTOMER_ORDER';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE INVENTORY_TRANSFER';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE WAREHOUSE_PRODUCT';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SUPPLIER_PRODUCT';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE CUSTOMER';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE WAREHOUSE';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PRODUCT';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SUPPLIER';
    DBMS_OUTPUT.PUT_LINE('All tables truncated successfully.');
END;
/

-- Step 2: Reset Sequences to Start with Specific Values
BEGIN
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_SUPPLIER_ID RESTART START WITH 1000';
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_PRODUCT_ID RESTART START WITH 2000';
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_WAREHOUSE_ID RESTART START WITH 3000';
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_CUSTOMER_ID RESTART START WITH 4000';
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ORDER_ID RESTART START WITH 5000';
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_TRANSFER_ID RESTART START WITH 6000';
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_WAREHOUSE_PRODUCT_ID RESTART START WITH 7000';
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_ORDER_DETAILS_ID RESTART START WITH 8000';
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_SUPPLIER_PRODUCT_ID RESTART START WITH 9000';
    DBMS_OUTPUT.PUT_LINE('All sequences reset successfully.');
END;
/

-- Step 3: Insert Data for All Tables
DECLARE
    v_supplier_id_1 NUMBER;
    v_supplier_id_2 NUMBER;
    v_supplier_id_3 NUMBER;
    v_supplier_id_4 NUMBER;
    v_supplier_id_5 NUMBER;

    v_product_id_1 NUMBER;
    v_product_id_2 NUMBER;
    v_product_id_3 NUMBER;
    v_product_id_4 NUMBER;
    v_product_id_5 NUMBER;

    v_warehouse_id_1 NUMBER;
    v_warehouse_id_2 NUMBER;
    v_warehouse_id_3 NUMBER;
    v_warehouse_id_4 NUMBER;
    v_warehouse_id_5 NUMBER;

    v_customer_id_1 NUMBER;
    v_customer_id_2 NUMBER;
    v_customer_id_3 NUMBER;
    v_customer_id_4 NUMBER;
    v_customer_id_5 NUMBER;

    v_order_id_1 NUMBER;
    v_order_id_2 NUMBER;
    v_order_id_3 NUMBER;
    v_order_id_4 NUMBER;
    v_order_id_5 NUMBER;
BEGIN
    -- Supplier Table
    INSERT INTO Supplier (supplier_id, name, contact_info, address)
    VALUES (SEQ_SUPPLIER_ID.NEXTVAL, 'Supplier A', 'contactA@example.com', '123 Supplier St')
    RETURNING supplier_id INTO v_supplier_id_1;

    INSERT INTO Supplier (supplier_id, name, contact_info, address)
    VALUES (SEQ_SUPPLIER_ID.NEXTVAL, 'Supplier B', 'contactB@example.com', '456 Supplier Ave')
    RETURNING supplier_id INTO v_supplier_id_2;

    INSERT INTO Supplier (supplier_id, name, contact_info, address)
    VALUES (SEQ_SUPPLIER_ID.NEXTVAL, 'Supplier C', 'contactC@example.com', '789 Supplier Rd')
    RETURNING supplier_id INTO v_supplier_id_3;

    INSERT INTO Supplier (supplier_id, name, contact_info, address)
    VALUES (SEQ_SUPPLIER_ID.NEXTVAL, 'Supplier D', 'contactD@example.com', '101 Supplier Ln')
    RETURNING supplier_id INTO v_supplier_id_4;

    INSERT INTO Supplier (supplier_id, name, contact_info, address)
    VALUES (SEQ_SUPPLIER_ID.NEXTVAL, 'Supplier E', 'contactE@example.com', '202 Supplier Blvd')
    RETURNING supplier_id INTO v_supplier_id_5;

    DBMS_OUTPUT.PUT_LINE('Supplier records inserted.');

    -- Product Table
    INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
    VALUES (SEQ_PRODUCT_ID.NEXTVAL, 'Product A', 'High quality product A', 'Electronics', 100.50, 1.2, '10x10x5')
    RETURNING product_id INTO v_product_id_1;

    INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
    VALUES (SEQ_PRODUCT_ID.NEXTVAL, 'Product B', 'High quality product B', 'Home Goods', 45.00, 0.8, '8x8x4')
    RETURNING product_id INTO v_product_id_2;

    INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
    VALUES (SEQ_PRODUCT_ID.NEXTVAL, 'Product C', 'Eco-friendly product', 'Garden', 60.75, 1.5, '12x12x6')
    RETURNING product_id INTO v_product_id_3;

    INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
    VALUES (SEQ_PRODUCT_ID.NEXTVAL, 'Product D', 'Durable and reliable', 'Tools', 75.00, 2.0, '15x15x7')
    RETURNING product_id INTO v_product_id_4;

    INSERT INTO Product (product_id, name, description, category, price, weight, dimensions)
    VALUES (SEQ_PRODUCT_ID.NEXTVAL, 'Product E', 'Long-lasting', 'Furniture', 120.00, 15.5, '30x20x10')
    RETURNING product_id INTO v_product_id_5;

    DBMS_OUTPUT.PUT_LINE('Product records inserted.');

    -- Warehouse Table
    INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
    VALUES (SEQ_WAREHOUSE_ID.NEXTVAL, 'Warehouse A', 1000, 'Manager A')
    RETURNING warehouse_id INTO v_warehouse_id_1;

    INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
    VALUES (SEQ_WAREHOUSE_ID.NEXTVAL, 'Warehouse B', 1500, 'Manager B')
    RETURNING warehouse_id INTO v_warehouse_id_2;

    INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
    VALUES (SEQ_WAREHOUSE_ID.NEXTVAL, 'Warehouse C', 2000, 'Manager C')
    RETURNING warehouse_id INTO v_warehouse_id_3;

        INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
    VALUES (SEQ_WAREHOUSE_ID.NEXTVAL, 'Warehouse D', 2500, 'Manager D')
    RETURNING warehouse_id INTO v_warehouse_id_4;

    INSERT INTO Warehouse (warehouse_id, location, capacity, manager_name)
    VALUES (SEQ_WAREHOUSE_ID.NEXTVAL, 'Warehouse E', 3000, 'Manager E')
    RETURNING warehouse_id INTO v_warehouse_id_5;

    DBMS_OUTPUT.PUT_LINE('Warehouse records inserted.');

    -- Customer Table
    INSERT INTO Customer (customer_id, name, email, phone, address)
    VALUES (SEQ_CUSTOMER_ID.NEXTVAL, 'Customer A', 'customerA@example.com', '555-1234', '123 Customer Rd')
    RETURNING customer_id INTO v_customer_id_1;

    INSERT INTO Customer (customer_id, name, email, phone, address)
    VALUES (SEQ_CUSTOMER_ID.NEXTVAL, 'Customer B', 'customerB@example.com', '555-5678', '456 Customer Ave')
    RETURNING customer_id INTO v_customer_id_2;

    INSERT INTO Customer (customer_id, name, email, phone, address)
    VALUES (SEQ_CUSTOMER_ID.NEXTVAL, 'Customer C', 'customerC@example.com', '555-9876', '789 Customer Blvd')
    RETURNING customer_id INTO v_customer_id_3;

    INSERT INTO Customer (customer_id, name, email, phone, address)
    VALUES (SEQ_CUSTOMER_ID.NEXTVAL, 'Customer D', 'customerD@example.com', '555-6543', '101 Customer St')
    RETURNING customer_id INTO v_customer_id_4;

    INSERT INTO Customer (customer_id, name, email, phone, address)
    VALUES (SEQ_CUSTOMER_ID.NEXTVAL, 'Customer E', 'customerE@example.com', '555-3210', '202 Customer Ln')
    RETURNING customer_id INTO v_customer_id_5;

    DBMS_OUTPUT.PUT_LINE('Customer records inserted.');

    -- Warehouse_Product Table
    INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
    VALUES (v_warehouse_id_1, v_product_id_1, 50, 20, SYSDATE);

    INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
    VALUES (v_warehouse_id_2, v_product_id_2, 100, 30, SYSDATE);

    INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
    VALUES (v_warehouse_id_3, v_product_id_3, 150, 25, SYSDATE);

    INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
    VALUES (v_warehouse_id_4, v_product_id_4, 200, 40, SYSDATE);

    INSERT INTO Warehouse_Product (warehouse_id, product_id, quantity_in_stock, reorder_level, last_updated)
    VALUES (v_warehouse_id_5, v_product_id_5, 120, 50, SYSDATE);

    DBMS_OUTPUT.PUT_LINE('Warehouse_Product records inserted.');

    -- Inventory_Transfer Table
    INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
    VALUES (SEQ_TRANSFER_ID.NEXTVAL, v_warehouse_id_1, v_warehouse_id_2, v_product_id_1, 15, SYSDATE - 1, 'Completed');

    INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
    VALUES (SEQ_TRANSFER_ID.NEXTVAL, v_warehouse_id_2, v_warehouse_id_3, v_product_id_2, 20, SYSDATE - 2, 'Pending');

    INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
    VALUES (SEQ_TRANSFER_ID.NEXTVAL, v_warehouse_id_3, v_warehouse_id_4, v_product_id_3, 25, SYSDATE - 3, 'Completed');

    INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
    VALUES (SEQ_TRANSFER_ID.NEXTVAL, v_warehouse_id_4, v_warehouse_id_5, v_product_id_4, 30, SYSDATE - 4, 'Pending');

    INSERT INTO Inventory_Transfer (transfer_id, source_warehouse_id, destination_warehouse_id, product_id, quantity, transfer_date, status)
    VALUES (SEQ_TRANSFER_ID.NEXTVAL, v_warehouse_id_5, v_warehouse_id_1, v_product_id_5, 35, SYSDATE - 5, 'Completed');

    DBMS_OUTPUT.PUT_LINE('Inventory_Transfer records inserted.');

    -- Customer_Order Table
    INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
    VALUES (SEQ_ORDER_ID.NEXTVAL, SYSDATE - 1, '123 Elm St', 'Shipped', 150.75, v_customer_id_1, v_warehouse_id_1)
    RETURNING order_id INTO v_order_id_1;

    INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
    VALUES (SEQ_ORDER_ID.NEXTVAL, SYSDATE - 2, '456 Maple Ave', 'Pending', 95.50, v_customer_id_2, v_warehouse_id_2)
    RETURNING order_id INTO v_order_id_2;

    INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
    VALUES (SEQ_ORDER_ID.NEXTVAL, SYSDATE - 3, '789 Oak Rd', 'Delivered', 60.75, v_customer_id_3, v_warehouse_id_3)
    RETURNING order_id INTO v_order_id_3;

    INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
    VALUES (SEQ_ORDER_ID.NEXTVAL, SYSDATE - 4, '101 Pine St', 'Cancelled', 120.00, v_customer_id_4, v_warehouse_id_4)
    RETURNING order_id INTO v_order_id_4;

    INSERT INTO Customer_Order (order_id, order_date, shipping_address, status, total_amount, customer_id, warehouse_id)
    VALUES (SEQ_ORDER_ID.NEXTVAL, SYSDATE - 5, '202 Birch St', 'Shipped', 200.25, v_customer_id_5, v_warehouse_id_5)
    RETURNING order_id INTO v_order_id_5;

    DBMS_OUTPUT.PUT_LINE('Customer_Order records inserted.');

    -- Order_Details Table
    INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id_1, v_product_id_1, 2, 75.00);

    INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id_2, v_product_id_2, 1, 45.00);

    INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id_3, v_product_id_3, 3, 60.75);

    INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id_4, v_product_id_4, 4, 80.00);

    INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id_5, v_product_id_5, 5, 100.25);

    DBMS_OUTPUT.PUT_LINE('Order_Details records inserted.');

    -- Supplier_Product Table
    INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
    VALUES (v_supplier_id_1, v_product_id_1, 95.00, 7);

    INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
    VALUES (v_supplier_id_2, v_product_id_2, 42.00, 10);

    INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
    VALUES (v_supplier_id_3, v_product_id_3, 55.00, 5);

    INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
    VALUES (v_supplier_id_4, v_product_id_4, 70.00, 8);

    INSERT INTO Supplier_Product (supplier_id, product_id, price, lead_time)
    VALUES (v_supplier_id_5, v_product_id_5, 110.00, 12);

    DBMS_OUTPUT.PUT_LINE('Supplier_Product records inserted.');
END;
/

select* from supplier; 
select* from product;
select* from warehouse;
select* from customer;
select * from Warehouse_Product;
select* from INVENTORY_TRANSFER;
select * from CUSTOMER_ORDER;
select * from ORDER_DETAILS;
select* from SUPPLIER_PRODUCT;
