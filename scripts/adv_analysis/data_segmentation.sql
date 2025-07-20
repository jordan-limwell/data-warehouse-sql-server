-- Data Segmentation Analysis
WITH customer_spending AS (
	SELECT
		c.customer_key,
		SUM(s.sales_amount) total_spent,
		MIN(s.order_date) first_order,
		MAX(s.order_date) last_order,
		DATEDIFF(month, MIN(s.order_date), MAX(s.order_date)) AS lifespan
	FROM gold.dim_customers c
	LEFT JOIN gold.fact_sales s
		ON c.customer_key = s.customer_key
	GROUP BY c.customer_key
)

SELECT
	customer_segments,
	COUNT(customer_key) AS number_of_customers
FROM (
	SELECT
		customer_key,
		CASE WHEN lifespan >= 12 AND total_spent > 5000 THEN 'VIP'
			 WHEN lifespan >= 12 AND total_spent <= 5000 THEN 'Regular'
			 ELSE 'New'
		END AS customer_segments
	FROM customer_spending
)t
GROUP BY customer_segments
ORDER BY COUNT(customer_key) DESC
	
