-- Enable DBMS_OUTPUT display in SQL*Plus or SQL Developer
SET SERVEROUTPUT ON;

-- PL/SQL block for creating the Supervisor user with all necessary privileges and exception handling
DECLARE
    user_exists NUMBER;
BEGIN
    -- Check if the Supervisor user already exists
    SELECT COUNT(*) INTO user_exists FROM all_users WHERE username = 'SUPERVISOR';
    
    -- If Supervisor does not exist, create the user with appropriate settings
    IF user_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER Supervisor IDENTIFIED BY "Sup3rv1s0r@123" DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users';
        DBMS_OUTPUT.PUT_LINE('Supervisor user created successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Supervisor user already exists; creation skipped.');
    END IF;

    -- Grant necessary privileges to Supervisor with ADMIN OPTION and exception handling
    DECLARE
        priv_error VARCHAR2(100);
    BEGIN
        FOR privilege IN (
            SELECT 'CONNECT' AS priv FROM dual UNION ALL
            SELECT 'CREATE SESSION' FROM dual UNION ALL
            SELECT 'ALTER SESSION' FROM dual UNION ALL
            SELECT 'CREATE TABLE' FROM dual UNION ALL
            SELECT 'CREATE VIEW' FROM dual UNION ALL
            SELECT 'CREATE SEQUENCE' FROM dual UNION ALL
            SELECT 'CREATE SYNONYM' FROM dual UNION ALL
            SELECT 'CREATE DATABASE LINK' FROM dual UNION ALL
            SELECT 'RESOURCE' FROM dual UNION ALL
            SELECT 'UNLIMITED TABLESPACE' FROM dual UNION ALL
            SELECT 'CREATE ROLE' FROM dual UNION ALL
            SELECT 'CREATE USER' FROM dual UNION ALL
            SELECT 'ALTER USER' FROM dual UNION ALL
            SELECT 'DROP USER' FROM dual UNION ALL
            SELECT 'GRANT ANY ROLE' FROM dual UNION ALL
            SELECT 'SELECT ANY TABLE' FROM dual
        ) LOOP
            BEGIN
                EXECUTE IMMEDIATE 'GRANT ' || privilege.priv || ' TO Supervisor WITH ADMIN OPTION';
                DBMS_OUTPUT.PUT_LINE('Granted ' || privilege.priv || ' privilege to Supervisor with ADMIN OPTION.');
            EXCEPTION
                WHEN OTHERS THEN 
                    priv_error := SQLERRM;
                    DBMS_OUTPUT.PUT_LINE(privilege.priv || ' grant failed for Supervisor: ' || priv_error);
            END;
        END LOOP;
    END;

    DBMS_OUTPUT.PUT_LINE('Supervisor user setup completed with necessary privileges.');

END;
/