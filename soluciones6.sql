SELECT [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,p.[AccountNumber]
      --,[CustomerID]
	  , cp.FirstName + ' ' + cp.LastName Cliente
      --,[SalesPersonID]
	  , v.FirstName + ' ' + v.LastName Vendedor
      --,p.[TerritoryID]
	  ,z.Name
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      --,p.[CreditCardID]
	  ,t.CardType + ' ' + t.CardNumber CreditCard
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
      ,p.[rowguid]
      ,p.[ModifiedDate]
  FROM Sales.SalesOrderHeader p
	inner join Sales.Customer c on p.CustomerID = c.CustomerID
	inner join Person.Person cp on c.PersonID = cp.BusinessEntityID
	left join Person.Person v on p.SalesPersonID = v.BusinessEntityID
	left join Sales.SalesTerritory z on p.TerritoryID = z.TerritoryID
	left join Sales.CreditCard t on p.CreditCardID = t.CreditCardID


SELECT isnull(c.Name, '(Sin categoría)') Categoría, isnull(sc.Name, '(Sin sub categoría)') [Sub Categoría], p.Name Producto
FROM Production.ProductCategory AS c 
	INNER JOIN Production.ProductSubcategory AS sc ON c.ProductCategoryID = sc.ProductCategoryID 
	right JOIN Production.Product AS p ON sc.ProductSubcategoryID = p.ProductSubcategoryID
order by Categoría, [Sub Categoría], Producto

SELECT p.SalesOrderID, max(p.SubTotal) SubTotal, sum(ld.LineTotal) LineTotal
FROM Sales.SalesOrderHeader AS p 
	INNER JOIN Sales.SalesOrderDetail AS ld ON p.SalesOrderID = ld.SalesOrderID
GROUP BY p.SalesOrderID
--HAVING p.SubTotal <> round(sum(ld.LineTotal), 4)
HAVING max(p.SubTotal) <> cast(sum(ld.LineTotal) as money)
--HAVING max(p.SubTotal) <> round(sum(ld.LineTotal), 4)

SELECT DISTINCT cp.FirstName + ' ' + cp.LastName Cliente, prod.name Producto
FROM Sales.Customer c
	inner join Person.Person cp on c.PersonID = cp.BusinessEntityID
	inner join Sales.SalesOrderHeader p on p.CustomerID = c.CustomerID
	inner join Sales.SalesOrderDetail ld ON p.SalesOrderID = ld.SalesOrderID
	inner join Production.Product prod on ld.ProductID = prod.ProductID
order by Cliente, Producto

/*
SELECT 
	iif(GROUPING(YEAR(DueDate)) = 1, 'Total', cast(YEAR(DueDate) as varchar)) Año, 
	iif(GROUPING(DATEPART(QUARTER, [DueDate])) = 1, 'Total', cast(DATEPART(QUARTER, [DueDate]) as varchar)) Trimestre, 
	iif(GROUPING(p.[TerritoryID]) = 1, 'Total', ISNULL(max(z.Name), '(Sin zona)')) Zona, 
	iif(GROUPING([SalesPersonID]) = 1, 'Total', ISNULL(cast([SalesPersonID] as varchar), 'On line')) Vendedor, 
	sum([TotalDue]) [Ventas],
	case GROUPING_ID(YEAR(DueDate), DATEPART(QUARTER, [DueDate]), p.[TerritoryID], [SalesPersonID])
	when 15 then 'Total Informe'
	when 7 then 'Total Año ' + cast(YEAR(DueDate) as varchar)
	when 3 then 'Total ' + cast(DATEPART(QUARTER, [DueDate]) as varchar) + ' Trimestre del ' + cast(YEAR(DueDate) as varchar)
	when 1 then 'Total Zona'
	else ''
	end Resumen,
	GROUPING_ID(YEAR(DueDate), DATEPART(QUARTER, [DueDate]), p.[TerritoryID], [SalesPersonID]) GROUPINGID
FROM Sales.SalesOrderHeader p
	LEFT JOIN Sales.SalesTerritory z on p.TerritoryID = z.TerritoryID
GROUP BY ROLLUP(YEAR(DueDate), DATEPART(QUARTER, [DueDate]), p.[TerritoryID], [SalesPersonID])
ORDER BY GROUPING(YEAR(DueDate)), Año, 
	GROUPING(DATEPART(QUARTER, [DueDate])), Trimestre, 
	GROUPING(p.[TerritoryID]), Zona, 
	GROUPING([SalesPersonID]), Vendedor
*/