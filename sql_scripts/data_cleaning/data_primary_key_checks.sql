-- Step 1 - Check for Missing Values in Each Table

-- Check for missing primary keys in the orders table
SELECT
	COUNT(*) AS total_rows,
	COUNT(order_id) AS non_null_count
FROM orders;

-- Check for missing primary keys in the customers table
SELECT
	COUNT(*) AS total_rows,
	COUNT(customer_id) AS non_null_count
FROM customers;

-- Check for missing primary keys in the order_items table
SELECT
	COUNT(*) AS total_rows,
	COUNT(order_item_id) AS non_null_count
FROM order_items;

-- Check for missing primary keys in the order_items table
SELECT
	COUNT(*) AS total_rows,
	COUNT(order_id) AS non_null_count
FROM order_items;

-- Check for missing primary keys in the order_payments table
SELECT
	COUNT(*) AS total_rows,
	COUNT(order_id) AS non_null_count
FROM order_payments;

-- Check for missing primary keys in the order_reviews table
SELECT
	COUNT(*) AS total_rows,
	COUNT(review_id) AS non_null_count
FROM order_reviews;

-- Check for missing primary keys in the products table
SELECT
	COUNT(*) AS total_rows,
	COUNT(product_id) AS non_null_count
FROM products;

-- Check for missing primary keys in the products table
SELECT
	COUNT(*) AS total_rows,
	COUNT(product_id) AS non_null_count
FROM products;

-- Check for missing primary keys in the products table
SELECT
	COUNT(*) AS total_rows,
	COUNT(seller_id) AS non_null_count
FROM sellers;








