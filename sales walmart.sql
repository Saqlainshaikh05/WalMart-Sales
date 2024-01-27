CREATE DATABASE IF NOT EXISTS WalmartSales;

USE walmartSales;

CREATE TABLE IF NOT EXISTS sales(
 Invoice_id VARCHAR(50) PRIMARY KEY,
 Branch VARCHAR(5) NOT NULL,
 City VARCHAR(30) NOT NULL,
 Customer_Type VARCHAR(30) NOT NULL,
 Gender VARCHAR(10),
 Product_line VARCHAR(150) NOT NULL,
 Unit_price DECIMAL(10,2) NOT NULL,
 Quantity INT NOT NULL,
 VAT FLOAT(6,4) NOT NULL,
 Total DECIMAL(12,4),
 Date DATETIME,
 Time TIME ,
 Payment_Method VARCHAR(25) NOT NULL,
 Cogs DECIMAL(10,2) NOT NULL,
 Gross_Margin_pct FLOAT(11,9),
 Gross_Income DECIMAL(12,4) NOT NULL,
 Rating FLOAT(2,1)
 );
 
-- -------------------------------------------------------------------------------------------------------------
-- --Feature Engineering -------------------------------------------------------------------

-- time_of_day --
SELECT time,
       (CASE 
            WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN time BETWEEN "12:00:01" AND "16:00:00" THEN "Afternoon"
            ELSE "Evening"
		END
		) AS time_of_date
from sales;
 
 
ALTER TABLE sales
ADD COLUMN time_of_day varchar(30);

update sales
set  time_of_day = (CASE
                        WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
                        WHEN time BETWEEN "12:00:01" AND "16:00:00" THEN "Afternoon"
                        ELSE "Evening"
					END);
-- DAY--------------------------------------------------------------------------------------
SELECT DATE ,DAYNAME(DATE) as day
FROM sales;

ALTER TABLE SALES 
ADD COLUMN Day VARCHAR(10);

UPDATE SALES
SET DAY = DAYNAME(DATE);

-- MONTH NAME--------------------------------------------------------------------------------
SELECT DATE, MONTHNAME(DATE) AS MONTH
FROM SALES;

ALTER TABLE SALES
ADD COLUMN MONTH_NAME VARCHAR(20);

UPDATE SALES 
SET MONTH_NAME = MONTHNAME(DATE);
-- --------------------------------------------------------------------------------------------
-- GENERIC QUESTIONS -----------------------------------------------------------------------

-- Q1 HOW MANY UNIQUE CITITES DOES THE DATA HAVE --------------------------------------------
SELECT DISTINCT(CITY)
FROM SALES;

-- Q2 IN WHICH CITY IS EACH BRANCH LOCATED-----------------------------------------------------------
SELECT DISTINCT CITY,BRANCH
FROM SALES;


-- PRODUCT QUESTIONS -------------------------------------------------------------------------
-- HOW MANY UNIQUE PRODUCT LINES DOES THE DATA HAVE ---------------------------------------
SELECT COUNT(DISTINCT(PRODUCT_LINE)) AS COUNT
FROM SALES;


-- WHICH IS THE MOST COMMON PAYMENT METHOD USED ----------------------------------------------
SELECT PAYMENT_METHOD,COUNT(PAYMENT_METHOD) AS COUNT_OF_PAYMENT_METHOD
FROM SALES
GROUP BY PAYMENT_METHOD
ORDER BY COUNT_OF_PAYMENT_METHOD DESC;

-- WHICH IS THE MOST SELLING PRODUCT LINE ------------------------------------------------
SELECT PRODUCT_LINE,COUNT(PRODUCT_LINE) AS COUNTS
FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY COUNTS DESC;

-- WHAT IS THE TOTAL REVENUE BY MONTH ------------------------------------------------------
SELECT MONTH_NAME,ROUND(SUM(TOTAL),2) AS TOTAL_REVENUE
FROM SALES
GROUP BY MONTH_NAME
ORDER BY TOTAL_REVENUE;

-- WHICH MONTH HAS THE LARGEST COGS----------------------------------------------------------
SELECT MONTH_NAME,ROUND(SUM(COGS),2) AS COGS
FROM SALES
GROUP BY MONTH_NAME 
ORDER BY COGS DESC;

-- WHICH PRODUCT LINE HAS THE LARGEST REVENUE------------------------------------------------
SELECT PRODUCT_LINE,ROUND(SUM(TOTAL),2) AS REVENUE
FROM SALES
GROUP BY PRODUCT_LINE
ORDER BY REVENUE DESC;

