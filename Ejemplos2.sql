select Class, count(1), count([Color]), count(iif([Color]='Red', 1, null)), 
	sum([ListPrice]), avg([ListPrice]) [avg], 
	sum([ListPrice])/count(*),
	min([ListPrice]), max([ListPrice])
from [Production].[Product]
--where Class is not null and ListPrice = 0
group by Class
having Class is null or (Class = 'H' and min([ListPrice]) > 0) --Class is not null


select [Gender], [MaritalStatus], [JobTitle], count(*) Cuantos, avg(YEAR(GETDATE()) - YEAR(BirthDate) 
	- IIF(MONTH(GETDATE()) < MONTH(BirthDate) OR 
		(MONTH(GETDATE()) = MONTH(BirthDate) AND DAY(GETDATE()) <= DAY(BirthDate))
		, 1, 0)) EdadMedia
from [HumanResources].[Employee]
group by [Gender], [MaritalStatus], [JobTitle]
having count(*) > 1
order by [Gender], [MaritalStatus], [JobTitle]

select [JobTitle], count(*) Cuantos, avg(YEAR(GETDATE()) - YEAR(BirthDate) 
	- IIF(MONTH(GETDATE()) < MONTH(BirthDate) OR 
		(MONTH(GETDATE()) = MONTH(BirthDate) AND DAY(GETDATE()) <= DAY(BirthDate))
		, 1, 0)) EdadMedia
from [HumanResources].[Employee]
group by [Gender], [MaritalStatus], [JobTitle]
having count(*) > 1
order by [Gender], [MaritalStatus], [JobTitle]

select *
from [Sales].[SalesOrderDetail]
order by [SalesOrderID], [SalesOrderDetailID]

select count(*)
from [Sales].[SalesOrderDetail]

select [SalesOrderID], [TotalDue],
	[SalesPersonID], AVG([TotalDue]) over(partition by [SalesPersonID]), 
	iif((AVG([TotalDue]) over (partition by [SalesPersonID]) ) > [TotalDue], 'MENOR', 'mayor')
from [Sales].[SalesOrderHeader]

select [SalesPersonID], AVG([TotalDue])
from [Sales].[SalesOrderHeader]
group by [SalesPersonID]

select [ProductID],[Name],[ProductSubcategoryID],[ListPrice], ROW_NUMBER() over (partition by [ProductSubcategoryID] order by [ListPrice], [Name])
from [Production].[Product]
order by [ProductSubcategoryID],[ListPrice], [Name]

select [ProductID], [ListPrice], dense_rank() over (order by [ListPrice]) precios
from [Production].[Product]
where ListPrice <> 0
order by precios

SELECT --[SalesPersonID] Vendedor, 
	isnull(cast([SalesPersonID] as varchar), 'On line') Vendedor,
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos], 
	rank() over(ORDER BY sum([TotalDue]) DESC),
	ntile(4) over(ORDER BY sum([TotalDue]) DESC)
FROM [Sales].[SalesOrderHeader]
--WHERE [SalesPersonID] IS NOT NULL
GROUP BY [SalesPersonID]
ORDER BY [Total Ventas] DESC, [SalesPersonID]
