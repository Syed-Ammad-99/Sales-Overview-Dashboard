SELECT 
  [DateKey] AS Date, 
  [FullDateAlternateKey]
  --,[DayNumberOfWeek]
  ,[EnglishDayNameOfWeek] AS Day 
  -- ,[SpanishDayNameOfWeek]
  --,[FrenchDayNameOfWeek]
  -- ,[DayNumberOfMonth]
  -- ,[DayNumberOfYear]
  ,[WeekNumberOfYear] AS WeekNr
  ,[EnglishMonthName] AS Month
  ,LEFT([EnglishMonthName], 3) AS Month
  -- ,[SpanishMonthName]
  --  ,[FrenchMonthName]
  ,[MonthNumberOfYear] AS MonthNo
  ,[CalendarQuarter] AS Quarter
  ,[CalendarYear] AS Year
  --,[CalendarSemester]
  --,[FiscalQuarter]
  --,[FiscalYear]
  --,[FiscalSemester]
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate]
WHERE
	CalendarYear >= 2019
