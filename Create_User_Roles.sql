-- Enable DBMS_OUTPUT display for feedback
SET SERVEROUTPUT ON;

-- Drop roles if they already exist
BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE SUPERVISOR_ROLE';
    DBMS_OUTPUT.PUT_LINE('Role SUPERVISOR_ROLE dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role SUPERVISOR_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping role SUPERVISOR_ROLE: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE INVENTORY_MANAGER_ROLE';
    DBMS_OUTPUT.PUT_LINE('Role INVENTORY_MANAGER_ROLE dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role INVENTORY_MANAGER_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping role INVENTORY_MANAGER_ROLE: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE SALES_MANAGER_ROLE';
    DBMS_OUTPUT.PUT_LINE('Role SALES_MANAGER_ROLE dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role SALES_MANAGER_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping role SALES_MANAGER_ROLE: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE SUPPLIER_MANAGER_ROLE';
    DBMS_OUTPUT.PUT_LINE('Role SUPPLIER_MANAGER_ROLE dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role SUPPLIER_MANAGER_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping role SUPPLIER_MANAGER_ROLE: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP ROLE INVENTORY_USER_ROLE';
    DBMS_OUTPUT.PUT_LINE('Role INVENTORY_USER_ROLE dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1924 THEN
            DBMS_OUTPUT.PUT_LINE('Role INVENTORY_USER_ROLE does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping role INVENTORY_USER_ROLE: ' || SQLERRM);
        END IF;
END;
/

-- Drop users if they already exist (excluding SUPERVISOR_USR)
BEGIN
    EXECUTE IMMEDIATE 'DROP USER INVENTORY_MANAGER_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User INVENTORY_MANAGER_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User INVENTORY_MANAGER_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user INVENTORY_MANAGER_USR: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP USER SALES_MANAGER_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User SALES_MANAGER_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User SALES_MANAGER_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user SALES_MANAGER_USR: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP USER SUPPLIER_MANAGER_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User SUPPLIER_MANAGER_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User SUPPLIER_MANAGER_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user SUPPLIER_MANAGER_USR: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP USER INVENTORY_USER_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User INVENTORY_USER_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User INVENTORY_USER_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user INVENTORY_USER_USR: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP USER PACKAGE_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User PACKAGE_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User PACKAGE_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user PACKAGE_USR: ' || SQLERRM);
        END IF;
END;
/

-- Final confirmation
BEGIN
    DBMS_OUTPUT.PUT_LINE('All roles and users dropped successfully.');
END;
/

-- Step 2: Create roles and grant privileges
CREATE ROLE SUPERVISOR_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON Product TO SUPERVISOR_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON Warehouse_Product TO SUPERVISOR_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON Inventory_Transfer TO SUPERVISOR_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON Customer_Order TO SUPERVISOR_ROLE;

CREATE ROLE INVENTORY_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Product TO INVENTORY_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Warehouse_Product TO INVENTORY_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Inventory_Transfer TO INVENTORY_MANAGER_ROLE;
GRANT SELECT ON Stock_Level_View TO INVENTORY_MANAGER_ROLE;
GRANT SELECT ON Inventory_Transfer_History_View TO INVENTORY_MANAGER_ROLE;

CREATE ROLE SALES_MANAGER_ROLE;
GRANT SELECT, INSERT ON Customer_Order TO SALES_MANAGER_ROLE;
GRANT SELECT, INSERT ON Customer TO SALES_MANAGER_ROLE;
GRANT SELECT, INSERT ON Order_Details TO SALES_MANAGER_ROLE;
GRANT SELECT ON Order_Summary_View TO SALES_MANAGER_ROLE;
GRANT SELECT ON Customer_Order_Details_View TO SALES_MANAGER_ROLE;

CREATE ROLE SUPPLIER_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Supplier TO SUPPLIER_MANAGER_ROLE;
GRANT SELECT, INSERT, UPDATE ON Supplier_Product TO SUPPLIER_MANAGER_ROLE;
GRANT SELECT ON Supplier_Product_Info_View TO SUPPLIER_MANAGER_ROLE;

CREATE ROLE INVENTORY_USER_ROLE;
GRANT SELECT ON Product TO INVENTORY_USER_ROLE;
GRANT SELECT ON Warehouse_Product TO INVENTORY_USER_ROLE;
GRANT SELECT ON Inventory_Transfer TO INVENTORY_USER_ROLE;
GRANT SELECT ON Stock_Level_View TO INVENTORY_USER_ROLE;
GRANT SELECT ON Inventory_Transfer_History_View TO INVENTORY_USER_ROLE;

-- Step 3: Drop users if they already exist (excluding Supervisor User)
-- Enable DBMS_OUTPUT display for feedback
SET SERVEROUTPUT ON;

-- Drop users if they already exist (excluding SUPERVISOR_USR)
BEGIN
    EXECUTE IMMEDIATE 'DROP USER INVENTORY_MANAGER_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User INVENTORY_MANAGER_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User INVENTORY_MANAGER_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user INVENTORY_MANAGER_USR: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP USER SALES_MANAGER_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User SALES_MANAGER_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User SALES_MANAGER_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user SALES_MANAGER_USR: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP USER SUPPLIER_MANAGER_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User SUPPLIER_MANAGER_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User SUPPLIER_MANAGER_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user SUPPLIER_MANAGER_USR: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP USER INVENTORY_USER_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User INVENTORY_USER_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User INVENTORY_USER_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user INVENTORY_USER_USR: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP USER PACKAGE_USR CASCADE';
    DBMS_OUTPUT.PUT_LINE('User PACKAGE_USR dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1918 THEN
            DBMS_OUTPUT.PUT_LINE('User PACKAGE_USR does not exist, skipping drop.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error dropping user PACKAGE_USR: ' || SQLERRM);
        END IF;
END;
/

-- Confirmation message
BEGIN
    DBMS_OUTPUT.PUT_LINE('All specified users dropped successfully.');
END;
/

-- Step 4: Create users and assign roles
CREATE USER INVENTORY_MANAGER_USR IDENTIFIED BY "InvM@nager2023#";
GRANT CONNECT, INVENTORY_MANAGER_ROLE TO INVENTORY_MANAGER_USR;

CREATE USER SALES_MANAGER_USR IDENTIFIED BY "SalesM@nager2023#";
GRANT CONNECT, SALES_MANAGER_ROLE TO SALES_MANAGER_USR;

CREATE USER SUPPLIER_MANAGER_USR IDENTIFIED BY "SupM@nager2023#";
GRANT CONNECT, SUPPLIER_MANAGER_ROLE TO SUPPLIER_MANAGER_USR;

CREATE USER INVENTORY_USER_USR IDENTIFIED BY "InvUs3r2023#";
GRANT CONNECT, INVENTORY_USER_ROLE TO INVENTORY_USER_USR;

CREATE USER PACKAGE_USR IDENTIFIED BY "Password@12345";
GRANT CONNECT TO PACKAGE_USR;

-- Final confirmation
BEGIN
    DBMS_OUTPUT.PUT_LINE('Roles and users created successfully.');
END;
/


