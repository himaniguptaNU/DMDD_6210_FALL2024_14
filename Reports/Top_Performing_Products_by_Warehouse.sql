--Identify the best-selling products for each warehouse based on total sales revenue.
SELECT 
    wp.warehouse_id,
    w.location AS warehouse_location,
    wp.product_id,
    p.name AS product_name,
    SUM(od.quantity * od.unit_price) AS total_sales
FROM 
    Warehouse_Product wp
JOIN 
    Warehouse w ON wp.warehouse_id = w.warehouse_id
JOIN 
    Order_Details od ON wp.product_id = od.product_id
JOIN 
    Customer_Order co ON od.order_id = co.order_id AND wp.warehouse_id = co.warehouse_id
JOIN 
    Product p ON wp.product_id = p.product_id
GROUP BY 
    wp.warehouse_id, w.location, wp.product_id, p.name
HAVING 
    SUM(od.quantity * od.unit_price) > 200  -- Threshold for high-performing products
ORDER BY 
    wp.warehouse_id, total_sales DESC;