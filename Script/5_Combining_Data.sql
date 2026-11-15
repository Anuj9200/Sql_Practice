------------------------------------------
------------------------------------------
/*  -------------  JOINS  -------------- */

Use mydatabase;
/* NO JOIN */
-- Q :: Retrieve all data from customers and orders in two different results
select * from customers;
select * from orders;

-- Below perform inner join but called no join beacuse here we are not using join ??
-- You can also query multiple tables without an explicit JOIN using a comma, but this creates a Cartesian product unless you add matching conditions.
SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;

/* INNER JOIN */  -- Order of table doesn't matter
select * from customers INNER JOIN orders on id = customer_id;
-- Best Practice 
select c.id, c.first_name, o.order_id, o.sales from customers as c INNER JOIN orders as o on c.id = o.customer_id;

/* LEFT JOIN */
-- Q :: get all customers along with their orders, including those wihtout order
select c.id, c.first_name, o.order_id, o.sales from customers as c LEFT JOIN orders as o on c.id = o.customer_id;

/* RIGHT JOIN */
-- Q :: get all customers along with their orders including  orders without matching customers.
select c.id, c.first_name, o.order_id, o.sales from customers as c RIGHT JOIN orders as o on c.id = o.customer_id;

-- Q :: get all customers along with their orders including  orders without matching customers.
select c.id, c.first_name, o.order_id, o.sales from orders as o LEFT JOIN customers as c on c.id = o.customer_id;

/* FULL JOIN */  -- Order of table doesn't matter :: NOT SUPPORTED IN MYSQL
/* 
No. MySQL does not directly support FULL JOIN or FULL OUTER JOIN. Your query will produce a syntax error in standard MySQL.
To achieve the same result, you can combine a LEFT JOIN with a RIGHT JOIN using UNION:
EXAMPLE BELOW
*/
-- Q :: Get all customers and all orders, even if there's no match
--  :::: ERROR ::: select c.id, c.first_name, o.order_id, o.sales from orders as o FULL JOIN customers as c on c.id = o.customer_id;
SELECT c.id, c.first_name, o.order_id, o.sales FROM customers AS c LEFT JOIN orders AS o ON c.id = o.customer_id
UNION
SELECT c.id, c.first_name, o.order_id, o.sales FROM customers AS c RIGHT JOIN orders AS o ON c.id = o.customer_id;

/* LEFT ANTI JOIN */ -- Returns Rows from Left Table that has NO MATCH in Right Table
-- Q ::  GET all customers who haven't place any order
select * from customers as c LEFT JOIN orders as o on c.id = o.customer_id where o.customer_id is NULL;

/* Right ANTI JOIN :: */ -- Returns Rows from Right Table that has NO MATCH in Left Table
-- Q :: get all orders wihout matching customers
select * from customers as c RIGHT JOIN orders as o on c.id = o.customer_id where c.id is NULL;
-- Same Query Using Left Join :: 
select * from orders as o LEFT JOIN customers as c on c.id = o.customer_id where c.id is NULL;

/* FULL ANTI JOIN */ -- Returns Only the Rows that don't match in either Table :: (AUB)- (A INTERSECTTION B)
-- ERROR :: SELECT * FROM A FULL JOIN B ON A.key = B.key WHERE A.key IS NULL OR B.key IS NULL;
/*
MySQL does not directly support FULL JOIN, so this exact query will not run in MySQL.
You can implement the same logic with a LEFT JOIN and a RIGHT JOIN combined using UNION ALL
*/
SELECT * FROM customers as c LEFT JOIN orders as o ON c.id = o.customer_id WHERE o.customer_id IS NULL
UNION ALL 
SELECT * FROM customers as c RIGHT JOIN orders as o ON c.id = o.customer_id WHERE c.id IS NULL;


-- Q : Get all customers along with their orders but only for customers who have placed an order
SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;  -- USING NOT JOIN

SELECT * FROM customers LEFT JOIN orders on customers.id = orders.customer_id  WHERE customers.id = orders.customer_id;


/* CROSS JOIN */ -- Combines Every Row from Left with Every Row from Right 
-- All Possible Cominations : Cartersian Join

-- Generate all possible cominations of customers and orders
select * from customers CROSS JOIN orders;


/* ----  JOIN MULTIPLE TABLE  ----- */
-- USING SALES DB,
use SalesDB;
select * from Customers;
select * from employees;
select * from orders;
select * from order_archive;
select * from products;

