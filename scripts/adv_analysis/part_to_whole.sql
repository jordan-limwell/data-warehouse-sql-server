-- Part-to-whole Analysis
WITH category_sales AS (
	SELECT
		category,
		SUM(sales_amount) as total_sales
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
		ON p.product_key = s.product_key
	GROUP BY category
)

SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER () overall_total,
	CONCAT(ROUND((CAST (total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2), '%') AS percent_of_total
FROM category_sales
ORDER BY total_sales DESC
