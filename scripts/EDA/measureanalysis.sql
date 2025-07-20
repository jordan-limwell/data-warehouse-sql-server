--======================================
-- GENERATED REPORT FOR MEASURE ANALYSIS
--======================================
SELECT
	'Total Sales' AS measure_name,
	SUM(sales_amount) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
	'Total Quantity' AS measure_name,
	SUM(quantity) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
	'Average Price' AS measure_name,
	AVG(price) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
	'Total Orders' AS measure_name,
	COUNT(DISTINCT order_number) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
	'Total Products' AS measure_name,
	COUNT(product_key) AS measure_value
FROM gold.dim_products
UNION ALL
SELECT
	'Total Customers' AS measure_name,
	COUNT(customer_id) AS measure_value
FROM gold.dim_customers
UNION ALL
SELECT
	'Total Customers With Orders' AS measure_name,
	COUNT(DISTINCT customer_key) AS measure_value
FROM gold.fact_sales
