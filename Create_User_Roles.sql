-- Enable DBMS_OUTPUT display for feedback
SET SERVEROUTPUT ON;

-- Drop roles if they already exist, with exception handling
BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE SUPERVISOR_ROLE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role SUPERVISOR_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE INVENTORY_MANAGER_ROLE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role INVENTORY_MANAGER_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE SALES_MANAGER_ROLE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role SALES_MANAGER_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE SUPPLIER_MANAGER_ROLE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role SUPPLIER_MANAGER_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE INVENTORY_USER_ROLE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role INVENTORY_USER_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END IF;
END;
/

-- Create roles and grant privileges to each role

CREATE ROLE SUPERVISOR_ROLE;

-- Grant specific privileges on each table and view to SUPERVISOR_ROLE
GRANT SELECT, INSERT, UPDATE, DELETE ON Product TO SUPERVISOR_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON Warehouse_Product TO SUPERVISOR_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON Inventory_Transfer TO SUPERVISOR_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON Customer_Order TO SUPERVISOR_ROLE;
-- Add grants for other tables and views as required...

-- Inventory Manager Role with SELECT, INSERT, UPDATE on specified tables and views
CREATE ROLE INVENTORY_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Product TO INVENTORY_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Warehouse_Product TO INVENTORY_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Inventory_Transfer TO INVENTORY_MANAGER_ROLE;
GRANT SELECT ON Stock_Level_View TO INVENTORY_MANAGER_ROLE;
GRANT SELECT ON Inventory_Transfer_History_View TO INVENTORY_MANAGER_ROLE;

-- Sales Manager Role with SELECT, INSERT on order-related tables and SELECT on views
CREATE ROLE SALES_MANAGER_ROLE;
GRANT SELECT, INSERT ON Customer_Order TO SALES_MANAGER_ROLE;
GRANT SELECT, INSERT ON Customer TO SALES_MANAGER_ROLE;
GRANT SELECT, INSERT ON Order_Details TO SALES_MANAGER_ROLE;
GRANT SELECT ON Order_Summary_View TO SALES_MANAGER_ROLE;
GRANT SELECT ON Customer_Order_Details_View TO SALES_MANAGER_ROLE;

-- Supplier Manager Role with SELECT, INSERT, UPDATE on supplier tables and view
CREATE ROLE SUPPLIER_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Supplier TO SUPPLIER_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Supplier_Product TO SUPPLIER_MANAGER_ROLE;
GRANT SELECT ON Supplier_Product_Info_View TO SUPPLIER_MANAGER_ROLE;

-- Inventory User Role with read-only (SELECT) access to inventory-related tables and views
CREATE ROLE INVENTORY_USER_ROLE;
GRANT SELECT ON Product TO INVENTORY_USER_ROLE;
GRANT SELECT ON Warehouse_Product TO INVENTORY_USER_ROLE;
GRANT SELECT ON Inventory_Transfer TO INVENTORY_USER_ROLE;
GRANT SELECT ON Stock_Level_View TO INVENTORY_USER_ROLE;
GRANT SELECT ON Inventory_Transfer_History_View TO INVENTORY_USER_ROLE;

-- Drop existing users to avoid conflicts
BEGIN
    FOR usr IN (SELECT 'SUPERVISOR_USR' AS username FROM dual UNION ALL
                SELECT 'INVENTORY_MANAGER_USR' FROM dual UNION ALL
                SELECT 'SALES_MANAGER_USR' FROM dual UNION ALL
                SELECT 'SUPPLIER_MANAGER_USR' FROM dual UNION ALL
                SELECT 'INVENTORY_USER_USR' FROM dual) LOOP
        EXECUTE IMMEDIATE 'DROP USER ' || usr.username || ' CASCADE';
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error dropping user: ' || SQLERRM);
END;
/
