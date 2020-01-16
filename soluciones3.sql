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
ORDER BY DATEPART(YEAR, [DueDate]), DATEPART(Q, [DueDate])

SELECT DATEPART(YEAR, [DueDate]) Año, DATEPART(MONTH, [DueDate]) Mes, 
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos]
FROM [Sales].[SalesOrderHeader]
GROUP BY DATEPART(YEAR, [DueDate]), DATEPART(MONTH, [DueDate])
HAVING count(*) > 1000
ORDER BY DATEPART(YEAR, [DueDate]), DATEPART(MONTH, [DueDate])

SELECT [SalesPersonID], 
	--isnull(cast([SalesPersonID] as varchar), 'On line') Vendedor,
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos]
FROM [Sales].[SalesOrderHeader]
WHERE [SalesPersonID] IS NOT NULL
GROUP BY [SalesPersonID]
ORDER BY [Total Ventas] DESC, [SalesPersonID]

SELECT *
FROM [Sales].[SalesOrderHeader]
where [OnlineOrderFlag] = 0 and [SalesPersonID] is null
