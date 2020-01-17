SELECT TOP (1000) [DocumentNode]
      ,[DocumentLevel]
      ,[Title]
      ,[Owner]
      ,[FolderFlag]
      ,[FileName]
      ,[FileExtension]
      ,[Revision]
      ,[ChangeNumber]
      ,[Status]
      ,[DocumentSummary]
	  , len([DocumentSummary])
      ,[Document]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2017].[Production].[Document]
  where contains([DocumentSummary], 'mainta* or repair')
  --It is important that you maintain your bicycle and keep it in good repair. Detailed repair and service guidelines are provided along with instructions for adjusting the tightness of the suspension fork.

  select * from containstable([AdventureWorks2017].[Production].[Document],DocumentSummary, 'mainta* or repair')

  select 1, 2
  union
  select 1, 3


USE [Curso]
GO

SET IDENTITY_INSERT [dbo].[MiTabla] ON
go
INSERT INTO [dbo].[MiTabla]
           (id, [kkkk]
           ,[otra]
           ,[guid])
     VALUES
           (3,'Recupera'
           ,'otra'
           ,DEFAULT)
select @@IDENTITY
SET IDENTITY_INSERT [dbo].[MiTabla] off


INSERT INTO [dbo].[MiTabla]
           ([kkkk]
           ,[otra]
           ,[guid])
     VALUES
           ('una'
           ,'otra'
           ,DEFAULT)
select @@IDENTITY
GO


