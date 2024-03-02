-- 1. Create table

CREATE TABLE sales (
	order_id int8 PRIMARY KEY,
	date VARCHAR(50),
	item_name VARCHAR(50),
	item_type VARCHAR(50),
	item_price DECIMAL(10,2),
	quantity int8,
	transaction_amount DECIMAL(10,2),
	transaction_type VARCHAR(50),
	received_by VARCHAR(50),
	time_of_sale VARCHAR(50)
)


-- 2. Total Revenue

SELECT SUM (item_price * quantity) AS total_revenue
FROM sales;

-- 3. Total Product Sold

SELECT SUM (quantity) AS total_product_sold
FROM sales;


-- 4. Total Orders

SELECT COUNT(order_id) AS total_orders 
FROM sales;

-- 5. Average Product Per Order

SELECT SUM(quantity)/COUNT(order_id)  AS average_product_per_order 
FROM sales; 


-- 6. Percentage of  ‘Not Available’ transactions

SELECT COUNT(quantity)/1000.00 AS percentage_of_null_transactions
FROM sales
WHERE transaction_type IS NULL;

-- 7. Total amount of ‘Not Available’  transaction type 

SELECT SUM(transaction_amount)	 AS  total_amount_on_non_registered_transaction_type
FROM sales
WHERE transaction_type IS NULL;

-- 8. Favorite Products By Gender

SELECT
  CASE 
	WHEN received_by = 'Mr.' THEN 'Male'
	WHEN received_by = 'Mrs.' THEN 'Female'
	ELSE received_by
    END AS gender_category,
	item_name,
    SUM(quantity) AS total_quantity
FROM
    sales
GROUP BY
    received_by,
    item_name
ORDER BY
    received_by,
    total_quantity DESC;


-- The following queries depend on the view defined above (transformed_sales_view).


-- 9. Daily trend for total orders

SELECT day_name, COUNT(order_id)
FROM  transformed_sales_view
GROUP BY day_name;

-- 10. Monthly trend for total orders

SELECT month_name, COUNT(order_id)
FROM  transformed_sales_view
GROUP BY month_name;


-- 11. Hourly trend for total orders

SELECT time_of_sale_transformed, COUNT(order_id)
FROM  transformed_sales_view
GROUP BY time_of_sale_transformed
ORDER BY time_of_sale_transformed;


-- 12. Total of products sold by name

SELECT 
	item_name, 
	sum(quantity) AS sum_of_quantity
FROM  transformed_sales_view
GROUP BY item_name
ORDER BY sum_of_quantity  DESC;


-- 13. Total of sales by product name 

SELECT 
	item_name, 
	SUM(transaction_amount) AS total_of_sales_by_product_name 
FROM  transformed_sales_view
GROUP BY item_name
ORDER BY total_of_sales_by_product_name DESC;

