-- Data Cleaning Part 3 - Check for Invalid or Outlier Values

-- Check for negative values in order_items table
SELECT *
FROM order_items
WHERE price < 0
OR freight_value < 0;

-- Check for negative values in order_payments table
SELECT *
FROM order_payments
WHERE payment_installments < 0
OR payment_value < 0;

-- Check for unrealistic dates in orders table 
SELECT *
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- Data Cleaning Part 4 - Check for Data Consistency

-- Check for orders that reference a customer_id not in the customer table
SELECT order_id
FROM orders o
LEFT JOIN customers c ON
o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Check for orders that reference a product_id not in the product table
SELECT oi.order_id
FROM order_items oi
LEFT JOIN products p ON
oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Check for reviews that reference an order_id not in the orders table
SELECT review_id
FROM order_reviews r
LEFT JOIN orders o ON
r.order_id = o.order_id
WHERE o.order_id IS NULL;


-- Data Cleaning Part 5 - Check Categorical Consistency

SELECT DISTINCT payment_type
FROM order_payments;

SELECT DISTINCT customer_state
FROM customers;

SELECT DISTINCT review_score
FROM order_reviews;

SELECT DISTINCT review_message_left
FROM order_reviews;

SELECT DISTINCT order_status
FROM orders;

SELECT DISTINCT product_category_name
FROM products;

-- Delete the rows with no product_category_name from orders table
DELETE
FROM orders
WHERE order_id IN (
  SELECT o.order_id
FROM products p
JOIN order_items oi ON
p.product_id = oi.product_id
JOIN orders o ON
oi.order_id = o.order_id
WHERE p.product_category_name = ''
);

-- Delete the rows with no product_category_name from order_items table 
-- (had no referential integrity set in the foreign key)
DELETE
FROM order_items
WHERE order_id IN (
	SELECT oi.order_id
--p.product_id
FROM products p
JOIN order_items oi ON
p.product_id = oi.product_id
WHERE p.product_category_name = ''
);

-- Delete the rows with no product_category_name from products table 
DELETE
FROM products
WHERE product_id IN (
	SELECT product_id
FROM products
WHERE product_category_name = ''
);





