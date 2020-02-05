-- ==========================
-- Create Default template
-- ==========================
-- This feature is marked for deprecation

CREATE DEFAULT Hoy
AS
   getdate()
GO
CREATE DEFAULT Cero
AS
   0
GO
CREATE DEFAULT Hombre
AS
   'H'
GO
CREATE DEFAULT Mujer
AS
   'M'
GO
---- Bind the default to a column
--EXEC sp_bindefault 
--   N'<schema_name, sysname, dbo>.<default_name, , today>', 
--   N'<table_schema,,HumanResources>.<table_name,,Employee>.<column_name,,HireDate>'
--GO

CREATE RULE Precio
AS
	@valor >= 0
GO
USE [Curso]
GO
CREATE TYPE [dbo].[Importe] FROM [decimal](9, 2) NOT NULL
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[Cero]', @objname=N'[dbo].[Importe]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[Precio]', @objname=N'[dbo].[Importe]' , @futureonly='futureonly'
GO


/****** Script para el comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [id]
      ,[kkkk]
      ,[otra]
      ,[guid]
      ,[version]
      ,[pvd]
      ,[xml]
	  ,[xml].value('(//direccion/provincia)[1]', 'varchar(100)')
  FROM [Curso].[dbo].[MiTabla]
  --where [xml].value('(//direccion/provincia)[1]', 'varchar(100)') like 'B%'

  --update [Curso].[dbo].[MiTabla]
  --set [xml] = '<Personas><Persona><direccion><provincia>Barcelona</provincia></direccion></Persona></Personas>'
  --where id = 3
