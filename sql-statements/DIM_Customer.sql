-- Cleaned DIM_Customer Table --

SELECT c.customerkey AS CustomerKey
    --  ,[GeographyKey]
    --  ,[CustomerAlternateKey]
    --  ,[Title]
        ,c.firstname AS [FirstName]
    --  ,[MiddleName]
      ,[LastName]
    --  ,[NameStyle]
    --  ,[BirthDate]
    --  ,[MaritalStatus]
    --  ,[Suffix]
	,CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender
    --  ,[EmailAddress]
    --  ,[YearlyIncome]
    --  ,[TotalChildren]
    --  ,[NumberChildrenAtHome]
    --  ,[EnglishEducation]
    --  ,[SpanishEducation]
    --  ,[FrenchEducation]
    --  ,[EnglishOccupation]
    --  ,[SpanishOccupation]
    --  ,[FrenchOccupation]
    --  ,[HouseOwnerFlag]
    --  ,[NumberCarsOwned]
    --  ,[AddressLine1]
    --  ,[AddressLine2]
    --  ,[Phone]
    ,[DateFirstPurchase]
    --  ,[CommuteDistance]
	,g.city AS [Customer City] ----Joined in Customer City from Geography Table
FROM 
    dbo.dimCustomer AS c
	LEFT JOIN dbo.dimgeography AS g ON g.geographykey = c.geographykey
ORDER BY
	CustomerKey ASC --ORDER by CustomerKey