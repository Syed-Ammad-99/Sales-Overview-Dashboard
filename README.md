# Sales-Overview-Dashboard

![excel-sql-power bi](dashboard%20img.png)


## Table of contents 

- [Objective](#objective)
- [Data Source](#data-source)
- [Stages](#stages)
- [Requirement](#requirement)
  - [Dashboard](#dashboard)
  - [Tools](#tools)
- [Development](#development)
  - [Pseudocode](#pseudocode)
  - [Data Transformation](#data-transformation)
  - [Transform the Data](#transform-the-data)
  - [Potential ROI](#potential-roi)
  - [Potential Courses of Actions](#potential-courses-of-actions)
- [Conclusion](#conclusion)


# Objective 

- What is the key pain point? 

The Sales Manager said they need to improve internet sales reports and want to move from static reports to visual dashboards.

- What is the ideal solution? 

To create a dashboard that provides insights that includes their 
- Want to focus it on how much we have sold of what products, to which clients and how it has been over time.
- Seeing as each sales person works on different products and customers it would be beneficial to be able to filter them also.
- Measure our numbers against budget so I added that in a spreadsheet so we can compare our values against performance. 
- The budget is for 2021 and we usually look 2 years back in time when we do analysis of sales.

This will help the sales team make informed decisions.

## User story 

-	Reporter: Steven – Sales Manager
-	Value of Change: Visual dashboards and improved Sales reporting or follow up or sales force

| No # | As a (role) | I want (request / demand) | So that I (user value) | Acceptance Criteria |
| --- | --- | --- | --- | --- |
| 1 | Sales Manager | To get a dashboard overview of internet sales | Can follow better which customers and products sells the best | A Power BI dashboard which updates data once a day |
| 2 | Sales Representative | A detailed overview of Internet Sales per Customers | Can follow up my customers that buys the most and who we can sell ore to | A Power BI dashboard which allows me to filter data for each customer |
| 3 | Sales Representative | A detailed overview of Internet Sales per Products | Can follow up my Products that sells the most | A Power BI dashboard which allows me to filter data for each Product |
| 4 | Sales Manager | A dashboard overview of internet sales| Follow sales over time against budget | A Power Bi dashboard with graphs and KPIs comparing against budget.|


## Data source 

The AdventureWorks databases are sample databases that were originally published by Microsoft to show how to design a SQL Server database using SQL Server 2008. AdventureWorks is the OLTP sample, and AdventureWorksDW is the data warehouse sample.

- What data is needed to achieve our objective?
- Sales by Product Category
- Sales by Top 10 Customers / Products / Customers City
- Budget Amount and Sales by Month
- Filter visuals by City, Product Name and Sub-Category


- Where is the data coming from? 
The data of budgets have been delivered in Excel for 2021, [see here to find it.](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms)

## Stages

- Requirement
- Development
- Testing
- Analysis 

## Requirement 

### Dashboard components required 
- What should the dashboard contain based on the requirements provided?

To understand what it should contain, we need to figure out what questions we need the dashboard to answer:

1. What is the sales distribution between product category?
2. Who are the top buyer?
3. Which are the top product?
4. Month by month comparison of budget amount vs sales?
5. Map view of customer density in a specific geographic area, which plays a crucial role in shaping business strategies and operational efficiency?

For now, these are some of the questions we need to answer, this may change as we progress down our analysis. 

### Dashboard

- What should it look like? 

Some of the data visuals that may be appropriate in answering our questions include:

1. Donut chart
2. Sracked bar chart
3. Line chart
4. Map visual
5. Silcer

### Tools 

| Tool | Purpose |
| --- | --- |
| Excel | Exploring the data |
| SQL Server | Transformation, testing, and analyzing the data |
| Power BI | Visualizing the data via interactive dashboards |
| GitHub | Hosting the project documentation and version control |

## Development

### Pseudocode

- What's the general approach in creating this solution from start to finish?

1. Get the data
2. Explore the data in Excel
3. Load the data into SQL Server
4. Data transformation the data with SQL
5. Test the data with SQL
6. Visualize the data in Power BI
7. Generate the findings based on the insights

### Data Transformation 
- What do we expect the data transformation? (What should it contain? What contraints should we apply to it?)

The aim is to refine our dataset to ensure it is structured and ready for analysis. 

The transformation process will extract data from AdventureWorks sample databases and create separate table a per need:

- Only relevant columns should be retained in the form of table.
- All data types should be appropriate for the contents of each column.
- Using sql command to extract data and alias it for better understanding.

#### Transform the data 

- DIM
```sql
SELECT
	   p.[ProductKey]
      ,p.[ProductAlternateKey] AS ProductItemCode
      ,p.[EnglishProductName] AS [Product Name],
	  ps.SpanishProductSubcategoryName AS [Sub Category], --Join in from sub category table
	  pc.EnglishProductCategoryName AS [Product Category]--Join in from category table
      ,p.[Color] AS [Product Color]
      ,p.[Size] AS [Product Size]
      ,p.[ProductLine] AS [Product Line]
      ,p.[ModelName] AS [Product Model Name]
      ,p.[EnglishDescription]	AS [[English Description]
      ,ISNULL (p.Status, 'Outdate') AS [Product Status]
  FROM [AdventureWorksDW2019].[dbo].[DimProduct] AS p
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey	= p.ProductSubcategoryKey
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY
p.ProductKey ASC
```
- DIM_Calender

```sql
SELECT 
  [DateKey] AS Date, 
  [FullDateAlternateKey]
  ,[EnglishDayNameOfWeek] AS Day 
  ,[WeekNumberOfYear] AS WeekNr
  ,[EnglishMonthName] AS Month
  ,LEFT([EnglishMonthName], 3) AS Month
  ,[MonthNumberOfYear] AS MonthNo
  ,[CalendarQuarter] AS Quarter
  ,[CalendarYear] AS Year
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate]
WHERE
	CalendarYear >= 2019
```

- DIM_Customer

```sql
-- Cleaned DIM_Customer Table --

SELECT c.customerkey AS CustomerKey
        ,c.firstname AS [FirstName]
      ,[LastName]
	,CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender
    ,[DateFirstPurchase]
	,g.city AS [Customer City] ----Joined in Customer City from Geography Table
FROM 
    dbo.dimCustomer AS c
	LEFT JOIN dbo.dimgeography AS g ON g.geographykey = c.geographykey
ORDER BY
	CustomerKey ASC --ORDER by CustomerKey```
```
- DIM_Product

```sql

SELECT
	   p.[ProductKey]
      ,p.[ProductAlternateKey] AS ProductItemCode
      ,p.[EnglishProductName] AS [Product Name],
	  ps.SpanishProductSubcategoryName AS [Sub Category], --Join in from sub category table
	  pc.EnglishProductCategoryName AS [Product Category]--Join in from category table
      ,p.[Color] AS [Product Color]
      ,p.[Size] AS [Product Size]
      ,p.[ProductLine] AS [Product Line]
      ,p.[ModelName] AS [Product Model Name]
      --,[LargePhoto]
      ,p.[EnglishDescription]	AS [[English Description]
      ,ISNULL (p.Status, 'Outdate') AS [Product Status]
  FROM [AdventureWorksDW2019].[dbo].[DimProduct] AS p
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey	= p.ProductSubcategoryKey
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY
p.ProductKey ASC

```
FACT_InternetSales

```sql
SELECT [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
      ,[SalesOrderNumber]
      ,[SalesAmount]

  FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE
	LEFT (OrderDateKey,4) = YEAR('2019') --Ensure we always only brings two years of date from extraction.
ORDER BY
 OrderDateKey ASC
```

# Analysis 

## Findings

- What did we find?
