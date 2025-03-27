use sell;
/*1.What is the total revenue generated from all Pizza Orders?*/
select sum(price * quantity)  as total_revenue from pizza_order;

/*2.What are the Monthly Sales trends for Dominos pizzas?*/
select monthname(order_date) as month_name,
	sum(price * quantity)  
	as sales from pizza_order 
	group by month_name;

/*3.Which Week of Month had highest Sales?(Weekly Sales Trend)*/
select WEEK(order_date, 3) - WEEK(DATE_SUB(order_date, INTERVAL DAY(order_date) - 1 DAY), 3) + 1
	as week_of_month,
	sum(price * quantity)  
	as sales from pizza_order 
	group by week_of_month;

/*4.What is peak order time during the day?*/
select hour(order_time) as HOURS,
	count(pizza_id) 
	as orders from pizza_order 
	group by HOURS order by HOURS;

/*5.What is the Distribution of orders across different Hours of Day?*/
select hour(order_time) as HOURS,
	sum(price * quantity)  
	as sales from pizza_order 
	group by HOURS order by sales;
	\
/*6. Which days of week has Highest Sales and Lowest Sales?*/
select dayofweek(order_date) as DAYS_OF_WEEK,
	sum(price * quantity)  
	as sales from pizza_order 
	group by DAYS_OF_WEEK order by DAYS_OF_WEEK;

/*7.Are any Seasonal trends in pizza sales?(weekdays or weekends)*/
with cte1 as(
				select dayofweek(order_date) as DAYS_OF_WEEK,
				pizza_id from pizza_order
			)
select case when DAYS_OF_WEEK IN (1,7) then "weekend" 
	else "weekday" end as day_type,
	count(pizza_id) as orders from cte1 
    group by day_type;

/*8. What are top 5 best-selling pizzas based on orders?*/
select pizza_name,count(pizza_name) as quantity 
	from pizza_order group by pizza_name 
    order by quantity desc limit 5;

/*9.Which size of Pizza had most ordered?*/
SELECT DISTINCT
    SUBSTRING_INDEX(pizza_name_id, '_', -1) AS size,
    count(pizza_id) as orders
	FROM pizza_order group by size;
	
/*10.Which Pizza Category generates the most Revenue?*/
select pizza_category,sum(price * quantity) as sales
	from pizza_order group by pizza_category;