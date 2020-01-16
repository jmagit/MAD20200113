/*
SELECT YEAR(DueDate) Año, DATEPART(QUARTER, [DueDate]) Trimestre, 
	[TerritoryID] Zona, [SalesPersonID] Vendedor, sum([TotalDue]) [Ventas]
FROM Sales.SalesOrderHeader
GROUP BY YEAR(DueDate), DATEPART(QUARTER, [DueDate]), [TerritoryID], [SalesPersonID] 
ORDER BY Año, Trimestre, Zona, Vendedor

SELECT YEAR(DueDate) Año, DATEPART(QUARTER, [DueDate]) Trimestre, 
	[TerritoryID] Zona, [SalesPersonID] Vendedor, sum([TotalDue]) [Ventas]
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP(YEAR(DueDate), DATEPART(QUARTER, [DueDate]), [TerritoryID], [SalesPersonID])
ORDER BY Año, Trimestre, Zona, Vendedor
*/

SELECT 
	iif(GROUPING(YEAR(DueDate)) = 1, 'Total', cast(YEAR(DueDate) as varchar)) Año, 
	iif(GROUPING(DATEPART(QUARTER, [DueDate])) = 1, 'Total', cast(DATEPART(QUARTER, [DueDate]) as varchar)) Trimestre, 
	iif(GROUPING([TerritoryID]) = 1, 'Total', ISNULL(cast([TerritoryID] as varchar), '(Sin zona)')) Zona, 
	iif(GROUPING([SalesPersonID]) = 1, 'Total', ISNULL(cast([SalesPersonID] as varchar), 'On line')) Vendedor, 
	sum([TotalDue]) [Ventas],
	case GROUPING_ID(YEAR(DueDate), DATEPART(QUARTER, [DueDate]), [TerritoryID], [SalesPersonID])
	when 15 then 'Total Informe'
	when 7 then 'Total Año ' + cast(YEAR(DueDate) as varchar)
	when 3 then 'Total ' + cast(DATEPART(QUARTER, [DueDate]) as varchar) + ' Trimestre del ' + cast(YEAR(DueDate) as varchar)
	when 1 then 'Total Zona'
	else ''
	end Resumen,
	GROUPING_ID(YEAR(DueDate), DATEPART(QUARTER, [DueDate]), [TerritoryID], [SalesPersonID])
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP(YEAR(DueDate), DATEPART(QUARTER, [DueDate]), [TerritoryID], [SalesPersonID])
ORDER BY GROUPING(YEAR(DueDate)), Año, 
	GROUPING(DATEPART(QUARTER, [DueDate])), Trimestre, 
	GROUPING([TerritoryID]), Zona, 
	GROUPING([SalesPersonID]), Vendedor
