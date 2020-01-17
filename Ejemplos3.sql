SELECT YEAR(DueDate) Año, DATEPART(QUARTER, [DueDate]) Trimestre, 
	cast([TerritoryID] as varchar) Zona, cast([SalesPersonID] as varchar) Vendedor, sum([TotalDue]) [Ventas],
	'N' Tipo
FROM Sales.SalesOrderHeader
GROUP BY YEAR(DueDate), DATEPART(QUARTER, [DueDate]), [TerritoryID], [SalesPersonID] 
UNION
SELECT YEAR(DueDate) Año, DATEPART(QUARTER, [DueDate]) Trimestre, 
	cast([TerritoryID] as varchar) Zona, 'Total' Vendedor, sum([TotalDue]) [Ventas],
	'RV' Tipo
FROM Sales.SalesOrderHeader
GROUP BY YEAR(DueDate), DATEPART(QUARTER, [DueDate]), [TerritoryID] 
UNION
SELECT YEAR(DueDate) Año, DATEPART(QUARTER, [DueDate]) Trimestre, 
	'Total' Zona, '' Vendedor, sum([TotalDue]) [Ventas],
	'RT' Tipo
FROM Sales.SalesOrderHeader
GROUP BY YEAR(DueDate), DATEPART(QUARTER, [DueDate]) 
ORDER BY Año, Trimestre, Zona, Vendedor


SELECT *
FROM Sales.SalesOrderHeader
WHERE SalesPersonID in (277,280,279) and Status <> 6 --
SELECT *
FROM Sales.SalesOrderHeader
WHERE SalesPersonID in (277,280,279) and Status <> 6 --
except
SELECT *
FROM Sales.SalesOrderHeader
WHERE [TerritoryID] not in (1,4,5) or SalesOrderNumber like 'PO%' --


SELECT  c.Name Categoria, p.Name, [ListPrice], 
	rank() over(order by ListPrice desc) [Ranking de precios],
	rank() over(partition by p.ProductSubcategoryID order by ListPrice desc) [Ranking de precios por categoria]
FROM Production.Product p full join Production.ProductSubcategory c on 
	p.ProductSubcategoryID = c.ProductSubcategoryID
	LEFT join Production.UnitMeasure us on p.SizeUnitMeasureCode = us.UnitMeasureCode
	LEFT join Production.UnitMeasure uw on p.WeightUnitMeasureCode = us.UnitMeasureCode

ORDER BY c.Name, [Ranking de precios por categoria], p.Name

SELECT  c.Name Categoria, p.Name, [ListPrice], 
	rank() over(order by ListPrice desc) [Ranking de precios],
	rank() over(partition by p.ProductSubcategoryID order by ListPrice desc) [Ranking de precios por categoria]
FROM Production.Product p, Production.ProductSubcategory c 
where p.ProductSubcategoryID = c.ProductSubcategoryID
ORDER BY c.Name, [Ranking de precios por categoria], p.Name

--10*5*500

SELECT  ped.SalesOrderID, p.FirstName + ' ' + p.LastName Vendedor
FROM    Person.Person p 
		INNER JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID 
		INNER JOIN Sales.SalesPerson v on e.BusinessEntityID = v.BusinessEntityID
		INNER JOIN Sales.SalesOrderHeader ped ON ped.SalesPersonID = v.BusinessEntityID

SELECT  ped.SalesOrderID, p.BusinessEntityID, iif(p.BusinessEntityID is null, 'Nulo', p.FirstName + ' ' + p.LastName) Vendedor
FROM    Person.Person p 
		full JOIN Sales.SalesOrderHeader ped 
			ON ped.SalesPersonID = p.BusinessEntityID and ped.SalesOrderID is null
where ped.SalesOrderID is null


SELECT  ped.SalesOrderID, p.FirstName + ' ' + p.LastName Vendedor
FROM    Person.Person p , HumanResources.Employee AS e, Sales.SalesPerson v , Sales.SalesOrderHeader ped
WHERE p.BusinessEntityID = e.BusinessEntityID and e.BusinessEntityID = v.BusinessEntityID
	and ped.SalesPersonID = v.BusinessEntityID
