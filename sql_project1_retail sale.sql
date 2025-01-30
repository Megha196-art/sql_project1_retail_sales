-- retail sales project
CREATE DATABASE sql_project1;

-- import dummy table
SELECT * FROM retail_sales;

-- counting the number of rows
SELECT
      COUNT(*)
FROM retail_sales;

-- Data cleaning
-- finding null values in the dataset
SELECT * FROM retail_sales
WHERE 
	 transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL
     OR
     category IS NULL
     OR
     quantity IS NULL
     OR
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR
     total_sale IS NULL;
     
-- deleting null values
DELETE FROM retail_sales
WHERE 
	 transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL
     OR
     category IS NULL
     OR
     quantity IS NULL
     OR
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR
     total_sale IS NULL;
     
-- Data exploration

-- Q1. No. of sales
SELECT COUNT(*) as total_sale FROM retail_sales;  -- 1987

-- Q2. No. of unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;  -- 155

-- Q3. No. of unique categories and what are they
SELECT DISTINCT category FROM retail_sales; -- 3 (Beauty, Clothing & Electronics)




-- Data analysis and key business problems and answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND sale_date BETWEEN '2022-01-11' AND '2022-30-11'
AND quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) amnd no. of orders for each category
SELECT category,
       SUM(total_sale) as net_sale,
       COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT AVG(age) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find the average age of customers across categories
SELECT category, AVG(age) as avg_age
FROM retail_sales
GROUP BY category;

-- Q.6 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.7 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
      category,
      gender,
      COUNT(*) as toatl_trans
FROM retail_sales
GROUP BY
       category,
       gender
ORDER BY 1;

-- Q.8 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
      year,
      month,
      avg_sale
FROM
(
SELECT
     YEAR(sale_date) as year,
     MONTH(sale_date) as month,
     AVG(total_sale) as avg_sale,
     RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as 'rank'
FROM retail_sales
GROUP BY 1, 2
)
where 'rank' = 1;

-- Q.9 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
      customer_id,
      SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.10 Write a SQL query to find the number of unique customers who purchased items from each category
SELECT 
      category,
      COUNT(DISTINCT customer_id) as unique_cust
FROM retail_sales
GROUP BY category;

-- Q.11 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
      CASE
          WHEN HOUR(sale_time) < 12 THEN 'Morning'
          WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
          ELSE 'Evening'
      END as shift	
FROM retail_sales
)
SELECT 
	  shift,
      COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;

-- End of project
       









