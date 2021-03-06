USE [OPXBI_MART]
GO

/****** Object:  Table [dbo].[JobHistory]    Script Date: 10/3/2017 11:10:54 AM ******/
/****** Object:  Table [dbo].[JobName]    Script Date: 10/3/2017 11:10:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[JobHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [UNIQUEIDENTIFIER] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[RunUser] char(30) DEFAULT SYSTEM_USER NOT NULL,
	[MessageStatus] [nvarchar](4000) NULL,
	[RunStatus] char(30) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[JobName](
	[JobId] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[JobOrder] [int] NOT NULL,
	[JobName] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](512) NULL,
	[CreatedUser] char(30) DEFAULT SYSTEM_USER NOT NULL,
	[DateCreated] [datetime] DEFAULT GETDATE() NOT NULL,
	[DateModified] [datetime] DEFAULT GETDATE() NOT NULL
) ON [PRIMARY]
GO


--
USE [OPXBI_MART]
GO

INSERT INTO [dbo].[JobNames]
           ([JobOrder]
           ,[JobName]
           ,[Description])
     VALUES
           (0
           ,'TCE Survey Mailer'
           ,'TCE Survey Mailer Full Load')
GO

  DELETE [OPXBI_MART].[dbo].[JobNames]
  WHERE JobID='0FC505FD-72E7-4A3D-AB01-AD83D4B2655F'

  SELECT * FROM   [OPXBI_MART].[dbo].[JobNames]

GO

USE [OPXBI_MART]
INSERT INTO [dbo].[JobHistory]
           ([JobId]
           ,[StartTime]
           ,[EndTime]
           ,[RunUser]
           ,[MessageStatus]
           ,[RunStatus])
     VALUES
           ('B570E2D1-ACF4-4C66-866F-A59C56D0FB1B'
           ,GETDATE()
           ,GETDATE()
           ,SYSTEM_USER
           ,'Job is running'
		   ,'In Progress')
GO

  SELECT * FROM   [OPXBI_MART].[dbo].[JobHistory]


SELECT @@IDENTITY AS ID

/**		Job Status	**	
	In Progress
	Failed
	Successful
**/


UPDATE [dbo].[JobHistory] 
SET [EndTime] = GETDATE()
	,[RunUser]	= SYSTEM_USER
	,[MessageStatus] = ?
	,[RunStatus] = 'Failed'
WHERE [JobId] = ?

UPDATE [dbo].[JobHistory] 
SET [EndTime] = GETDATE()
	,[RunUser]	= SYSTEM_USER
	,[MessageStatus] = 'Job completed with success'
	,[RunStatus] = 'Successful'
WHERE [JobId] = ?

