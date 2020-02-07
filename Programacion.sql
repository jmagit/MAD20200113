declare @cont int = 0, @cad varchar(50)

set @cont = @cont + 1

declare @fecha datetime = null

select @cont = @cont + 1, @fecha = GETDATE()
print @cont + ' ' + @fecha
select @cont,  @fecha
select @cont = count(*) from MiTabla
if @cont = 0
begin
	select @cont = pvd, @cad = kkkk from MiTabla where id = 1
	Select 'Otra intrucción'
end
else if @cont = 1
begin
	Select 'No hay nada'
end	
else if @cont = 2
begin
	Select 'No hay nada'
end	
else
begin
	Select 'No hay nada'
end	

select @cont,  @fecha, @cad

if (select count(*) from MiTabla) > 0
begin
	set @fecha = '01-01-2000'
end
else 
begin
	set @fecha = GETDATE()
end	


set @cont = 0
while @cont < 10
begin
	print @cont
	set @cont = @cont + 1
	--if @cont between 1 and 5
	--begin
	--	print 'Pequeño'
	--	-- ...
	--end
	if @cont not between 1 and 5
		continue
	print 'Pequeño'
	-- ...
end

while 1 = 1
begin
	print @cont
	if @cont > 10 
		break
	set @cont = @cont + 1
end

DECLARE @resumen varchar(8000) = '', @col varchar(100)
DECLARE ElCursor CURSOR FOR SELECT [kkkk] FROM [Curso].[dbo].[MiTabla] where kkkk='uno'
OPEN ElCursor;
FETCH NEXT FROM ElCursor INTO @col;
WHILE @@FETCH_STATUS = 0
BEGIN
	set @resumen = @resumen + @col
	FETCH NEXT FROM ElCursor INTO @col;
END;
CLOSE ElCursor;
DEALLOCATE ElCursor;
print @resumen


ALTER PROCEDURE miSP
	@p1 int = 0,  
	@p2 varchar(255) out
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @p2 = kkkk FROM [Curso].[dbo].[MiTabla] where id = @p1
	SELECT * FROM [Curso].[dbo].[MiTabla] where id = @p1
	return @p1
END
GO

declare @rslt int, @sal varchar(500)

exec @rslt = miSP 1, @sal out

print @sal
print @rslt
GO
CREATE FUNCTION fnTipo
(
	@valor int
)
RETURNS varchar(50)
AS
BEGIN
	RETURN case @valor
	when 1 then 'Caro'
	when 2 then 'Normal'
	else 'Barato'
	end
END
GO

select dbo.fnTipo(2)

GO
CREATE FUNCTION TotalOrder 
(
	@order int
)
RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result money

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = sum(ld.LineTotal)
		FROM Sales.SalesOrderDetail AS ld 
		where ld.SalesOrderID = @order
	RETURN @Result

END
GO
select dbo.TotalOrder (43659)
GO
CREATE TABLE #LibrosTmp (
	[idProduto] [int] NOT NULL,
	[Algo] [nchar](10) NULL,
 CONSTRAINT [PK_Libros] PRIMARY KEY CLUSTERED 
(
	[idProduto] ASC
)
)

insert into #LibrosTmp
select * from [dbo].[Libros]
select * from #LibrosTmp
--drop table #LibrosTmp


alter FUNCTION VistaParam
(	
	@id int, @descuento decimal(10,2)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT        dbo.MiTabla.id, dbo.MiTabla.id * @descuento Descuento, dbo.MiTabla.kkkk, MiTabla_1.otra, MiTabla_1.kkkk AS Expr1, MiTabla_1.id AS Expr2
	FROM            dbo.MiTabla INNER JOIN
                         dbo.MiTabla AS MiTabla_1 ON dbo.MiTabla.id = MiTabla_1.id
	where MiTabla_1.id = @id

)
GO

select * from Libros l cross apply dbo.VistaParam(l.idProduto, 0) f


declare @mitabla TABLE (
	[idProduto] [int] NOT NULL,
	[Algo] [nchar](10) NULL
)

insert into @mitabla
select * from [dbo].[Libros]
select * from @mitabla
