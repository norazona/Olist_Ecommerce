-- Step 2 - Check for Duplicates

-- Check for duplicates in the customers table
SELECT
	customer_id,
	COUNT(*)
FROM customers 
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check for duplicates in the orders table
SELECT
	order_id,
	COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check for duplicates in the products table
SELECT
	product_id,
	COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Check for duplicates in the sellers table
SELECT
	seller_id ,
	COUNT(*)
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- Check for duplicates in the order_reviews table
SELECT
	review_id,
	COUNT(*)
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

-- Remove Duplicates from the order_reviews table
delete from order_reviews 
where review_id in (
	select review_id 
	from (
		select 
			review_id,
			row_number() over(partition by review_id, review_answer_timestamp order by review_creation_date) as row_num
		from order_reviews
		) as duplicates
	where row_num > 1
);

	
	
	
	
	
	
	
	