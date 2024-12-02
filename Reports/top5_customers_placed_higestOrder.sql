--This report identifies the top 5 customers who have placed the highest number of orders.
SELECT c.customer_id, c.name AS customer_name, COUNT(co.order_id) AS total_orders
FROM Customer_Order co
JOIN Customer c ON co.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC
FETCH FIRST 5 ROWS ONLY;