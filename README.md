# WalMart-Sales
This project focuses on exploring Walmart sales data to identify top-performing branches and products, understand sales trends, and analyze customer behavior. The aim is to find ways to improve and optimize sales strategies for better outcomes.

# Purpose of the project
The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

# About the Data
The dataset was obtained from the kaggle website.


# Analysis List

1. **Product Analysis**
Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. **Sales Analysis**
This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

3. **Customer Analysis**
This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

# Approach Used

1. **Data Wrangling**: This is the first step where inspection of data is done to make sure NULL values
   and missing values are detected and data replacement methods are used to replace, missing or NULL values.
   
    A. Build a database
   
    B. Create table and insert the data.
   
    C. Select columns with null values in them. There are no null values in our database as in creating the tables,
       we set NOT NULL for each field, hence null values are filtered out.
   
3. **Feature Engineering**: This will help use generate some new columns from existing ones.
4. 
    A. Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
   
    B. Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the 
       day each branch is busiest.
   
    C.Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and 
      profit.
   
6. **Exploratory Data Analysis (EDA)**: Exploratory data analysis is done to answer the listed questions and aims of this project.

7. **Conclusion** :

# Questions to Answer 

**Generic Questions**

1. How many unique cities does the data has.

2. In which city is each branch located.


**Product Questions**

1. How many unique product lines does the data has.

2. Which is the most common payment method use.

3. Which the most Selling Product Line.

4. What is the Total Revenue by month .
   
5. Which month has the largest COGS.

6. Which Product line has the largest revenue.

7. Which is the city with largest revenue.

8. What is the average rating of each product line.

9. Which branch sold more product than the average product sold.

10. What is the most common product line by gender.



**Sales Questions**

1. Number of sales made in each time of the day per week day.

2. Which of the customer type bring most revenue.

3. Which city has the largest tax/VAT Percent.

4. Which customer type pays most in the VAT(Value Added Tax).

5. Rank products based on total sales within each branch.

6. Assign a row number to each record based on the order of the invoice date.

7. Top Products by sales in each branch.




**Customer Questions**

1. How many unique customer type are there in the data.

2. How many unique payment methods are there in the data.

3. Which customer type buys the most.

4. Which time of the day do customers give most ratings per branch.

5. Which week of the day has average ratings.


**CODE**

CREATE DATABASE IF NOT EXISTS WalmartSales;

USE walmartSales;

![Screenshot 2024-01-28 005802](https://github.com/Saqlainshaikh05/WalMart-Sales/assets/121796290/f0c9d0dc-64fe-4bca-9da4-8b5b437fb63a)

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
 

