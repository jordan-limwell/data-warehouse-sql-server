--=============================
-- GENERAL EXPLORATORY ANALYSIS
--=============================

-- Explore All Countries our customers come from
SELECT DISTINCT country FROM gold.dim_customers

-- Explore All Categories "The Major Divisions"
SELECT DISTINCT category, sub_category, product_name FROM gold.dim_products
ORDER BY 1,2,3

-- Explore the dates of orders (first and last)
SELECT
	MIN(order_date) first_order_date,
	MAX(order_date) last_order_date,
	DATEDIFF(year, MIN(order_date), MAX(order_date)) order_range_years
FROM gold.fact_sales

-- Find the youngest and the oldest customer
SELECT
	MIN(birthdate) AS oldest_birthdate,
	MAX(birthdate) AS youngest_birthdate,
	DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
	DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers
