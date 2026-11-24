-- ******************************************************************************
-- ******************************************************************************
/* ---------------- 4 : NULL FUNCTIONS ------------------*/
-- ******************************************************************************
-- ******************************************************************************

/* NULL means ::NULL means nothing , unknown! */
/*NULL is not equal to anything*/
/* NULL is not zero    NULL is not empty string    NULL is not blank space    */

/*1 :: ISNULL() :: Replaces 'NULL' with a specified value   ::  SYNTAX :: ISNULL(value, replacement_value)
-- MYSQL SYNTAX : IFNULL 

/* COALESCE :: Returns the first non-null value from a list  :: SYNTAX :: COALESCE(value1, value2, value3, ...) */



-- ******************************************************************************
-- ******************************************************************************
-- HANDLE NULL 
-- 1 :: Aggregation 
-- We have to handle null before doing aggregation

-- Q :: Find the average scores of the customers
select customerid, score, coalesce(score, 0) as score2,
avg(score) over() AvgScores, 				-- Without Handle NULL
avg(coalesce(score,0)) over() AvgScores2 	-- Handle NULL
from salesdb.customers;

-- 2 :: MATHEMATICAL OPERATION 
-- We Handle the NULL before doing amathematical operations
-- Q:: Display the full name of customers in a single field by merging their first name and last names and add 10 bonus points to each customers's score
select customerid, firstname, lastname, concat(firstname, ' ', lastname), concat(firstname, ' ', coalesce(lastname, 0)) as nameafterhandleNULL, score, coalesce(score, 0) + 10 as scorewithbonus from salesdb.customers;

-- 3 :: JOINS
-- Handle the NULL before JOINING tables
-- 7:27:00

-- 4 :: SORTING DATA
-- Handle the NULL before sorting data
-- Sort the customers from lowest to highest scores with NULLs appearing last
select customerid, score from salesdb.customers ORDER BY Case when isnull(score) then 1 else 0 end, score;
SELECT customerid, score FROM salesdb.customers ORDER BY score IS NULL, score ASC;
-- BOth Query are Same , MYSQL Support Both :: ISNULL() and IS NUll 


/* 2 :: NULLIF() :: Compare two expressions returns - NULL,if they are equal OR return first value, if they are not equal  :: SYNTAX :: NULLIF(value1, value2) */ 

-- Q :: Find the sales price for each order by dividing sales by quantity
-- SQL Server: Division by zero generally raises an error under the usual settings.
-- mysql server :: SELECT orderid, sales, quantity, sales / NULLIF(quantity, 0) AS price FROM salesdb.orders;
-- MySQL: Division by zero generally returns NULL with a warning in a normal SELECT.
select orderid, sales, quantity, sales/quantity as price from salesdb.orders;


/* 3 :: IS NULL :: Returns TRUE if the value is NULL  */


/* 4 :: IS NOT NULL :: Returns TRUE if the value is NOT NULL */


-- IS NULL, USE CASE :: FILTERING DATA

-- Q :: Identify the customers who have no scores
select * from salesdb.customers where score IS NULL;

-- Q :: List all customers who have scores
select * from salesdb.customers where score IS NOT NULL;

-- IS NULL, USE CASE :: ANTI JOINS
select c.*, o.orderid from salesdb.customers c LEFT JOIN salesdb.orders as o ON c.customerid = o.customerid where o.customerid IS NULL;


-- NULL VS EMPTY  VS SPACE
-- Null :: means nothing , unknown! in simple word :: unknown
-- Empty :: String value has zero character. in simple word :: known, empty value or string
-- Space :: String value has one or more space characters. in simple word :: known, space value

-- DATA POLICY :: 
  
-- Q :: WHICH POLICY IS GOOD


-- ******************************************************************************
-- ******************************************************************************
/* ---------------- 5 : CASE STATEMENT ------------------*/
-- Evaluate a list  of conditions and returns a value when the first condition is met 
-- ******************************************************************************
-- SYNTAX :: CASE 
-- 				   WHEN CONDITION1 THEN RESULT1 
--                 WHEN CONDITION2 THEN RESULT2 
--                 ... 
--                 ELSE RESULT 
-- 			  END 

-- USECASE ::

-- 1 :: CATAGORIZING DATA :: Group the data into different categories based on certain conditions

-- Q :: Generate a report showing the total sales for each category.
-- (high:if sales>50  , mediuim:if 50>sales>20 ,  low:if sales<20)
-- Sort the result from the lowest to highest
select Category, sum(sales) as totalsales from
(select orderid, sales, 
Case WHEN sales>50 THEN 'High' WHEN sales>20 THEN 'Medium' ELSE 'Low' END as Category
from salesdb.orders) as t Group by category order by totalsales desc;

-- 2 :: MAPPING :: Tranform the values from one form to another
-- Retrive employee details with gender displayed as full text
select employeeid, firstname, lastname, gender, CASE WHEN gender='M' THEN 'Male' WHEN gender='F' THEN 'Female' ELSE 'Not Available' END AS GENDERFULLTEXT from salesdb.employees;

-- Retrieve cutomer details with abbreviated country code
select customerid, firstname, lastname, country, CASE WHEN Country = "Germany" THEN 'DE' WHEN Country = 'USA' THEN 'US' ELSE 'N/A' END AS CountryAbb from salesdb.customers;

-- **QUICK FORMAT :: Used when comparing one expression against multiple values.
-- Instead of this :: CASE WHEN condition1 THEN result1 WHEN condition2 THEN result2 WHEN condition3 THEN result3 ELSE default_result END AS alias_name
-- SELECT sales, CASE WHEN sales > 50 THEN 'High' WHEN sales > 20 THEN 'Medium' ELSE 'Low' END AS Category FROM salesdb.orders;

-- 3: HANDLING NULLS :: REPLACE NULLS WITH SPECIFIC VALUE

-- Q:: 


-- 4: CONDITIONAL AGGREGATION :: Apply aggregate functions only on subsets of data that fulfill certain conditions
-- Q :: Count how many times each customer has made an order with sales greater than 30













