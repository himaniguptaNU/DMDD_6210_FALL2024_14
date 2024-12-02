--Top-Selling Products Report
SELECT 
    od.product_id,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM 
    Order_Details od
JOIN 
    Product p ON od.product_id = p.product_id
GROUP BY 
    od.product_id, p.name
ORDER BY 
    total_quantity_sold DESC;
    


