select $ROWGUID, p.BusinessEntityID
, p.FirstName as Nombre, p.LastName Apellidos, p.MIddleName [Middle Name], 1 Tipo
from Person.Person p
--where p.FirstName like '$_A$_$%' escape '$'
where 'Algo' like (p.FirstName + '%') 
order by p.FirstName, p.LastName

SELECT [BusinessEntityID]
, case 
	when Title is not null then Title + ' ' + LastName
	when MiddleName  is not null then FirstName + ' ' + MiddleName + ' ' + LastName
	--else FirstName + ' ' + LastName
	end nombre
,	
case EmailPromotion
	when null then 'Contact does not wish to receive e-mail promotions'
	when 0 then 'Contact does not wish to receive e-mail promotions'
	when 1 then 'Contact does wish to receive e-mail promotions from AdventureWorks'
	when 2 then 'Contact does wish to receive e-mail promotions from AdventureWorks and selected partners. '
	else '(desconocido)'
	end EmailPromotionText
,
CHOOSE(EmailPromotion + 1,
	'Contact does not wish to receive e-mail promotions',
	'Contact does wish to receive e-mail promotions from AdventureWorks',
	'Contact does wish to receive e-mail promotions from AdventureWorks and selected partners. '
	) ConCHOOSE

      ,[PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[rowguid]
      ,[ModifiedDate]
	  , isnull(Title,'(a nulos)'), isnull(Suffix,'(a nulos)')
  FROM [Person].[Person] p
  --where [ModifiedDate] between '1/1/2007' and '1/1/2008'
  --where not( p.MiddleName = 'a' or p.MiddleName = 'b' or p.MiddleName = 'c')
  --where p.MiddleName not like '[abc]'
  --where p.MiddleName > any (null, 'a.', 'b', 'c')
   -- where p.MiddleName not in ('a.', 'b', 'c')
 -- '1/1/2007' between FIni and FFin
where isnull(Title,'()') = isnull(Suffix,'()') --or (Title is null and Suffix is null)
--where 
--	case Title
--	when null then '(vacio)'
--	else Title
--	end 
--	= 
--	case Suffix
--	when null then '(vacio)'
--	else Suffix
--	end  
--where EmailPromotionText like 'C%'
order by EmailPromotionText
--OFFSET np * 40 ROWS FETCH FIRST 40 ROWS ONLY


--select iif([DaysToManufacture] = 0, 'Ya esta', 'Hay que fabricarlo')
select iif([DaysToManufacture] = 0, 1, 1.2) * [ListPrice]
from [Production].[Product]
select isnull([Weight], 0) * [ListPrice], [Weight], [ListPrice]
from [Production].[Product]

SELECT JobTitle, HireDate, CHOOSE(MONTH(HireDate),'Winter','Winter', 'Spring','Spring','Spring','Summer','Summer',   
                                                  'Summer','Autumn','Autumn','Autumn','Winter') AS Quarter_Hired  
FROM HumanResources.Employee  
WHERE  YEAR(HireDate) > 2005  
ORDER BY YEAR(HireDate);  

select *
from [Production].[Product]
where '1/1/2009' between [SellStartDate] 
	and isnull([SellEndDate], GETDATE())
