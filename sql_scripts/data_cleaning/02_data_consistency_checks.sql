-- Data Cleaning Part 3 - Check for Invalid or Outlier Values

-- Check for negative values in order_items table
select *
from order_items 
where price < 0 
or freight_value < 0;

-- Check for negative values in order_payments table
select *
from order_payments 
where payment_installments < 0 
or payment_value < 0;

-- Check for unrealistic dates in orders table 
select *
from orders
where order_delivered_customer_date < order_purchase_timestamp;

-- Data Cleaning Part 4 - Check for Data Consistency

-- Check for orders that reference a customer_id not in the customer table
select order_id
from orders o
left join customers c on o.customer_id = c.customer_id
where c.customer_id is null;

-- Check for orders that reference a product_id not in the product table
select 
	oi.order_id
from order_items oi 
left join products p on oi.product_id = p.product_id 
where p.product_id is null;

-- Check for reviews that reference an order_id not in the orders table
select 
	review_id
from order_reviews r
left join orders o on r.order_id = o.order_id
where o.order_id is null;


-- Data Cleaning Part 5 - Check Categorical Consistency

select distinct payment_type from order_payments;

select distinct customer_state from customers;

select distinct review_score from order_reviews;

select distinct review_message_left from order_reviews;

select distinct order_status from orders;

select distinct product_category_name from products;

-- Delete the rows with no product_category_name from orders table
delete from orders
where order_id in (
  select o.order_id
  from products p
  join order_items oi on p.product_id = oi.product_id
  join orders o on oi.order_id = o.order_id
  where p.product_category_name = ''
);

-- Delete the rows with no product_category_name from order_items table 
-- (had no referential integrity set in the foreign key)
delete from order_items
where order_id in (
	select 
		oi.order_id	
	--p.product_id
	from products p
	join order_items oi on p.product_id = oi.product_id
	where p.product_category_name = ''
);

-- Delete the rows with no product_category_name from products table 
delete from products
where product_id in (
	select 	
		product_id
	from products
	where product_category_name = ''
);




