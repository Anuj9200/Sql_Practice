----- SQL FUNCTIONS ----------
-- :: Ab Built-in SQL code that accepts an inputb value processes it and returns an output value
-- Types of funtions
-- ! :: Single-Row Functions , example :: LOWER() -> 'maria'
-- ---- Type of Single row :: 1:String, 2:Numeric, 3:Date&Time , 4:NULL, 5:Case Statement
													
-- 2 :: Multi-Row Functions , exmaple :: SUM() -> sum value of multiple rows based on condition
-- ---- Type of Multi-row :: 1:Aggregate, 2:Window
		
-- Nested Functions 

use mydatabase;

/*
String Functions
Number Fucntions
Date and Time Functions
NULL Functions
Case Statement
*/

/* ---------------- 1 :: String Function ------------------*/
-- -----------------------------------------------------

-- Manipulate :: Concat, Upper, Lower, Trim, Replace
-- Calculation :: Len
-- String Extraction :: Left, Right, Substring

/*  Concat :: Combines Multilple strings into one*/
-- Q :: Show a list of customes , first name together with their country in one column.
select first_name, country, concat(first_name,'-', country) as name_country from customers;

/*  UPPER :: Converts all characters to uppercase*/
select upper(first_name) as upper_name , country, concat(first_name,'-', country) as name_country from customers;

/*  LOWER :: Converts all characters to lowercase */
select lower(first_name) as lower_name , country, concat(first_name,'-', country) as name_country from customers;

/*  TRIM ::  Removes Leading and Trailing spaces */
-- Q :: Find customers whose first name contains leading or trailing spaces
select first_name from customers where first_name != trim(first_name);

/* REPLACE ::  Replaces specific character with a new character */
-- Error ::  name_country is an alias created in the third expression. MySQL generally does not allow you to reference that alias in another expression in the same SELECT list. */
select upper(first_name) as upper_name , country, concat(first_name,'-', country) as name_country, replace(name_country,'-','@') from customers;
-- Correct Query :: Repeat the CONCAT() expression inside REPLACE():
SELECT UPPER(first_name) AS upper_name, country, CONCAT(first_name, '-', country) AS name_country,  REPLACE(CONCAT(first_name, '-', country), '-', '@') AS modified_name FROM customers;


/*  Len :: Counts how many characters */
-- Q :: Calclate the length of each customer's first name
select first_name, char_length(first_name) as length from customers;

/* Left Extraction :: Extracts specific Number of Character from the start.*/
-- Q :: Retrieve the first two characters of each first_name
select first_name, left(first_name, 2) as first_2_char from customers;
select first_name, left(trim(first_name), 2) as first_2_char from customers;  -- trim left or right extra spaces

/* Right Extraction Extracts specific Number of Character from the Last.*/
select first_name, right(first_name, 2) as last_2_char from customers;
select first_name, right(trim(first_name), 2) as last_2_char from customers;  -- trim left or right extra spaces

/* Substring :: Extracts a part of string at specified Position. Syntax :: substring(value, start, length  */ 
select first_name, substring(first_name, 3,4) as substr from customers;    -- 1-base indexing
-- Q :: Retrive a list of customers 'first_name' removing the first character
select first_name, substring(trim(first_name), 2, char_length(first_name)) as substr from customers;



-- ---------------  2 :: NUMERIC FUNCTION  ---------------------
-- -------------------------------------------------------------

/*Round :: Round the value according to number  */
select 3.516, round(3.516, 2) as round_2, round(3.516, 1) as round_1;

/*ABS :: Returns the absolute(positive) value of number, removing any negative sign*/
select -10, abs(-10), abs(10);


-- ---------------  3 :: DATE AND TIME FUNCTIONS  ---------------
-- --------------------------------------------------------------


/* Values */
-- we have three sources in order to query the date
-- 1: Date Column from a table
select orderid, orderdate, creationtime from salesdb.orders;

-- 2: Hardcoded Constant String values
select orderid, orderdate, '2025-08-23' hardcoded from salesdb.orders;

-- 3 ::  GETDATE() : Your query uses GETDATE(), which is a SQL Server function. In MySQL, use NOW() or CURRENT_TIMESTAMP().
select orderid, orderdate, now() from salesdb.orders;

/*FUNCTIONS OVERVIEW */
-- TYPES :: 
/* PART EXTRACTION :: 1: DAY , 2: MONTH, 3: YEAR, 4: DATEPART, 5: DATENAME, 6: DATETRUNC, 7: EOMONTH

/* DAY  MONTH  YEAR*/
-- day() :: returns the day from a date
-- month() :: returns the month from a date
-- year() :: returns the year from a date
select orderid, creationtime, year(creationtime), month(creationtime), day(creationtime) from salesdb.orders;

/* DATEPART() SQL Server uses DATEPART(part, date), while MySQL commonly provides individual functions such as YEAR(), HOUR(), MONTH() ETC.*/
select orderid, creationtime, year(creationtime) as year_part, quarter(creationtime) as quarter_part, month(creationtime) as month_part, week(creationtime) as week_part,  hour(creationtime) as hour_part from salesdb.orders;

/* DATENAME() : returns the name of a specific part of a date */ -- DATENAME() returns a name in SQL Server, while MySQL provides specific functions such as MONTHNAME() and DAYNAME().
select orderid, creationtime, monthname(creationtime) as month_name, dayname(creationtime) as day_name from salesdb.orders;

/* DATETRUNC :: truncates the date to the specific part */
-- resets hour, minute, second ->> 0
-- resets month, day ->> 1
-- year is highest level it will be same 

-- -- In MySQL, DATETRUNC() is not available directly. You can use DATE() for day truncation and date-time functions for minute truncation.
-- Error :: select orderid, creationtime, datetrunc(day, creationtime), datetrunc(minute, creationtime) from salesdb.orders;
SELECT orderid, creationtime,
    DATE(creationtime) AS truncated_day, DATE_FORMAT(creationtime, '%Y-%m-01') AS truncated_month,
    DATE_FORMAT(creationtime, '%Y-%m-%d %H:%i:00') AS truncated_minute FROM salesdb.orders;
/* EOMONTH(): Returns the last day of a month */ 
-- In SQL Server, EOMONTH(creationtime) returns the last date of the month. MySQL doesn't have EOMONTH(), so use LAST_DAY().  
-- select orderid , creationtime EOMONTH(creationtime) as EndOfMonth, from salesdb.orders;

SELECT orderid, creationtime, LAST_DAY(creationtime) AS EndOfMonth FROM salesdb.orders;


SELECT orderid, creationtime, CAST(DATE_FORMAT(creationtime, '%Y-%m-01') AS DATE) AS StartOfMonth, LAST_DAY(creationtime) AS EndOfMonth FROM salesdb.orders;

-- Q :: How many orders were placed in each years


-- Q :: How many orders were placed in each Month


-- 5:55 
