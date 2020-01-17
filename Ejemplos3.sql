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

SELECT DISTINCT cp.FirstName + ' ' + cp.LastName Cliente, prod.name Producto
FROM Sales.Customer c
	inner join Person.Person cp on c.PersonID = cp.BusinessEntityID
	inner join Sales.SalesOrderHeader p on p.CustomerID = c.CustomerID
	inner join Sales.SalesOrderDetail ld ON p.SalesOrderID = ld.SalesOrderID
	inner join Production.Product prod on ld.ProductID = prod.ProductID
order by Cliente, Producto

SELECT count(*)
FROM Sales.Customer c
	inner join Person.Person cp on c.PersonID = cp.BusinessEntityID
	inner join Sales.SalesOrderHeader p on p.CustomerID = c.CustomerID
	inner join Sales.SalesOrderDetail ld ON p.SalesOrderID = ld.SalesOrderID
	inner join (select * from Production.Product where ProductSubcategoryID is not null) prod on ld.ProductID = prod.ProductID

select count(*) from Production.Product where ProductSubcategoryID is not null

SELECT * FROM (VALUES (1, 'Caro'), (2, 'Normal'), (3, 'Barato')) AS Tipo(Id, Name);

SELECT  p.Name, [ListPrice], tipo, Tipo.Name	
FROM (SELECT  Name, [ListPrice], NTILE(3) over (order by [ListPrice] desc) tipo
	FROM Production.Product ) p 
	INNER JOIN (VALUES (1, 'Caro'), (2, 'Normal'), (3, 'Barato')) AS Tipo(Id, Name)
	ON p.tipo = Tipo.Id

SELECT [ProductSubcategoryID], [Class], count(*) Productos
FROM [Production].[Product]
GROUP BY [ProductSubcategoryID], [Class]


SELECT ISNULL(cast([ProductSubcategoryID] as varchar), '(Sin subcategoria)') [Sub categoria], 
	SUM(IIF(Class is NULL, 1, 0)) [Sin Gama],
	COUNT(IIF(Class = 'L', Class, NULL)) Baja,
	SUM(IIF(Class = 'M', 1, 0)) Media, 
	SUM(IIF(Class = 'H', 1, 0)) Alta,
	COUNT(class) [Total con gama],
	COUNT(*) Total
FROM Production.Product
GROUP BY [ProductSubcategoryID]
ORDER BY [ProductSubcategoryID]

select  *
FROM  (
	SELECT [ProductSubcategoryID], [Class]
	FROM [Production].[Product]
) p 
PIVOT ( 
count(ProductSubcategoryID)  
FOR Class  IN (L,  M, X )  
) AS r

select FirstName + ' ' + LastName Empleado
FROM [Person].[Person]
where BusinessEntityID in (
	select BusinessEntityID FROM [HumanResources].[Employee]
)

select FirstName + ' ' + LastName Empleado
FROM [Person].[Person]
where EXISTS (
	select * FROM [HumanResources].[Employee] e where e.BusinessEntityID = BusinessEntityID
)
select FirstName + ' ' + LastName Empleado
FROM [Person].[Person] p inner join [HumanResources].[Employee] e
	on e.BusinessEntityID = p.BusinessEntityID

USE [AdventureWorks2017]
GO

SELECT [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[CarrierTrackingNumber]
      ,[OrderQty]
      ,(select max(p.name) from Production.Product p where p.ProductID = [ProductID]) + 'Algo' Producto
      ,[SpecialOfferID]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [Sales].[SalesOrderDetail]
  where [SalesOrderID] = 43659