-- Q :: Retrieve a list of all orders along with the related with the related customer, and employee details. for each order, display : 
-- Order ID, Customer's name, Product, Sales, Price, Sales persons's name

select o.orderid, o.sales, c.firstname as customerFirstname, c.lastname as customer_Lastname, p.product, p.price, e.firstname as employee_Firstname, e.lastname as employee_lastname from orders as o LEFT JOIN customers as c on o.customerid = c.customerid
LEFT JOIN products as p on o.productid = p.productid
LEFT JOIN employees as e on e.employeeid = o.salespersonid;



--------------------------------------------------
--------------------------------------------------
/*  ------------- SET OPERATORS  -------------- */
use salesdb;
/* Syntax of set Operatorr */
select firstname, lastname from customers 
UNION
select firstname, lastname from employees;

-- Rule 1  of set operator :: We can use all clauses :where | JOIns | Group by | Having  
-- but Order by is allowed only once at the end of query.


-- Rule 2 : Number of Columns : The No. of columns in each query must be the same
select firstname, lastname from customers 
UNION
select firstname, lastname from employees;

-- Rule 3 :: Data types of colums in each query must be compatible
/*
In MySQL: MySQL can combine different data types in corresponding UNION columns by determining a suitable result type. It can represent integer values and text values in the same result column.
In SQL Server: SQL Server uses data type precedence to determine the result type. INT has higher precedence than VARCHAR, so SQL Server may attempt to convert firstname values to integers. If a value is 'Rahul', for example, that conversion fails.
-- Why does it work in MySQL :: 
-- MySQL handles this implicitly in your UNION query. You generally don't need to write CAST() yourself for this example.
/*
select customerid, lastname from customers 
UNION
select firstname, lastname from employees;

---------- How to fix it in SQL Server -------------
If you want to combine customer IDs and employee first names in the same output column, convert the customer IDs to text:
SELECT CAST(customerid AS CHAR(50)) AS value, lastname FROM customers
UNION
SELECT firstname AS value, lastname FROM employees;

-- Ye Rule Hain Set Operators Ka but mysql usko implicit type cast se Handle kr leta hai
-- Rule 4 : Order of Columns ::(This will work in MYSQL) : (MYsql do implicit typecast) The order of the colums in each query must be the same
select customerid, lastname from customers 
UNION
select firstname, employeeid from employees;

Rule 5 : Column Aliases :: The Column names in the result set are determied by the column names specified in the first query.
select customerid as ID, firstname as Name from customers 
UNION
select employeeid, firstname from employees;

RULE 6 :: Correct COLUMNS :: Even if all rules are met and sql shows no erros. The result may be incorrect AND Incorrect column selection leads to inaccurate results.
select firstname, lastname from customers 
UNION
select lastname, firstname from employees;


/* ------------ UNIONS ------------------ */
-- RETURNS ALL DISTINCT ROWS FROM BITH TABLES

-- Q :: Combine the data from employees and customers into one table
select Firstname, lastname from customers 
UNION
select firstname, lastname from employees;

-- SAME OUTPUT :: DOESN'T EFFECT ON OUPUT BUT ORDER OF THE RESULT MAYBE CHANGED
select firstname, lastname from employees
UNION
select Firstname, lastname from customers;



/* ------------ UNIONS ALL ------------------ */
-- RETURNS ALL ROWS FROM BOTH QUERIES, INCLUDING DUPLICATES
-- --- If your're confident there are no duplicates, always use UNION ALL 

-- Q :: Combine the data of employees and customers in one table, including duplicates.
select Firstname, lastname from customers 
UNION ALL
select firstname, lastname from employees;

/* ------------- EXCEPT (MINUS) ------------------ */
-- RETURNS UNIQUE ROWS IN 1ST TABLE THAT ARE NOT IN 2ND TABLE
select Firstname, lastname from customers
EXCEPT
select firstname, lastname from employees;

/* ------------- INTERSECT (MINUS) ------------------ */
-- RETUNS COMMON ROWS BETWEEN TWO TABLES
select Firstname, lastname from customers
INTERSECT
select firstname, lastname from employees;

------------- SET OPERATOR USE CASE ------------

-- 1 :: COMBINING SIMILAR TABLES (UNION || UNION ALL)
-- Q :: Orders data are stored in separate tables(orders and orderarchive). Combine all orders data into one report wihout dulplicates.
select * from orders 
UNION
select * from orders_archive;
-- // NEVER USE (*) , use column name 

-- 2 ::  DELTA DELETION (EXCEPT)

-- 3 :: DATA COMPLETENESS (EXCEPT) 








