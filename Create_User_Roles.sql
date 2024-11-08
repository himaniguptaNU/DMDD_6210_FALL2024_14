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

