-- Enable DBMS_OUTPUT for feedback
SET SERVEROUTPUT ON;

DECLARE
    PROCEDURE create_sequence(sequence_name VARCHAR2, start_value NUMBER) IS
    BEGIN
        BEGIN
            -- Attempt to drop the sequence if it exists
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || sequence_name;
            DBMS_OUTPUT.PUT_LINE('Sequence ' || sequence_name || ' dropped.');
        EXCEPTION
            WHEN OTHERS THEN
                -- Ignore any error if the sequence does not exist. 
                --If the sequence doesn’t exist, Oracle throws an error with code -2289. 
                --We catch this error and print a message indicating the sequence was skipped.
                IF SQLCODE = -2289 THEN
                    DBMS_OUTPUT.PUT_LINE('Sequence ' || sequence_name || ' does not exist; skipping drop.');
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Error while dropping sequence ' || sequence_name || ': ' || SQLERRM);
                END IF;
        END;

        -- Create sequence with the specified start value
        EXECUTE IMMEDIATE 'CREATE SEQUENCE ' || sequence_name || 
                          ' START WITH ' || start_value || ' INCREMENT BY 1';
        DBMS_OUTPUT.PUT_LINE('Sequence ' || sequence_name || ' created with start value ' || start_value || '.');
    END;

BEGIN
    -- Call the create_sequence procedure for each sequence with unique starting values
    create_sequence('SEQ_CUSTOMER_ID', 1000);
    create_sequence('SEQ_PRODUCT_ID', 2000);
    create_sequence('SEQ_SUPPLIER_ID', 3000);
    create_sequence('SEQ_WAREHOUSE_ID', 4000);
    create_sequence('SEQ_TRANSFER_ID', 5000);
    create_sequence('SEQ_ORDER_ID', 6000);
    create_sequence('SEQ_WAREHOUSE_PRODUCT_ID', 7000);
    create_sequence('SEQ_ORDER_DETAILS_ID', 8000);
    create_sequence('SEQ_SUPPLIER_PRODUCT_ID', 9000);

    DBMS_OUTPUT.PUT_LINE('Sequence creation script with unique starting values completed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error encountered during sequence creation: ' || SQLERRM);
END;
/