--This report evaluates suppliers based on their contribution to the inventory and their ability to deliver products on time.
SELECT
    s.supplier_id,
    s.name                        AS supplier_name,
    COUNT(DISTINCT sp.product_id) AS total_products_supplied, --counts the total distinct products supplied by each supplier.
    SUM(sp.price * sp.lead_time)  AS weighted_cost_efficiency,--calculates a weighted cost based on price and lead time,
    AVG(sp.lead_time)             AS average_lead_time, --Average delivery time for all products from the supplier.
    MAX(sp.lead_time)             AS max_lead_time,--The longest lead time for any product.
    MIN(sp.lead_time)             AS min_lead_time,--The shortest lead time for any product.
    SUM(
        CASE
            WHEN sp.lead_time <= 7 THEN
                1
            ELSE
                0
        END
    )                             AS deliveries_within_a_week, --Counts the number of deliveries completed within a week
    round((sum(
        CASE
            WHEN sp.lead_time <= 7 THEN
                1
            ELSE 0
        END
    ) / count(sp.product_id)) * 100,
          2)                      AS percentage_on_time_delivery --Calculates the percentage of on-time deliveries.
FROM
         supplier s
    JOIN supplier_product sp ON s.supplier_id = sp.supplier_id
GROUP BY
    s.supplier_id,
    s.name
ORDER BY
    weighted_cost_efficiency ASC,
    percentage_on_time_delivery DESC
FETCH FIRST 10 ROWS ONLY;