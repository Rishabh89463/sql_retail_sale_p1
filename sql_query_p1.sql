-- Create Table
CREATE TABLE retail_sale
       ( 
                transactions_id	int primary KEY,
                sale_date	DATE,
                sale_time	TIME,
                customer_id	INT,
                gender	VARCHAR(15),
                age	   INT,
                category	VARCHAR(15),
                quantiy    INT,
                price_per_unit  FLOAT,	
				cogs	FLOAT,
				total_sale  FLOAT
		);  

select count(*) from retail_sale;	


select * from retail_sale
where 
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or 
    gender is null
    or
    age is null
    or 
    category is null
    or 
    quantiy is null
    or
    price_per_unit is null
    or 
    cogs is null
    or 
    total_sale is null;

-- Data Cleaning

Delete from retail_sale
where 
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or 
    gender is null
    or
    age is null
    or 
    category is null
    or 
    quantiy is null
    or
    price_per_unit is null
    or 
    cogs is null
    or 
    total_sale is null;

-- Data Exploration

-- How many sales we have?

select count(*) as total_sales from retail_sale;

-- How many unique customer we have?

select count(distinct (customer_id)) from retail_sale;

-- Data Analysis & Business key problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from retail_sale
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select *
from retail_sale
where 
     category = 'Clothing' 
	 And 
	 To_char(sale_date, 'yyyy-mm') = '2022-11'
	 And 
	 quantiy >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
     category,
	 sum(total_sale) as net_sale
from retail_sale
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
     round(avg(age),2) as avg_age
from retail_sale
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from retail_sale
where total_sale >1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
     count(transactions_id) as total_transactions,
	 category,
	 gender
from retail_sale
group by category,gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
	 

select 
     Extract(YEAR from sale_date) as Year,
	 Extract(MONTH from sale_date) as Month,
	 avg(total_sale) as avg_sale
from retail_sale
group by 1,2
ORDER BY 1,3 DESC
LIMIT 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
     distinct(customer_id),
	 sum(total_sale) as highest_sale
from retail_sale
Group by 1
order by 2 desc
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
     count(distinct(customer_id)),
	 category
from retail_sale
group by category;	 


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sale
as
(
SELECT *,  
    CASE
	    when Extract(Hour from sale_time) < 12 then 'Morning'
		when Extract(Hour from sale_time) Between 12 and 17 then 'AfternooN'
		else 'evening'
    END AS shift	
from retail_sale	 
)
select 
     shift,
	 COUNT(*) as total_orders
from hourly_sale
group by shift

-- End of project