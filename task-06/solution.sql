SELECT
    order_id,
    order_date,
    CURRENT_DATE - order_date AS days_ago
FROM orders
ORDER BY order_date;

SELECT *
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY order_date DESC;

SELECT
    order_id,
    TO_CHAR(order_date, 'DD-Mon-YYYY') AS formatted_order_date
FROM orders;