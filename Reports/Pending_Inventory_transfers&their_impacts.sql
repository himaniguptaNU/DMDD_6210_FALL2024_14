--The query retrieves details of pending inventory transfers and classifies them based on whether they are delayed or on time.

SELECT t.transfer_id, 
       p.name AS product_name, 
       sw.location AS source_warehouse, 
       dw.location AS destination_warehouse, 
       t.transfer_date as transfer_date, 
       t.status as order_fulfillment_status, 
       CASE 
           WHEN SYSDATE - t.transfer_date > 7 THEN 'Delayed'
           ELSE 'On Time'
       END AS current_transfer_status
FROM Inventory_Transfer t
JOIN Product p ON t.product_id = p.product_id
JOIN Warehouse sw ON t.source_warehouse_id = sw.warehouse_id
JOIN Warehouse dw ON t.destination_warehouse_id = dw.warehouse_id
WHERE t.status = 'Pending';




