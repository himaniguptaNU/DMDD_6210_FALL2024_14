--This report lists the inventory transfers for restocking products.
SELECT it.product_id, p.name AS product_name, 
       it.source_warehouse_id, it.destination_warehouse_id, 
       it.quantity, it.transfer_date, it.status
FROM Inventory_Transfer it
JOIN Product p ON it.product_id = p.product_id
WHERE it.status = 'Completed'
ORDER BY it.transfer_date DESC;
