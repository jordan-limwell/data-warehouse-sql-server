--=========================
-- MAGNITUDE ANALYSIS
--=========================

-- Total Customers by Country
SELECT
	country,
	COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC

-- Total Customers by Gender
SELECT
	gender,
	COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC

-- Total Products By Category
SELECT
	category,
	COUNT(product_key) AS total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC

-- Average cost in each category
SELECT
	category,
	AVG(cost) AS average_cost
FROM gold.dim_products
GROUP BY category
ORDER BY average_cost DESC

-- Total Revenue Generated for each Category
SELECT
	p.category,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC

-- Total Revenue Generated Per Customer
SELECT
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON c.customer_key = f.customer_key
GROUP BY
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_revenue DESC

-- Distribution of Sold Items across countries
SELECT
	c.country,
	SUM(f.quantity) AS total_sold_items
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON c.customer_key = f.customer_key
GROUP BY
	c.country
ORDER BY total_sold_items DESC
