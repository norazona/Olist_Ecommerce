-- Exploratory Data Analysis - Customers and Customer Reviews

-- How many unique customers are there?
SELECT
	COUNT(DISTINCT customer_id) AS unique_customers
FROM customers; 

-- Which state has the most purchases?
SELECT 	
	c.customer_state,
	COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c 
	ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;

-- What’s the average review score per product category?
SELECT 
	pct.product_category_name_english AS product_category,
	ROUND(AVG(rev.review_score), 2) AS avg_review
FROM order_reviews rev 
JOIN orders o
	ON rev.order_id = o.order_id 
JOIN order_items oi
	ON o.order_id = oi.order_id 
JOIN products p
	ON oi.product_id = p.product_id 
JOIN product_category_translation pct 
	ON p.product_category_name = pct.product_category_name 
GROUP BY product_category 
ORDER BY avg_review ASC;

-- What is the average score for people who have left a review message vs people who have not left one?
SELECT 
	(SELECT AVG(review_score) FROM order_reviews WHERE review_message_left = 'Y') AS avg_score_with_message,
	AVG(review_score) AS avg_score_without_message
FROM order_reviews
WHERE review_message_left = 'N';

-- What factors seem correlated with low review scores (e.g., long delivery times)?
SELECT 
	r.review_score,
	ROUND(AVG(EXTRACT (DAY FROM (order_delivered_customer_date - order_purchase_timestamp))), 2) AS delivery_time
FROM order_reviews r
JOIN orders o
	ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY r.review_score
ORDER BY r.review_score;