-- WHICH IS THE CITY WITH THE LARGEST REVENUE --------------------------------------------
SELECT BRANCH,CITY,ROUND(SUM(TOTAL),2) AS REVENUE
FROM SALES
GROUP BY BRANCH,CITY
ORDER BY REVENUE DESC;


-- WHAT IS THE AVERAGE RATING OF EACH PRODUCT LINE-----------------------------------------
SELECT PRODUCT_LINE,ROUND(AVG(RATING),1) AS AVERAGE_RATING
FROM SALES
GROUP BY PRODUCT_LINE;

-- WHICH BRANCH SOLD MORE PRODUCT THAN THE AVERAGE PRODUCT SOLD-------------------------------
SELECT BRANCH,SUM(QUANTITY) AS QUANTITY
FROM SALES
GROUP BY BRANCH
HAVING QUANTITY > (SELECT AVG(QUANTITY) FROM SALES);

-- WHAT IS THE MOST COMMON PRODUCT LINE BY GENDER -------------------------------------------------
SELECT GENDER,PRODUCT_LINE,
       COUNT(GENDER) AS TOTAL_CNT
FROM SALES
GROUP BY GENDER,PRODUCT_LINE
ORDER BY TOTAL_CNT DESC;
-- -----------------------------------------------------------------------------------------------
-- ----------------------------SALES -------------------------------------------------------------


-- NUMBER OF SALES MADE IN EACH TIME OF THE DAY PER WEEKDAY
SELECT TIME_OF_DAY,
	   COUNT(*) AS TOTAL_SALES
FROM SALES
WHERE DAY = "MONDAY"
GROUP BY TIME_OF_DAY;

-- WHICH OF THE CUSTOMER TYPES BRING MOST REVENUE.------------------------------------
SELECT CUSTOMER_TYPE,
	   ROUND(SUM(TOTAL),2) AS REVENUE
FROM SALES
GROUP BY CUSTOMER_TYPE;

-- WHICH CITY HAS THE LARGEST TAX PERCENT/VAT
SELECT CITY,MAX(VAT) AS MAX_VAT
FROM SALES
GROUP BY CITY
ORDER BY MAX_VAT DESC;


-- WHICH CUSTOMER TYPE PAYS THE MOST IN VAT(VALUE ADDED TAX)-----------------------------------
SELECT CUSTOMER_TYPE,MAX(VAT)
FROM SALES
GROUP BY CUSTOMER_TYPE;

-- RANK PRODUCTS BASED ON TOTAL SALES WITHIN EACH BRANCH---------------------------------------------
SELECT
  Branch,
  Product_line,
  Total,
  RANK() OVER (PARTITION BY Branch ORDER BY Total DESC) AS Sales_Rank
FROM sales;


-- ASSIGN A ROW NUMBER TO EACH RECORD BASED ON THE ORDER OF THE INVOICE DATE ------------------------
SELECT *,
ROW_NUMBER() OVER(ORDER BY DATE) AS ROW_NUM
FROM SALES;

-- TOP PRODUCTS BY SALES IN EACH BRANCH -------------------------------------------------------------
SELECT BRANCH, PRODUCT_LINE,TOTAL,
       DENSE_RANK() OVER(PARTITION BY BRANCH ORDER BY TOTAL DESC) AS DENSE_RNK
FROM SALES;

-- ---------------------------------------------------------------------------------------------
-- ---------------------------CUSTOMERS------------------------------------------------------------

-- HOW MANY UNIQUE CUSTOMER TYPE DOES THE DATA HAVE -----------------------------------------

SELECT DISTINCT CUSTOMER_TYPE
FROM SALES;


-- HOW MANY UNIQUE PAYMENT METHODS ARE THERE IN THE DATA ----------------------------------------
SELECT DISTINCT PAYMENT_METHOD
FROM SALES;

-- WHICH CUSTOMER TYPE BUYS THE MOST ----------------------------------------------------------
SELECT CUSTOMER_TYPE,
       COUNT(*) AS COUNT
FROM SALES
GROUP BY CUSTOMER_TYPE
ORDER BY COUNT DESC;

-- WHICH TIME OF THE DAY DO CUSTOMERS GIVE MOST RATINGS PER BRANCH -------------------------------
SELECT TIME_OF_DAY,
	   AVG(RATING) AS AVG_RATING
FROM SALES
WHERE BRANCH IN ("A","B","C")
GROUP BY TIME_OF_DAY
ORDER BY AVG_RATING; 

-- WHICH WEEK OF THE DAY HAS THE AVERAGE RATINGS ----------------------------------------------
SELECT DAY,AVG(RATING) AS AVG_RATINGS
FROM SALES
GROUP BY DAY
ORDER BY AVG_RATINGS DESC;


-- ---------------------------------------------------------------------------------------------


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 