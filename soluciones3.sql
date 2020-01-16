SELECT avg([TotalDue]) [Precio Medio]
FROM [Sales].[SalesOrderHeader]

SELECT DATEPART(YEAR, [DueDate]) Año, DATEPART(Q, [DueDate]) Trimestrales, 
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos],
	MAX([TotalDue]) Máximo,
	MIN([TotalDue]) Mínimo
FROM [Sales].[SalesOrderHeader]
WHERE Status not in (4, 6)
GROUP BY DATEPART(YEAR, [DueDate]), DATEPART(Q, [DueDate])
ORDER BY Año, Trimestrales

SELECT DATEPART(YEAR, [DueDate]) Año, DATEPART(MONTH, [DueDate]) Mes, 
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos]
FROM [Sales].[SalesOrderHeader]
GROUP BY DATEPART(YEAR, [DueDate]), DATEPART(MONTH, [DueDate])
HAVING count(*) > 1000
ORDER BY DATEPART(YEAR, [DueDate]), DATEPART(MONTH, [DueDate])

SELECT --[SalesPersonID] Vendedor, 
	isnull(cast([SalesPersonID] as varchar), 'On line') Vendedor,
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos]
FROM [Sales].[SalesOrderHeader]
--WHERE [SalesPersonID] IS NOT NULL
GROUP BY [SalesPersonID]
ORDER BY [Total Ventas] DESC, [SalesPersonID]

SELECT *
FROM [Sales].[SalesOrderHeader]
where [OnlineOrderFlag] = 1 and [SalesPersonID] is not null

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
