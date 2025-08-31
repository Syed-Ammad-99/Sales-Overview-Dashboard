SELECT
	   p.[ProductKey]
      ,p.[ProductAlternateKey] AS ProductItemCode
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode]
      ,p.[EnglishProductName] AS [Product Name],
	  ps.SpanishProductSubcategoryName AS [Sub Category], --Join in from sub category table
	  pc.EnglishProductCategoryName AS [Product Category]--Join in from category table
      --,[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
      ,p.[Color] AS [Product Color]
      --,[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
      ,p.[Size] AS [Product Size]
      --,[SizeRange]
      --,[Weight]
      --,[DaysToManufacture]
      ,p.[ProductLine] AS [Product Line]
      --,[DealerPrice]
      --,[Class]
      --,[Style]
      ,p.[ModelName] AS [Product Model Name]
      --,[LargePhoto]
      ,p.[EnglishDescription]	AS [[English Description]
      --,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      --,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
      ,ISNULL (p.Status, 'Outdate') AS [Product Status]
  FROM [AdventureWorksDW2019].[dbo].[DimProduct] AS p
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey	= p.ProductSubcategoryKey
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY
p.ProductKey ASC
