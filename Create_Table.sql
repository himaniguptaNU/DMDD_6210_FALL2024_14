-- Enable DBMS_OUTPUT for feedback
SET SERVEROUTPUT ON;

-- Drop existing tables to avoid conflicts
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE ORDER_DETAILS CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table ORDER_DETAILS dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table ORDER_DETAILS: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE CUSTOMER_ORDER CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table CUSTOMER_ORDER dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table CUSTOMER_ORDER: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE INVENTORY_TRANSFER CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table INVENTORY_TRANSFER dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table INVENTORY_TRANSFER: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE WAREHOUSE_PRODUCT CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table WAREHOUSE_PRODUCT dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table WAREHOUSE_PRODUCT: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE SUPPLIER_PRODUCT CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table SUPPLIER_PRODUCT dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table SUPPLIER_PRODUCT: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE CUSTOMER CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table CUSTOMER dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table CUSTOMER: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE WAREHOUSE CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table WAREHOUSE dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table WAREHOUSE: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE PRODUCT CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table PRODUCT dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table PRODUCT: ' || SQLERRM);
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE SUPPLIER CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table SUPPLIER dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table SUPPLIER: ' || SQLERRM);
    END;
END;
/

-- Create tables with validations and constraints
DECLARE
    v_message VARCHAR2(100);
BEGIN
    -- Supplier Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Supplier (
            supplier_id NUMBER PRIMARY KEY,
            name VARCHAR2(100) NOT NULL,
            contact_info VARCHAR2(100) NOT NULL,
            address VARCHAR2(200) NOT NULL
        )';
        DBMS_OUTPUT.PUT_LINE('Table SUPPLIER created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table SUPPLIER: ' || SQLERRM);
    END;

    -- Product Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Product (
            product_id NUMBER PRIMARY KEY,
            name VARCHAR2(100) NOT NULL UNIQUE,
            description VARCHAR2(200),
            category VARCHAR2(50) NOT NULL,
            price NUMBER(10, 2) CHECK (price > 0),
            weight NUMBER(5, 2) CHECK (weight > 0),
            dimensions VARCHAR2(20) NOT NULL
        )';
        DBMS_OUTPUT.PUT_LINE('Table PRODUCT created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table PRODUCT: ' || SQLERRM);
    END;

    -- Warehouse Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Warehouse (
            warehouse_id NUMBER PRIMARY KEY,
            location VARCHAR2(100) NOT NULL,
            capacity NUMBER CHECK (capacity > 0),
            manager_name VARCHAR2(100) NOT NULL
        )';
        DBMS_OUTPUT.PUT_LINE('Table WAREHOUSE created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table WAREHOUSE: ' || SQLERRM);
    END;

    -- Customer Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Customer (
            customer_id NUMBER PRIMARY KEY,
            name VARCHAR2(100) NOT NULL,
            email VARCHAR2(100) UNIQUE NOT NULL,
            phone VARCHAR2(15) UNIQUE,
            address VARCHAR2(200) NOT NULL
        )';
        DBMS_OUTPUT.PUT_LINE('Table CUSTOMER created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table CUSTOMER: ' || SQLERRM);
    END;

    -- Warehouse_Product Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Warehouse_Product (
            warehouse_id NUMBER NOT NULL,
            product_id NUMBER NOT NULL,
            quantity_in_stock NUMBER CHECK (quantity_in_stock >= 0),
            reorder_level NUMBER CHECK (reorder_level >= 0),
            last_updated DATE DEFAULT SYSDATE,
            PRIMARY KEY (warehouse_id, product_id),
            FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id),
            FOREIGN KEY (product_id) REFERENCES Product(product_id)
        )';
        DBMS_OUTPUT.PUT_LINE('Table WAREHOUSE_PRODUCT created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table WAREHOUSE_PRODUCT: ' || SQLERRM);
    END;

    -- Inventory_Transfer Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Inventory_Transfer (
            transfer_id NUMBER PRIMARY KEY,
            source_warehouse_id NUMBER NOT NULL,
            destination_warehouse_id NUMBER NOT NULL,
            product_id NUMBER NOT NULL,
            quantity NUMBER CHECK (quantity > 0),
            transfer_date DATE DEFAULT SYSDATE,
            status VARCHAR2(50) CHECK (status IN (''Pending'', ''Completed'', ''Stock Available'')),
            FOREIGN KEY (source_warehouse_id) REFERENCES Warehouse(warehouse_id),
            FOREIGN KEY (destination_warehouse_id) REFERENCES Warehouse(warehouse_id),
            FOREIGN KEY (product_id) REFERENCES Product(product_id)
        )';
        DBMS_OUTPUT.PUT_LINE('Table INVENTORY_TRANSFER created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table INVENTORY_TRANSFER: ' || SQLERRM);
    END;

    -- Customer_Order Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Customer_Order (
            order_id NUMBER PRIMARY KEY,
            order_date DATE DEFAULT SYSDATE,
            shipping_address VARCHAR2(200) NOT NULL,
            status VARCHAR2(50) CHECK (status IN (''Pending'', ''Shipped'', ''Delivered'', ''Cancelled'')),
            total_amount NUMBER(10, 2) CHECK (total_amount >= 0),
            customer_id NUMBER NOT NULL,
            warehouse_id NUMBER NOT NULL,
            FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
            FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
        )';
        DBMS_OUTPUT.PUT_LINE('Table CUSTOMER_ORDER created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table CUSTOMER_ORDER: ' || SQLERRM);
    END;

    -- Order_Details Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Order_Details (
            order_id NUMBER NOT NULL,
            product_id NUMBER NOT NULL,
            quantity NUMBER CHECK (quantity > 0),
            unit_price NUMBER(10, 2) CHECK (unit_price >= 0),
            PRIMARY KEY (order_id, product_id),
            FOREIGN KEY (order_id) REFERENCES Customer_Order(order_id),
            FOREIGN KEY (product_id) REFERENCES Product(product_id)
        )';
        DBMS_OUTPUT.PUT_LINE('Table ORDER_DETAILS created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table ORDER_DETAILS: ' || SQLERRM);
    END;

    -- Supplier_Product Table
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE TABLE Supplier_Product (
            supplier_id NUMBER NOT NULL,
            product_id NUMBER NOT NULL,
            price NUMBER(10, 2) CHECK (price > 0),
            lead_time NUMBER CHECK (lead_time >= 0),
            PRIMARY KEY (supplier_id, product_id),
            FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id),
            FOREIGN KEY (product_id) REFERENCES Product(product_id)
        )';
        DBMS_OUTPUT.PUT_LINE('Table SUPPLIER_PRODUCT created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating table SUPPLIER_PRODUCT: ' || SQLERRM);
    END;

END;
/