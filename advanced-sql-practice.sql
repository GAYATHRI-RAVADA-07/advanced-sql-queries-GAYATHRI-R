USE online_store;

-- =========================================
-- Task 1: GROUP BY and SUM()
-- Calculate total spending for each customer_id.
-- =========================================

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- =========================================
-- Task 2: GROUP BY with multiple columns
-- Calculate total spending for each customer on each order date.
-- =========================================

SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, order_date;

-- =========================================
-- Task 3: WHERE with GROUP BY
-- Calculate spending using only orders greater than $200.
-- =========================================

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount > 200
GROUP BY customer_id;

-- =========================================
-- Task 4: HAVING with GROUP BY
-- Show customer groups whose total spending exceeds $200.
-- =========================================

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount)> 200;

-- =========================================
-- Task 5: INNER JOIN
-- Display orders with their matching customer names.
-- =========================================


SELECT
    orders.id AS order_id,
    customers.first_name,
    customers.last_name,
    orders.order_date,
    orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

-- =========================================
-- Task 6: LEFT JOIN
-- Show all orders, including orders without a matching customer.
-- =========================================

SELECT
    orders.id AS order_id,
    customers.first_name,
    customers.last_name,
    orders.order_date,
    orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

-- =========================================
-- Task 7: LEFT JOIN variation
-- Show every customer, including customers with no orders.
-- =========================================

SELECT
    customers.id AS customer_id,
    customers.first_name,
    customers.last_name,
    orders.id AS order_id,
    orders.total_amount
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;

-- =========================================
-- Task 8: Scalar subquery
-- Find orders whose amount is at least the average order amount.
-- =========================================

SELECT
    id,
    order_date,
    total_amount
FROM orders
WHERE total_amount >= (
    SELECT AVG(total_amount)
    FROM orders
);

-- =========================================
-- Task 9: Column subquery
-- Find orders placed by customers whose last name is Smith.
-- =========================================

SELECT
    id,
    order_date,
    total_amount,
    customer_id
FROM orders
WHERE customer_id IN (
    SELECT id
    FROM customers
    WHERE last_name = 'Smith'
);

-- =========================================
-- Task 10: Table subquery
-- Select order dates from a derived table of order information.
-- =========================================

SELECT order_date
FROM (
         SELECT id, order_date, total_amount
         FROM orders
     ) AS order_summary;


-- =========================================
-- Task 11: COUNT() aggregate function
-- Count the orders associated with each customer_id.
-- =========================================

SELECT
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;

-- =========================================
-- Task 12: AVG(), MAX(), and MIN()
-- Summarize the order amounts in the orders table.
-- =========================================

SELECT
    AVG(total_amount) AS average_order_amount,
    MAX(total_amount) AS largest_order_amount,
    MIN(total_amount) AS smallest_order_amount
FROM orders;