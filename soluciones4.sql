SELECT  Name, [ListPrice], 
	[ListPrice] - avg(ListPrice) over(partition by [ProductSubcategoryID]) [Delta precio],
	[ListPrice] - max(ListPrice) over(partition by [ProductSubcategoryID]) [Delta máximo],
	[ListPrice] - min(ListPrice) over(partition by [ProductSubcategoryID]) [Delta mínimo]
FROM Production.Product

SELECT  ProductSubcategoryID, Name, [ListPrice], 
	rank() over(order by ListPrice desc) [Ranking de precios],
	rank() over(partition by [ProductSubcategoryID] order by ListPrice desc) [Ranking de precios por categoria]
FROM Production.Product
ORDER BY [ProductSubcategoryID], [Ranking de precios por categoria], Name

SELECT  Name, [ListPrice],
	NTILE(3) over (order by [ListPrice] desc),
	CHOOSE (NTILE(3) over (order by [ListPrice]), 'Barato', 'Normal', 'Caro') Clasificación,
	case NTILE(3) over (order by [ListPrice] desc)
	when 1 then 'Caro'
	when 2 then 'Normal'
	else 'Barato'
	end Tipo
	,
	case 
	when ListPrice = 0  then 'Regalao'
	when ListPrice > 1000  then 'Caro'
	when ListPrice between 100 and 1000 then 'Normal'
	else 'Barato'
	end Manual
FROM Production.Product
							
