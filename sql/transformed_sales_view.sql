CREATE VIEW transformed_sales_view AS
SELECT 
    order_id,
    item_name,
    item_type,
    item_price,
    quantity,
    transaction_amount,
    -- Standardize date and extract day and month names
    TO_CHAR(TO_DATE(date, 'MM-DD-YY'), 'YYYY-MM-DD') AS standardized_date,
    UPPER(SUBSTRING(TO_CHAR(TO_DATE(date, 'MM-DD-YY'), 'Day'), 1, 3)) AS day_name,
    UPPER(SUBSTRING(TO_CHAR(TO_DATE(date, 'MM-DD-YY'), 'Month'), 1, 3)) AS month_name,
    -- Transform gender
    CASE
        WHEN received_by = 'Mr.' THEN 'Male'
        WHEN received_by = 'Mrs.' THEN 'Female'
    END AS gender,
    -- Fill missing transaction types
    COALESCE(transaction_type, 'Not Available') AS transaction_type_filled,
    -- Transform time of sale
    CASE time_of_sale
        WHEN 'Morning'   THEN '08:00'
        WHEN 'Afternoon' THEN '13:00'
        WHEN 'Evening'   THEN '18:00'
        WHEN 'Night'     THEN '21:00'
        WHEN 'Midnight'  THEN '00:00'
        ELSE time_of_sale
    END AS time_of_sale_transformed
FROM sales;
