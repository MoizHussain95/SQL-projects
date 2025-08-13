----FIRST SQL PROJECT

---checking for null values 
select*from retail_store
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantiy is null
or 
cogs is null
or
total_sale is null;

--cleaning null values 
Delete from retail_store
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantiy is null
or 
cogs is null
or
total_sale is null;

---how many sales we have 
select count(transactions_id) from retail_store

---how many unique customer we have
select count(Distinct customer_id) from retail_store

--how many type of category we have 
select count(Distinct category) from retail_store

--DATA ANALYSIS
--q1) sales done on '2022-11-05'
select*from retail_store
where sale_date ='2022-11-05';   

--q2)write a query to retreive all tarnsactions where category is cloting and the quantity sold more or equal to4 in month ov november 2022
select*from retail_store
where
category ='Clothing'
AND
TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND
quantiy >=4

--q3)write a sql querry to calculate total sale of each category
select category, SUM(total_sale) as total_sale,
count(*) as total_orders
from retail_store
group by category

--q4) write a query to find the avg age  of persons who buy from "beauty" category
select 
 round(avg(age),2 )avg_age
 from retail_store
where category='Beauty'

---q5)write a query to find all the transactions where total sales is grater than 1000
select *from retail_store 
where total_sale >=1000

--q6) write a sql querry to find the total number of transaction(transaction_id)made by each gender in each category
select
category ,gender,
count(*) as total_transactions
from retail_store
group by category ,gender
order by 1

--q7) write a querry to calculate the avg sale for each month.find out the best selling month of year
select*from
(select 
extract (YEAR FROM sale_date) as year,
extract (MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale,
RANK()OVER (PARTITION BY extract(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
from retail_store
group by 1,2
)
where rank =1

--q8)write a querry to select the top 5 customer based on total sale 
select customer_id,
sum(total_sale)
from retail_store
group by customer_id 
order by 2 DESC
LIMIT 5

--q9)write a sql querry to find out unique customer who bought from each category
select 
category,
count(DISTINCT customer_id)
from retail_store
group by 1

--q10)write a sql querry to create each shift and no of orders(example morning <12,afternoon b/w 12 &17,evening>17 )
with hourly_sale
AS
(select*,
case 
when extract(HOUR FROM sale_time) <12 then 'Morning'
when extract(HOUR FROM sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shifts
from retail_store)
select shifts,
count(*) 
from hourly_sale 
group by shifts

---END



