-- Exploratory Data Analysis - Sales and Orders

-- What's the trend of monthly revenue over time?
SELECT 
	DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
	COUNT(DISTINCT o.order_id) AS total_orders,
	SUM(oi.price + oi.freight_value) AS revenue
FROM orders o
JOIN order_items oi 
	ON o.order_id = oi.order_id
GROUP BY MONTH
ORDER BY MONTH;

-- Which product categories generate the highest sales and revenue?
SELECT
	pct.product_category_name_english, 
	COUNT(DISTINCT oi.order_id) AS total_orders,
	SUM(oi.price + oi.freight_value) AS revenue
FROM order_items oi
JOIN products p 
	ON oi.product_id = p.product_id 
JOIN product_category_translation pct
	ON p.product_category_name = pct.product_category_name 
GROUP BY pct.product_category_name_english
ORDER BY total_orders DESC;

-- What is the average order value (AOV)?
SELECT 
	ROUND(SUM(price + freight_value) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM order_items;

-- How many items are usually in one order (average number of items per order)?
SELECT 
	CAST(COUNT(order_id) AS DECIMAL) / CAST(COUNT(DISTINCT order_id) AS DECIMAL) AS avg_items_per_order
FROM order_items;