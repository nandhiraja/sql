
-- Indexes
CREATE INDEX idx_employees_department_id ON employees(department_id);
CREATE INDEX idx_orders_customer_id      ON orders(customer_id);
CREATE INDEX idx_orders_order_date       ON orders(order_date);
CREATE INDEX idx_orderdetails_order_id   ON orderdetails(order_id);
CREATE INDEX idx_orderdetails_product_id ON orderdetails(product_id);
CREATE INDEX idx_products_category_id    ON products(category_id);

-- Trigger function 
CREATE OR REPLACE FUNCTION update_inventory()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    current_stock INT;
BEGIN
    SELECT stock INTO current_stock
    FROM products
    WHERE product_id = NEW.product_id;

    IF current_stock < NEW.quantity THEN
        RAISE EXCEPTION 'Not enough stock for product_id %', NEW.product_id;
    END IF;

    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

    INSERT INTO inventorylog (product_id, old_stock, new_stock, note)
    VALUES (
        NEW.product_id,
        current_stock,
        current_stock - NEW.quantity,
        'Stock updated after order insertion'
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_update_inventory
AFTER INSERT ON orderdetails
FOR EACH ROW
EXECUTE FUNCTION update_inventory();

-- View
CREATE VIEW order_summary_view AS
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_name,
    od.quantity,
    od.unit_price,
    od.quantity * od.unit_price AS line_total
FROM orders o
JOIN customers c  ON o.customer_id = c.customer_id
JOIN orderdetails od ON o.order_id = od.order_id
JOIN products p   ON od.product_id = p.product_id;

SELECT * FROM order_summary_view ORDER BY order_id;

-- Transaction
BEGIN;
UPDATE products SET stock = stock - 2 WHERE product_id = 1;
UPDATE products SET stock = stock - 1 WHERE product_id = 2;
COMMIT;

-- Trigger test
INSERT INTO orders (order_id, customer_id, order_date, order_status)
VALUES (8, 2, CURRENT_DATE, 'Pending');

INSERT INTO orderdetails (order_detail_id, order_id, product_id, quantity, unit_price)
VALUES (13, 8, 1, 2, 799);

SELECT * FROM products WHERE product_id = 1;
SELECT * FROM inventorylog ORDER BY changed_at DESC;
