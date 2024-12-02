--This report lists products that have inventory levels below their reorder level.
SELECT wp.product_id, p.name AS product_name, wp.quantity_in_stock, wp.reorder_level, w.location AS warehouse_location
FROM Warehouse_Product wp
JOIN Product p ON wp.product_id = p.product_id
JOIN Warehouse w ON wp.warehouse_id = w.warehouse_id
WHERE wp.quantity_in_stock < wp.reorder_level
ORDER BY wp.quantity_in_stock ASC;


