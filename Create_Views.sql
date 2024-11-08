-- Enable DBMS_OUTPUT for feedback
SET SERVEROUTPUT ON;

-- Step 1: Create Views with Exception Handling

BEGIN
    -- Stock Level View: Shows stock levels of products in each warehouse
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE OR REPLACE VIEW Stock_Level_View AS
        SELECT
            w.warehouse_id,
            w.location AS warehouse_location,
            p.product_id,
            p.name AS product_name,
            wp.quantity_in_stock,
            wp.reorder_level,
            CASE 
                WHEN wp.quantity_in_stock <= wp.reorder_level THEN ''Low''
                ELSE ''Sufficient''
            END AS stock_status
        FROM
            Warehouse w
        JOIN
            Warehouse_Product wp ON w.warehouse_id = wp.warehouse_id
        JOIN
            Product p ON wp.product_id = p.product_id';
        DBMS_OUTPUT.PUT_LINE('Stock_Level_View created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Stock_Level_View: ' || SQLERRM);
    END;

    -- Order Summary View: Provides an overview of customer orders with customer and warehouse information
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE OR REPLACE VIEW Order_Summary_View AS
        SELECT
            co.order_id,
            co.order_date,
            c.customer_id,
            c.name AS customer_name,
            co.shipping_address,
            co.status AS order_status,
            co.total_amount,
            w.location AS warehouse_location
        FROM
            Customer_Order co
        JOIN
            Customer c ON co.customer_id = c.customer_id
        JOIN
            Warehouse w ON co.warehouse_id = w.warehouse_id';
        DBMS_OUTPUT.PUT_LINE('Order_Summary_View created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Order_Summary_View: ' || SQLERRM);
    END;

    -- Supplier Product Information View: Lists suppliers, products, pricing, and lead time
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE OR REPLACE VIEW Supplier_Product_Info_View AS
        SELECT
            s.supplier_id,
            s.name AS supplier_name,
            p.product_id,
            p.name AS product_name,
            sp.price,
            sp.lead_time
        FROM
            Supplier_Product sp
        JOIN
            Supplier s ON sp.supplier_id = s.supplier_id
        JOIN
            Product p ON sp.product_id = p.product_id';
        DBMS_OUTPUT.PUT_LINE('Supplier_Product_Info_View created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Supplier_Product_Info_View: ' || SQLERRM);
    END;

    -- Inventory Transfer History View: Provides history of product transfers between warehouses
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE OR REPLACE VIEW Inventory_Transfer_History_View AS
        SELECT
            it.transfer_id,
            it.transfer_date,
            it.quantity,
            it.status,
            p.product_id,
            p.name AS product_name,
            src.location AS source_warehouse,
            dest.location AS destination_warehouse
        FROM
            Inventory_Transfer it
        JOIN
            Product p ON it.product_id = p.product_id
        JOIN
            Warehouse src ON it.source_warehouse_id = src.warehouse_id
        JOIN
            Warehouse dest ON it.destination_warehouse_id = dest.warehouse_id';
        DBMS_OUTPUT.PUT_LINE('Inventory_Transfer_History_View created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Inventory_Transfer_History_View: ' || SQLERRM);
    END;

    -- Customer Order Details View: Displays details of each customer order with itemized products
    BEGIN
        EXECUTE IMMEDIATE '
        CREATE OR REPLACE VIEW Customer_Order_Details_View AS
        SELECT
            co.order_id,
            c.customer_id,
            c.name AS customer_name,
            p.product_id,
            p.name AS product_name,
            od.quantity,
            od.unit_price,
            (od.quantity * od.unit_price) AS total_item_price
        FROM
            Customer_Order co
        JOIN
            Customer c ON co.customer_id = c.customer_id
        JOIN
            Order_Details od ON co.order_id = od.order_id
        JOIN
            Product p ON od.product_id = p.product_id';
        DBMS_OUTPUT.PUT_LINE('Customer_Order_Details_View created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error creating Customer_Order_Details_View: ' || SQLERRM);
    END;

END;
/