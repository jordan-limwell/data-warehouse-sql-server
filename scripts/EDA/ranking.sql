-- Ranking Top-N, Bottom-N

-- 5 Products that generate the highest revenue
SELECT
*
FROM (
	SELECT
		p.product_name,
		SUM(f.sales_amount) AS total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS product_rank
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
		ON p.product_key = f.product_key
	GROUP BY p.product_name
)t
WHERE product_rank <= 5

-- 5 Products that generate the lowest revenue
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC
