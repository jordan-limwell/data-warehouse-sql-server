-- Cumulative Analysis

-- Running total of sales over time per year
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) AS running_total
FROM
(
	SELECT
		DATETRUNC(month, order_date) AS order_date,
		SUM(sales_amount) total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(month, order_date)
)t

-- Moving average of the price
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
	SELECT
		DATETRUNC(year, order_date) AS order_date,
		SUM(sales_amount) total_sales,
		AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(year, order_date)
)t
