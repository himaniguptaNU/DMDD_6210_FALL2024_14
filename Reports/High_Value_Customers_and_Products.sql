-- Identify customers who contribute the most to revenue and the products they purchase most frequently.

SELECT 
    c.customer_id,
    c.name AS customer_name,
    SUM(od.quantity * od.unit_price) AS total_spent,
    p.product_id,
    p.name AS product_name,
    COUNT(od.order_id) AS times_purchased
FROM 
    Customer c
JOIN 
    Customer_Order co ON c.customer_id = co.customer_id
JOIN 
    Order_Details od ON co.order_id = od.order_id
JOIN 
    Product p ON od.product_id = p.product_id
GROUP BY 
    c.customer_id, c.name, p.product_id, p.name
HAVING 
    SUM(od.quantity * od.unit_price) > 150   -- Filter for high-value customers
ORDER BY 
    total_spent DESC, times_purchased DESC;
