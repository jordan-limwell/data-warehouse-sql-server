CREATE VIEW gold.product_reports AS
WITH base_query AS (
	-- Collects core columns from the base table
	SELECT
		f.order_number,
		f.order_date,
		f.customer_key,
		f.sales_amount,
		f.quantity,
		p.product_key,
		p.product_name,
		p.category,
		p.sub_category,
		p.cost
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
		ON f.product_key = p.product_key
	WHERE order_date IS NOT NULL -- consider only valid sales date
)
, product_aggregation AS (
	SELECT
	-- Summarizes key metrics at the product level
		product_key,
		product_name,
		category,
		sub_category,
		cost,
		DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
		MAX(order_date) AS latest_sale,
		COUNT(DISTINCT order_number) AS total_orders,
		COUNT(DISTINCT customer_key) AS total_customers,
		SUM(sales_amount) AS total_sales,
		SUM(quantity) AS total_quantity,
		ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
	FROM base_query
	GROUP BY
		product_key,
		product_name,
		category,
		sub_category,
		cost
)

SELECT 
	product_key,
	product_name,
	category,
	sub_category,
	cost,
	latest_sale,
	DATEDIFF(MONTH, latest_sale, GETDATE()) AS racency_in_months,
	CASE
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >- 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	-- Average Order Revenue (AOR)
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue,

	-- Average Monthly Revenue
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregation
