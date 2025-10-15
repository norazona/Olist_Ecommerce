-- Exploratory Data Analysis - Shipping and Payments

-- What’s the average delivery time per order (delivery date - purchase date)?
SELECT
	AVG(EXTRACT(DAY FROM(order_delivered_customer_date - order_purchase_timestamp))) AS delivery_time
FROM orders;


-- Which product categories have the longest delivery times?
SELECT 
	pct.product_category_name_english AS product_category,
	AVG(EXTRACT(DAY FROM(order_delivered_customer_date - order_purchase_timestamp))) AS delivery_time
FROM orders o
JOIN order_items oi
	ON o.order_id = oi.order_id 
JOIN products p
	ON oi.product_id = p.product_id 
JOIN product_category_translation pct 
	ON p.product_category_name = pct.product_category_name 
GROUP BY product_category 
ORDER BY delivery_time DESC;

-- What are the most common payment types?
SELECT 
    payment_type,
    COUNT(*) AS payment_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percent_of_total
FROM order_payments
GROUP BY payment_type
ORDER BY payment_count DESC;

-- What’s the average payment value and number of installments per order?
WITH payment_orders AS ( 
	SELECT 
        order_id,
        SUM(payment_value) AS order_total_value,
        MAX(payment_installments) AS total_installments
    FROM order_payments
    GROUP BY order_id
)
SELECT
    ROUND(AVG(order_total_value), 2) AS avg_payment_value_per_order,
    ROUND(AVG(total_installments), 2) AS avg_installments_per_order
FROM payment_orders;











