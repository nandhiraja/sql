CREATE OR REPLACE FUNCTION get_total_sales(start_date DATE, end_date DATE)
RETURNS TABLE(total_sales NUMERIC)
LANGUAGE SQL
AS $$
    SELECT COALESCE(SUM(od.quantity * od.unit_price), 0) AS total_sales
    FROM orders o
    JOIN orderdetails od ON o.order_id = od.order_id
    WHERE o.order_date BETWEEN start_date AND end_date
      AND o.order_status <> 'Cancelled';
$$;

SELECT * 
FROM get_total_sales(
    (CURRENT_DATE - INTERVAL '30 days')::date,
    CURRENT_DATE
);



CREATE OR REPLACE FUNCTION calc_discount(amount NUMERIC)
RETURNS NUMERIC
LANGUAGE SQL
AS $$
    SELECT CASE
        WHEN amount >= 10000 THEN amount * 0.20
        WHEN amount >= 5000 THEN amount * 0.10
        ELSE amount * 0.05
    END;
$$;


SELECT calc_discount(12000) AS discount_amount;