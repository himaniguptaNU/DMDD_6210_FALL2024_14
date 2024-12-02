-- This report is to generate top 2 most sold products 
SELECT 
    od.product_id,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM 
    Order_Details od
JOIN 
    Product p ON od.product_id = p.product_id
GROUP BY 
    od.product_id, p.name
ORDER BY 
    total_quantity_sold DESC
FETCH FIRST 2 ROWS ONLY;

