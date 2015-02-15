--
-- BugNET 0.7 Upgrade Script
-- 
-- 
-- 
--
-- 
--
--

IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

-- Remove foreign key constraints

ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Environment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Hardware]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_OperatingSystem]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Priority]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Resolution]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Status]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Type]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugAttachment] DROP CONSTRAINT [FK_BugAttachment_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugComment] DROP CONSTRAINT [FK_BugComment_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugHistory] DROP CONSTRAINT [FK_BugHistory_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugNotification] DROP CONSTRAINT [FK_BugNotification_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugTimeEntry] DROP CONSTRAINT [FK_BugTimeEntry_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[RelatedBug] DROP CONSTRAINT [FK_RelatedBug_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.Bug
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Bug'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Bug]
    (
  [BugID] [int] NOT NULL IDENTITY (1, 1) ,
  [Summary] [nvarchar] (500) NOT NULL ,
  [Description] [ntext] NOT NULL ,
  [ReportedDate] [datetime] NOT NULL ,
  [StatusID] [int] NOT NULL ,
  [PriorityID] [int] NOT NULL ,
  [TypeID] [int] NOT NULL ,
  [ComponentID] [int] NOT NULL ,
  [ProjectID] [int] NOT NULL ,
  [ResolutionID] [int] NOT NULL ,
  [VersionID] [int] NOT NULL ,
  [LastUpdate] [datetime] NOT NULL ,
  [ReporterUserId] [uniqueidentifier] NOT NULL ,
  [AssignedToUserId] [uniqueidentifier] NULL ,
  [LastUpdateUserId] [uniqueidentifier] NOT NULL ,
  [DueDate] [datetime] NULL ,
  [FixedInVersionId] [int] NOT NULL ,
  [Visibility] [int] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from syscolumns where id=OBJECT_ID('[dbo].[tmp_sc_Bug]') and name='DueDate' and cdefault>0) EXEC ('sp_unbindefault ''[dbo].[tmp_sc_Bug].[DueDate]''')


IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Bug] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Bug] 
([BugID], [Summary], [Description], [ReportedDate], [StatusID], [PriorityID], 
[TypeID], [ComponentID], [ProjectID], [ResolutionID], [VersionID], 
[LastUpdate],[Visibility],[FixedInVersionId],[LastUpdateUserId],[ReporterUserId],[AssignedToUserId]) 
SELECT [BugID], [Summary], [Description], [ReportedDate], 
[StatusID], [PriorityID], [TypeID], [ComponentID], [ProjectID], 
[ResolutionID], [VersionID], [LastUpdate], 0,-1,
(SELECT aspnet_users.UserId From aspnet_users join Users on Bug.LastUpdateUser = Users.UserId where Users.Username = aspnet_users.username ),
(SELECT aspnet_users.UserId From aspnet_users join Users on Bug.ReportedUser = Users.UserId where Users.Username = aspnet_users.username),
(SELECT aspnet_users.UserId From aspnet_users join Users on Bug.AssignedTo = Users.UserId where Users.Username = aspnet_users.username)
FROM [dbo].[Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Bug] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Bug]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Bug', 'Bug'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD  CONSTRAINT [PK__Bug__145C0A3F] PRIMARY KEY CLUSTERED ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Priority] FOREIGN KEY ([PriorityID])  REFERENCES [dbo].[Priority] ([PriorityID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Priority]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Project] FOREIGN KEY ([ProjectID])  REFERENCES [dbo].[Project] ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Resolution] FOREIGN KEY ([ResolutionID])  REFERENCES [dbo].[Resolution] ([ResolutionID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Resolution]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Status] FOREIGN KEY ([StatusID])  REFERENCES [dbo].[Status] ([StatusID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Status]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Type] FOREIGN KEY ([TypeID])  REFERENCES [dbo].[Type] ([TypeID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Type]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugAttachment] WITH NOCHECK ADD CONSTRAINT [FK_BugAttachment_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugAttachment] CHECK CONSTRAINT [FK_BugAttachment_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugComment] WITH NOCHECK ADD CONSTRAINT [FK_BugComment_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugComment] CHECK CONSTRAINT [FK_BugComment_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugHistory] WITH NOCHECK ADD CONSTRAINT [FK_BugHistory_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugHistory] CHECK CONSTRAINT [FK_BugHistory_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugNotification] WITH NOCHECK ADD CONSTRAINT [FK_BugNotification_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugNotification] CHECK CONSTRAINT [FK_BugNotification_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugTimeEntry] WITH NOCHECK ADD CONSTRAINT [FK_BugTimeEntry_Bug] FOREIGN KEY ([BugId])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugTimeEntry] CHECK CONSTRAINT [FK_BugTimeEntry_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[RelatedBug] WITH NOCHECK ADD CONSTRAINT [FK_RelatedBug_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[RelatedBug] CHECK CONSTRAINT [FK_RelatedBug_Bug]
GO

/* Bug Attachment Table */

-- Remove foreign key constraints

ALTER TABLE [dbo].[BugAttachment] DROP CONSTRAINT [FK_BugAttachment_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugAttachment
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugAttachment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_BugAttachment]
    (
  [BugAttachmentID] [int] NOT NULL IDENTITY (1, 1) ,
  [BugID] [int] NOT NULL ,
  [FileName] [nvarchar] (100) NOT NULL ,
  [Description] [nvarchar] (80) NOT NULL ,
  [FileSize] [int] NOT NULL ,
  [Type] [nvarchar] (50) NOT NULL ,
  [UploadedDate] [datetime] NOT NULL ,
  [UploadedUserId] [uniqueidentifier] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugAttachment] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_BugAttachment] 
([BugAttachmentID], [BugID], [FileName], [Description], [FileSize], [Type], [UploadedDate],[UploadedUserId]) 
SELECT [BugAttachmentID], [BugID], [FileName], [Description], [FileSize], [Type], [UploadedDate] , 
(SELECT aspnet_users.UserId From aspnet_users join Users on BugAttachment.UploadedUser = Users.UserId where Users.Username = aspnet_users.username )
FROM [dbo].[BugAttachment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugAttachment] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[BugAttachment]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[BugAttachment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_BugAttachment', 'BugAttachment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[BugAttachment] WITH NOCHECK ADD  CONSTRAINT [PK__BugAttachment__1273C1CD] PRIMARY KEY CLUSTERED ([BugAttachmentID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[BugAttachment] WITH NOCHECK ADD CONSTRAINT [FK_BugAttachment_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugAttachment] CHECK CONSTRAINT [FK_BugAttachment_Bug]
GO

/* Bug Comment Table */ 

-- Remove foreign key constraints

ALTER TABLE [dbo].[BugComment] DROP CONSTRAINT [FK_BugComment_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugComment
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugComment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_BugComment]
    (
  [BugCommentID] [int] NOT NULL IDENTITY (1, 1) ,
  [BugID] [int] NOT NULL ,
  [CreatedDate] [datetime] NOT NULL ,
  [Comment] [ntext] NOT NULL ,
  [CreatedUserId] [uniqueidentifier] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugComment] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_BugComment] ([BugCommentID], [BugID], [CreatedDate], [Comment],[CreatedUserId]) 
SELECT [BugCommentID], [BugID], [CreatedDate], [Comment],(SELECT aspnet_users.UserId From aspnet_users join Users on BugComment.UserId = Users.UserId where Users.Username = aspnet_users.username )
 FROM [dbo].[BugComment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugComment] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[BugComment]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[BugComment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_BugComment', 'BugComment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[BugComment] WITH NOCHECK ADD  CONSTRAINT [PK__BugComment__164452B1] PRIMARY KEY CLUSTERED ([BugCommentID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[BugComment] WITH NOCHECK ADD CONSTRAINT [FK_BugComment_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugComment] CHECK CONSTRAINT [FK_BugComment_Bug]
GO

/* Bug History Table */
-- Remove foreign key constraints

ALTER TABLE [dbo].[BugHistory] DROP CONSTRAINT [FK_BugHistory_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugHistory
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugHistory'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_BugHistory]
    (
  [BugHistoryID] [int] NOT NULL IDENTITY (1, 1) ,
  [BugID] [int] NOT NULL ,
  [FieldChanged] [nvarchar] (50) NOT NULL ,
  [OldValue] [nvarchar] (50) NOT NULL ,
  [NewValue] [nvarchar] (50) NOT NULL ,
  [CreatedDate] [datetime] NOT NULL ,
  [CreatedUserId] [uniqueidentifier] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugHistory] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_BugHistory] ([BugHistoryID], [BugID], [FieldChanged], [OldValue], [NewValue], [CreatedDate],[CreatedUserId]) 
SELECT [BugHistoryID], [BugID], [FieldChanged], [OldValue], [NewValue], [CreatedDate],
(SELECT aspnet_users.UserId From aspnet_users join Users on BugHistory.UserId = Users.UserId where Users.Username = aspnet_users.username )
FROM [dbo].[BugHistory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugHistory] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[BugHistory]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[BugHistory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_BugHistory', 'BugHistory'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[BugHistory] WITH NOCHECK ADD  CONSTRAINT [PK__BugHistory__182C9B23] PRIMARY KEY CLUSTERED ([BugHistoryID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[BugHistory] WITH NOCHECK ADD CONSTRAINT [FK_BugHistory_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugHistory] CHECK CONSTRAINT [FK_BugHistory_Bug]
GO


/* Bug Notfication Table */
-- Remove foreign key constraints

ALTER TABLE [dbo].[BugNotification] DROP CONSTRAINT [FK_BugNotification_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNotification
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNotification'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_BugNotification]
    (
  [BugNotificationID] [int] NOT NULL IDENTITY (1, 1) ,
  [BugID] [int] NOT NULL ,
  [CreatedUserId] [uniqueidentifier] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugNotification] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_BugNotification] ([BugNotificationID], [BugID],[CreatedUserId]) SELECT [BugNotificationID], [BugID],
(SELECT aspnet_users.UserId From aspnet_users join Users on BugNotification.UserId = Users.UserId where Users.Username = aspnet_users.username )
FROM [dbo].[BugNotification]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugNotification] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[BugNotification]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[BugNotification]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_BugNotification', 'BugNotification'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[BugNotification] WITH NOCHECK ADD  CONSTRAINT [PK_BugNotification] PRIMARY KEY CLUSTERED ([BugNotificationID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[BugNotification] WITH NOCHECK ADD CONSTRAINT [FK_BugNotification_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugNotification] CHECK CONSTRAINT [FK_BugNotification_Bug]
GO

/* Bug Time Entry Table */
-- Remove foreign key constraints

ALTER TABLE [dbo].[BugTimeEntry] DROP CONSTRAINT [FK_BugTimeEntry_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugTimeEntry
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugTimeEntry'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_BugTimeEntry]
    (
  [BugTimeEntryId] [int] NOT NULL IDENTITY (1, 1) ,
  [BugId] [int] NOT NULL ,
  [WorkDate] [datetime] NOT NULL ,
  [Duration] [decimal] (4, 2) NOT NULL ,
  [BugCommentId] [int] NOT NULL ,
  [CreatedUserId] [uniqueidentifier] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugTimeEntry] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_BugTimeEntry] ([BugTimeEntryId], [BugId], [WorkDate], [Duration], [BugCommentId],[CreatedUserId])
SELECT [BugTimeEntryId], [BugId], [WorkDate], [Duration], [BugCommentId],
(SELECT aspnet_users.UserId From aspnet_users join Users on BugTimeEntry.UserId = Users.UserId where Users.Username = aspnet_users.username )
FROM [dbo].[BugTimeEntry]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_BugTimeEntry] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[BugTimeEntry]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[BugTimeEntry]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_BugTimeEntry', 'BugTimeEntry'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[BugTimeEntry] WITH NOCHECK ADD  CONSTRAINT [PK_BugTimeEntry] PRIMARY KEY CLUSTERED ([BugTimeEntryId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[BugTimeEntry] WITH NOCHECK ADD CONSTRAINT [FK_BugTimeEntry_Bug] FOREIGN KEY ([BugId])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[BugTimeEntry] CHECK CONSTRAINT [FK_BugTimeEntry_Bug]
GO

/* User Projects Table */

-- Remove foreign key constraints

ALTER TABLE [dbo].[UserProjects] DROP CONSTRAINT [FK_UserProjects_Users]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.UserProjects
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.UserProjects'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_UserProjects]
    (
  [UserId] [uniqueidentifier] NOT NULL ,
  [ProjectId] [int] NOT NULL ,
  [UserProjectId] [int] NOT NULL IDENTITY (1, 1) ,
  [CreatedDate] [datetime] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_UserProjects] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_UserProjects] ([UserId], [ProjectId], [UserProjectId], [CreatedDate]) 
SELECT (SELECT aspnet_users.UserId From aspnet_users join Users on UserProjects.UserId = Users.UserId where Users.Username = aspnet_users.username ), [ProjectId], [UserProjectId], [CreatedDate] FROM [dbo].[UserProjects]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_UserProjects] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[UserProjects]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[UserProjects]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_UserProjects', 'UserProjects'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[UserProjects] WITH NOCHECK ADD  CONSTRAINT [PK_UserProjects_1] PRIMARY KEY CLUSTERED ([UserId], [ProjectId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Project Table */
-- Remove foreign key constraints

ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Component] DROP CONSTRAINT [FK_Component_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectMailBox] DROP CONSTRAINT [FK_ProjectMailBox_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Version] DROP CONSTRAINT [FK_Version_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.Project
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Project'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Project]
DROP
  CONSTRAINT [DF_Project_Active]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Project]
    (
  [ProjectID] [int] NOT NULL IDENTITY (1, 1) ,
  [Name] [nvarchar] (50) NOT NULL ,
  [Code] [nvarchar] (3) NOT NULL ,
  [Description] [nvarchar] (80) NOT NULL ,
  [UploadPath] [nvarchar] (80) NOT NULL ,
  [CreateDate] [datetime] NOT NULL ,
  [Active] [int] NOT NULL ,
  [AccessType] [int] NOT NULL ,
  [ManagerUserID] [uniqueidentifier] NOT NULL ,
  [CreatorUserID] [uniqueidentifier] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from syscolumns where id=OBJECT_ID('[dbo].[tmp_sc_Project]') and name='Active' and cdefault>0) EXEC ('sp_unbindefault ''[dbo].[tmp_sc_Project].[Active]''')

ALTER TABLE [dbo].[tmp_sc_Project] WITH NOCHECK
ADD
 CONSTRAINT [DF_Project_Active] DEFAULT ((1)) FOR [Active]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Project] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Project] ([ProjectID], [Name], [Code], [Description], [UploadPath], [CreateDate], [Active], [AccessType], [CreatorUserID],[ManagerUserId]) 
SELECT [ProjectID], [Name], [Code], [Description], [UploadPath], [CreateDate], [Active], [AccessType], 
(SELECT aspnet_users.UserId From aspnet_users join Users on Project.CreatorUserId = Users.UserId where Users.Username = aspnet_users.username ),
(SELECT aspnet_users.UserId From aspnet_users join Users on Project.ManagerId = Users.UserId where Users.Username = aspnet_users.username )
 FROM [dbo].[Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Project] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Project]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Project', 'Project'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Project] WITH NOCHECK ADD  CONSTRAINT [PK__Product__1DE57479] PRIMARY KEY CLUSTERED ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Project] FOREIGN KEY ([ProjectID])  REFERENCES [dbo].[Project] ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectMailBox] WITH NOCHECK ADD CONSTRAINT [FK_ProjectMailBox_Project] FOREIGN KEY ([ProjectId])  REFERENCES [dbo].[Project] ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectMailBox] CHECK CONSTRAINT [FK_ProjectMailBox_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Version] WITH NOCHECK ADD CONSTRAINT [FK_Version_Project] FOREIGN KEY ([ProjectID])  REFERENCES [dbo].[Project] ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Version] CHECK CONSTRAINT [FK_Version_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Project Mailbox Table */
-- Remove foreign key constraints

ALTER TABLE [dbo].[ProjectMailBox] DROP CONSTRAINT [FK_ProjectMailBox_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.ProjectMailBox
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.ProjectMailBox'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_ProjectMailBox]
    (
  [ProjectMailboxId] [int] NOT NULL IDENTITY (1, 1) ,
  [MailBox] [nvarchar] (100) NOT NULL ,
  [ProjectId] [int] NOT NULL ,
  [AssignToUserId] [uniqueidentifier] NULL ,
  [IssueTypeId] [int] NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_ProjectMailBox] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_ProjectMailBox] ([ProjectMailboxId], [MailBox], [ProjectId], [AssignToUserId], [IssueTypeId]) 
SELECT [ProjectMailboxId], [MailBox], [ProjectId], (SELECT aspnet_users.UserId From aspnet_users join Users on ProjectMailBox.AssignToUserId = Users.UserId where Users.Username = aspnet_users.username ), [IssueTypeId] 
FROM [dbo].[ProjectMailBox]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_ProjectMailBox] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[ProjectMailBox]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[ProjectMailBox]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_ProjectMailBox', 'ProjectMailBox'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[ProjectMailBox] WITH NOCHECK ADD  CONSTRAINT [PK_ProjectMailBox] PRIMARY KEY CLUSTERED ([ProjectMailboxId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[ProjectMailBox] WITH NOCHECK ADD CONSTRAINT [FK_ProjectMailBox_Project] FOREIGN KEY ([ProjectId])  REFERENCES [dbo].[Project] ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectMailBox] CHECK CONSTRAINT [FK_ProjectMailBox_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Component Table */
--
-- Script for dbo.Component
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Component'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Component]
DROP
  CONSTRAINT [DF_Component_ParentComponentID]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Component]
    (
  [ComponentID] [int] NOT NULL IDENTITY (1, 1) ,
  [ProjectID] [int] NOT NULL ,
  [Name] [nvarchar] (50) NOT NULL ,
  [ParentComponentID] [int] NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from syscolumns where id=OBJECT_ID('[dbo].[tmp_sc_Component]') and name='ParentComponentID' and cdefault>0) EXEC ('sp_unbindefault ''[dbo].[tmp_sc_Component].[ParentComponentID]''')

ALTER TABLE [dbo].[tmp_sc_Component] WITH NOCHECK
ADD
 CONSTRAINT [DF_Component_ParentComponentID] DEFAULT ((0)) FOR [ParentComponentID]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Component] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Component] ([ComponentID], [ProjectID], [Name], [ParentComponentID]) SELECT [ComponentID], [ProjectID], [Name], [ParentComponentID] FROM [dbo].[Component]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Component] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Component]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Component]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Component', 'Component'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Component] WITH NOCHECK ADD  CONSTRAINT [PK__Component__09DE7BCC] PRIMARY KEY CLUSTERED ([ComponentID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


/* Log Table */
--
-- Script for dbo.Log
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Log'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[Log]
    (
  [Id] [int] NOT NULL IDENTITY (1, 1) ,
  [Date] [datetime] NOT NULL ,
  [Thread] [varchar] (255) NOT NULL ,
  [Level] [varchar] (50) NOT NULL ,
  [Logger] [varchar] (255) NOT NULL ,
  [User] [nvarchar] (50) NOT NULL ,
  [Message] [varchar] (4000) NOT NULL ,
  [Exception] [varchar] (2000) NULL 
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Permission Table */

-- Remove foreign key constraints

ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Permission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.Permission
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Permission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Permission]
    (
  [PermissionId] [int] NOT NULL ,
  [PermissionKey] [nvarchar] (50) NOT NULL ,
  [Name] [nvarchar] (50) NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Permission] ([PermissionId], [PermissionKey], [Name]) SELECT [PermissionId], [PermissionKey], [Name] FROM [dbo].[Permission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Permission]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Permission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Permission', 'Permission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Permission] WITH NOCHECK ADD  CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED ([PermissionId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[RolePermission] WITH NOCHECK ADD CONSTRAINT [FK_RolePermission_Permission] FOREIGN KEY ([PermissionId])  REFERENCES [dbo].[Permission] ([PermissionId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Permission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Role Permission Table */

-- Remove foreign key constraints

ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Permission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Roles]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.RolePermission
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.RolePermission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_RolePermission]
    (
  [RolePermissionId] [int] NOT NULL IDENTITY (1, 1) ,
  [RoleId] [uniqueidentifier] NOT NULL ,
  [PermissionId] [int] NOT NULL 
)

if exists (select * from sysobjects where id=object_id('[dbo].[RolePermission]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[RolePermission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_RolePermission', 'RolePermission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[RolePermission] WITH NOCHECK ADD  CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED ([RolePermissionId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[RolePermission] WITH NOCHECK ADD CONSTRAINT [FK_RolePermission_Permission] FOREIGN KEY ([PermissionId])  REFERENCES [dbo].[Permission] ([PermissionId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Permission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Priority Table */

-- Remove foreign key constraints

ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Priority]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.Priority
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Priority'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Priority]
    (
  [PriorityID] [int] NOT NULL IDENTITY (1, 1) ,
  [Name] [nvarchar] (50) NOT NULL ,
  [ImageUrl] [nvarchar] (50) NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Priority] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Priority] ([PriorityID], [Name], [ImageUrl]) SELECT [PriorityID], [Name], [ImageUrl] FROM [dbo].[Priority]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Priority] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Priority]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Priority]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Priority', 'Priority'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Priority] WITH NOCHECK ADD  CONSTRAINT [PK__Priority__07F6335A] PRIMARY KEY CLUSTERED ([PriorityID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Priority] FOREIGN KEY ([PriorityID])  REFERENCES [dbo].[Priority] ([PriorityID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Priority]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Custom Fields Tables */
--
-- Script for dbo.ProjectCustomFields
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.ProjectCustomFields'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[ProjectCustomFields]
    (
  [CustomFieldId] [int] NOT NULL IDENTITY (1, 1) ,
  [ProjectId] [int] NOT NULL ,
  [CustomFieldName] [nvarchar] (50) NOT NULL ,
  [CustomFieldRequired] [bit] NOT NULL ,
  [CustomFieldDataType] [int] NOT NULL ,
  [CustomFieldTypeId] [int] NOT NULL 
)



ALTER TABLE [dbo].[ProjectCustomFields] WITH NOCHECK ADD  CONSTRAINT [PK_ProjectCustomFields] PRIMARY KEY CLUSTERED ([CustomFieldId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.ProjectCustomFieldSelection
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.ProjectCustomFieldSelection'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[ProjectCustomFieldSelection]
    (
  [CustomFieldSelectionId] [int] NOT NULL IDENTITY (1, 1) ,
  [CustomFieldId] [int] NOT NULL ,
  [CustomFieldSelectionValue] [nchar] (255) NOT NULL ,
  [CustomFieldSelectionName] [nchar] (255) NOT NULL ,
  [CustomFieldSelectionSortOrder] [int] NOT NULL 
)



ALTER TABLE [dbo].[ProjectCustomFieldSelection] ADD CONSTRAINT [DF_ProjectCustomFieldSelection_CustomFieldSelectionSortOrder] DEFAULT ((0)) FOR [CustomFieldSelectionSortOrder]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

ALTER TABLE [dbo].[ProjectCustomFieldSelection] WITH NOCHECK ADD  CONSTRAINT [PK_ProjectCustomFieldSelection] PRIMARY KEY CLUSTERED ([CustomFieldSelectionId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.ProjectCustomFieldType
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.ProjectCustomFieldType'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[ProjectCustomFieldType]
    (
  [CustomFieldTypeId] [int] NOT NULL IDENTITY (1, 1) ,
  [CustomFieldTypeName] [nvarchar] (50) NOT NULL 
)



ALTER TABLE [dbo].[ProjectCustomFieldType] WITH NOCHECK ADD  CONSTRAINT [PK_ProjectCustomFieldType] PRIMARY KEY CLUSTERED ([CustomFieldTypeId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.ProjectCustomFieldValues
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.ProjectCustomFieldValues'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[ProjectCustomFieldValues]
    (
  [CustomFieldValueId] [int] NOT NULL IDENTITY (1, 1) ,
  [BugId] [int] NOT NULL ,
  [CustomFieldId] [int] NOT NULL ,
  [CustomFieldValue] [ntext] NOT NULL 
)



ALTER TABLE [dbo].[ProjectCustomFieldValues] WITH NOCHECK ADD  CONSTRAINT [PK_ProjectCustomFieldValues] PRIMARY KEY CLUSTERED ([CustomFieldValueId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[ProjectCustomFields] WITH NOCHECK ADD CONSTRAINT [FK_ProjectCustomFields_Project] FOREIGN KEY ([ProjectId])  REFERENCES [dbo].[Project] ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFields] CHECK CONSTRAINT [FK_ProjectCustomFields_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFields] WITH NOCHECK ADD CONSTRAINT [FK_ProjectCustomFields_ProjectCustomFieldType] FOREIGN KEY ([CustomFieldTypeId])  REFERENCES [dbo].[ProjectCustomFieldType] ([CustomFieldTypeId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFields] CHECK CONSTRAINT [FK_ProjectCustomFields_ProjectCustomFieldType]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFieldSelection] WITH NOCHECK ADD CONSTRAINT [FK_ProjectCustomFieldSelection_ProjectCustomFields] FOREIGN KEY ([CustomFieldId])  REFERENCES [dbo].[ProjectCustomFields] ([CustomFieldId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFieldSelection] CHECK CONSTRAINT [FK_ProjectCustomFieldSelection_ProjectCustomFields]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFieldValues] WITH NOCHECK ADD CONSTRAINT [FK_ProjectCustomFieldValues_Bug] FOREIGN KEY ([BugId])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFieldValues] CHECK CONSTRAINT [FK_ProjectCustomFieldValues_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFieldValues] WITH NOCHECK ADD CONSTRAINT [FK_ProjectCustomFieldValues_ProjectCustomFields] FOREIGN KEY ([CustomFieldId])  REFERENCES [dbo].[ProjectCustomFields] ([CustomFieldId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectCustomFieldValues] CHECK CONSTRAINT [FK_ProjectCustomFieldValues_ProjectCustomFields]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Remaining Tables */
-- Remove foreign key constraints

ALTER TABLE [dbo].[RelatedBug] DROP CONSTRAINT [FK_RelatedBug_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Resolution]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Status]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Type]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Version] DROP CONSTRAINT [FK_Version_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.ProjectRoles
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.ProjectRoles'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[ProjectRoles]
    (
  [ProjectRoleId] [int] NOT NULL IDENTITY (1, 1) ,
  [RoleId] [uniqueidentifier] NOT NULL ,
  [ProjectId] [int] NOT NULL ,
  [CreatedDate] [datetime] NOT NULL 
)



ALTER TABLE [dbo].[ProjectRoles] WITH NOCHECK ADD  CONSTRAINT [PK_ProjectRoles] PRIMARY KEY CLUSTERED ([ProjectRoleId]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.RelatedBug
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.RelatedBug'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_RelatedBug]
    (
  [RelatedBugID] [int] NOT NULL IDENTITY (1, 1) ,
  [BugID] [int] NOT NULL ,
  [LinkedBugID] [int] NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_RelatedBug] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_RelatedBug] ([RelatedBugID], [BugID], [LinkedBugID]) SELECT [RelatedBugID], [BugID], [LinkedBugID] FROM [dbo].[RelatedBug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_RelatedBug] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[RelatedBug]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[RelatedBug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_RelatedBug', 'RelatedBug'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[RelatedBug] WITH NOCHECK ADD  CONSTRAINT [PK_BugRelation] PRIMARY KEY CLUSTERED ([RelatedBugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.Resolution
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Resolution'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Resolution]
    (
  [ResolutionID] [int] NOT NULL IDENTITY (1, 1) ,
  [Name] [nvarchar] (50) NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Resolution] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Resolution] ([ResolutionID], [Name]) SELECT [ResolutionID], [Name] FROM [dbo].[Resolution]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Resolution] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Resolution]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Resolution]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Resolution', 'Resolution'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Resolution] WITH NOCHECK ADD  CONSTRAINT [PK__Resolution__00551192] PRIMARY KEY CLUSTERED ([ResolutionID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.Status
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Status'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Status]
    (
  [StatusID] [int] NOT NULL IDENTITY (1, 1) ,
  [Name] [nvarchar] (50) NOT NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Status] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Status] ([StatusID], [Name]) SELECT [StatusID], [Name] FROM [dbo].[Status]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Status] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Status]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Status]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Status', 'Status'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Status] WITH NOCHECK ADD  CONSTRAINT [PK__Status__023D5A04] PRIMARY KEY CLUSTERED ([StatusID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.Type
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Type'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Type]
    (
  [TypeID] [int] NOT NULL IDENTITY (1, 1) ,
  [Name] [nvarchar] (50) NOT NULL ,
  [ImageUrl] [nvarchar] (50) NULL 
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Type] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Type] ([TypeID], [Name], [ImageUrl]) SELECT [TypeID], [Name], [ImageUrl] FROM [dbo].[Type]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Type] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Type]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Type]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Type', 'Type'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Type] WITH NOCHECK ADD  CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED ([TypeID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.Version
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Version'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE TABLE [dbo].[tmp_sc_Version]
    (
  [VersionID] [int] NOT NULL IDENTITY (1, 1) ,
  [ProjectID] [int] NOT NULL ,
  [Name] [nvarchar] (50) NOT NULL ,
  [SortOrder] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Version] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_sc_Version] ([VersionID], [ProjectID], [Name],[SortOrder]) SELECT [VersionID], [ProjectID], [Name],[VersionID] FROM [dbo].[Version]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_sc_Version] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

if exists (select * from sysobjects where id=object_id('[dbo].[Version]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Version]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


sp_rename 'dbo.tmp_sc_Version', 'Version'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


ALTER TABLE [dbo].[Version] WITH NOCHECK ADD  CONSTRAINT [PK__Version__0425A276] PRIMARY KEY CLUSTERED ([VersionID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Add foreign key constraints

ALTER TABLE [dbo].[ProjectRoles] WITH NOCHECK ADD CONSTRAINT [FK_ProjectRoles_Project] FOREIGN KEY ([ProjectId])  REFERENCES [dbo].[Project] ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ProjectRoles] CHECK CONSTRAINT [FK_ProjectRoles_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[RelatedBug] WITH NOCHECK ADD CONSTRAINT [FK_RelatedBug_Bug] FOREIGN KEY ([BugID])  REFERENCES [dbo].[Bug] ([BugID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[RelatedBug] CHECK CONSTRAINT [FK_RelatedBug_Bug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Resolution] FOREIGN KEY ([ResolutionID])  REFERENCES [dbo].[Resolution] ([ResolutionID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Resolution]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Status] FOREIGN KEY ([StatusID])  REFERENCES [dbo].[Status] ([StatusID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Status]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] WITH NOCHECK ADD CONSTRAINT [FK_Bug_Type] FOREIGN KEY ([TypeID])  REFERENCES [dbo].[Type] ([TypeID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_Bug_Type]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Version] WITH NOCHECK ADD CONSTRAINT [FK_Version_Project] FOREIGN KEY ([ProjectID])  REFERENCES [dbo].[Project] ([ProjectID]) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[Version] CHECK CONSTRAINT [FK_Version_Project]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


/* Stored Procs & Views */

--
-- Script for dbo.BugsView
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugsView'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugsView]') and OBJECTPROPERTY(id, 'IsView')=1)
  drop view [dbo].[BugsView]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* Handles 'unassigned' version 
*/
CREATE VIEW [dbo].[BugsView]
AS
SELECT     dbo.Bug.BugID, dbo.Bug.Summary, dbo.Bug.Description, dbo.Bug.ReportedDate, dbo.Bug.StatusID, dbo.Bug.PriorityID, dbo.Bug.TypeID, 
                      dbo.Bug.ComponentID, dbo.Bug.ProjectID, dbo.Bug.ResolutionID, dbo.Bug.VersionID, dbo.Bug.LastUpdate, dbo.Bug.ReporterUserId, 
                      dbo.Bug.AssignedToUserId, dbo.Bug.LastUpdateUserId, dbo.Status.Name AS StatusName, ISNULL(dbo.Component.Name, 'All Components') 
                      AS ComponentName, dbo.Priority.Name AS PriorityName, dbo.Project.Name AS ProjectName, dbo.Project.Code AS ProjectCode, 
                      dbo.Resolution.Name AS ResolutionName, dbo.Type.Name AS TypeName, ISNULL(dbo.Version.Name, 'Unassigned') AS VersionName, 
                      LastUpdateUsers.UserName AS LastUpdateUserName, ReportedUsers.UserName AS ReporterUserName, ISNULL(AssignedUsers.UserName, 
                      'Unassigned') AS AssignedToUserName, dbo.Bug.DueDate, dbo.Bug.FixedInVersionId, ISNULL(FixedInVersion.Name, 'Unassigned') 
                      AS FixedInVersionName, dbo.Bug.Visibility
FROM         dbo.Bug LEFT OUTER JOIN
                      dbo.Component ON dbo.Bug.ComponentID = dbo.Component.ComponentID LEFT OUTER JOIN
                      dbo.Priority ON dbo.Bug.PriorityID = dbo.Priority.PriorityID LEFT OUTER JOIN
                      dbo.Project ON dbo.Bug.ProjectID = dbo.Project.ProjectID LEFT OUTER JOIN
                      dbo.Resolution ON dbo.Bug.ResolutionID = dbo.Resolution.ResolutionID LEFT OUTER JOIN
                      dbo.Status ON dbo.Bug.StatusID = dbo.Status.StatusID LEFT OUTER JOIN
                      dbo.Type ON dbo.Bug.TypeID = dbo.Type.TypeID LEFT OUTER JOIN
                      dbo.Version ON dbo.Bug.VersionID = dbo.Version.VersionID LEFT OUTER JOIN
                      dbo.aspnet_Users AS AssignedUsers ON dbo.Bug.AssignedToUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS ReportedUsers ON dbo.Bug.ReporterUserId = ReportedUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS LastUpdateUsers ON dbo.Bug.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                      dbo.Version AS FixedInVersion ON dbo.Bug.FixedInVersionId = FixedInVersion.VersionID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_ApplicationLog_ClearLog
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_ApplicationLog_ClearLog'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_ClearLog] 
	
AS
	DELETE FROM Log

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_ApplicationLog_GetLog
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_ApplicationLog_GetLog'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_GetLog] 
	
AS
	SELECT * FROM Log

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Attachment_CreateNewAttachment
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Attachment_CreateNewAttachment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Attachment_CreateNewAttachment]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Attachment_CreateNewAttachment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Attachment_CreateNewAttachment]
  @BugId int,
  @FileName nvarchar(100),
  @Description nvarchar(80),
  @FileSize Int,
  @ContentType nvarchar(50),
  @UploadedUserName nvarchar(255)
AS
-- Get Uploaded UserID
DECLARE @UploadedUserId UniqueIdentifier
SELECT @UploadedUserId = UserId FROM aspnet_users WHERE Username = @UploadedUserName
	INSERT BugAttachment
	(
		BugID,
		FileName,
		Description,
		FileSize,
		Type,
		UploadedDate,
		UploadedUserId
	)
	VALUES
	(
		@BugId,
		@FileName,
		@Description,
		@FileSize,
		@ContentType,
		GetDate(),
		@UploadedUserId
	)
	RETURN @@IDENTITY
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Attachment_DeleteAttachment
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Attachment_DeleteAttachment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Attachment_DeleteAttachment]
	@AttachmentId Int
AS
DELETE 
	BugAttachment
WHERE
	BugAttachmentId = @AttachmentId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Attachment_GetAttachmentById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Attachment_GetAttachmentById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Attachment_GetAttachmentById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Attachment_GetAttachmentById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Attachment_GetAttachmentById]
 @AttachmentId INT
AS
SELECT
	BugAttachmentId,
	BugId,
	FileName,
	Description,
	FileSize,
	Type,
	UploadedDate,
	UploadedUserId,
	Creators.UserName CreatorUserName
FROM 
	BugAttachment
	INNER JOIN aspnet_users Creators ON Creators.UserId = BugAttachment.UploadedUserId
WHERE
	BugAttachmentId = @AttachmentId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Attachment_GetAttachmentsByBugId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Attachment_GetAttachmentsByBugId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Attachment_GetAttachmentsByBugId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Attachment_GetAttachmentsByBugId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Attachment_GetAttachmentsByBugId]
 @BugId INT
AS

SELECT
	BugAttachmentId,
	BugId,
	FileName,
	Description,
	FileSize,
	Type,
	UploadedDate,
	UploadedUserId,
	Creators.UserName CreatorUserName
FROM 
	BugAttachment
	INNER JOIN aspnet_users Creators ON Creators.UserId = BugAttachment.UploadedUserId
WHERE
	BugId = @BugId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_CreateNewBug
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_CreateNewBug'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_CreateNewBug]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_CreateNewBug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_CreateNewBug]
  @Summary nvarchar(500),
  @Description ntext,
  @ProjectId Int,
  @ComponentId Int,
  @StatusId Int,
  @PriorityId Int,
  @VersionId Int,
  @TypeId Int,
  @ResolutionId Int,
  @AssignedToUserName NVarChar(255),
  @ReporterUserName NVarChar(255),
  @DueDate datetime,
  @FixedInVersionId int,
  @Visibility int
AS
DECLARE @newIssueId Int
-- Get Reporter UserID
DECLARE @AssignedToUserId	UNIQUEIDENTIFIER
DECLARE @ReporterUserId		UNIQUEIDENTIFIER

SELECT @AssignedToUserId = UserId FROM aspnet_users WHERE Username = @AssignedToUserName
SELECT @ReporterUserId = UserId FROM aspnet_users WHERE Username = @ReporterUserName

	INSERT Bug
	(
		Summary,
		Description,
		ReporterUserId,
		ReportedDate,
		StatusId,
		PriorityId,
		TypeId,
		ComponentId,
		AssignedToUserId,
		ProjectId,
		ResolutionId,
		VersionId,
		LastUpdateUserId,
		LastUpdate,
		DueDate,
		FixedInVersionId,
		Visibility
	)
	VALUES
	(
		@Summary,
		@Description,
		@ReporterUserId,
		GetDate(),
		@StatusId,
		@PriorityId,
		@TypeId,
		@ComponentId,
		@AssignedToUserId,
		@ProjectId,
		@ResolutionId,
		@VersionId,
		@ReporterUserId,
		GetDate(),
		@DueDate,
		@FixedInVersionId,
		@Visibility
	)
RETURN scope_identity()
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_Delete
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_Delete'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_Delete]
	@BugId Int
AS
DELETE 
	Bug
WHERE
	BugId = @BugId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Bug_GetBugById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugById] 
  @BugId Int
AS
SELECT 
	*
FROM 
	BugsView
WHERE
	BugId = @BugId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugComponentCountByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugComponentCountByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugComponentCountByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugComponentCountByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugComponentCountByProject]
 @ProjectId int,
 @ComponentId int
AS
	SELECT     Count(BugId) From Bug Where ProjectId = @ProjectId 
	AND ComponentId = @ComponentId AND StatusId <> 4 AND StatusId <> 5

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugPriorityCountByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugPriorityCountByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugPriorityCountByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugPriorityCountByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugPriorityCountByProject]
 @ProjectId int
AS
	SELECT p.Name, COUNT(nt.PriorityID) AS Number, p.PriorityID 
	FROM   Priority p 
	LEFT OUTER JOIN (SELECT  PriorityID, ProjectID FROM   
	Bug b WHERE  (b.StatusID <> 4) AND (b.StatusID <> 5)) nt 
	ON p.PriorityID = nt.PriorityID AND nt.ProjectID = @ProjectId
	GROUP BY p.Name, p.PriorityID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugsByCriteria
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugsByCriteria'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugsByCriteria]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugsByCriteria]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugsByCriteria]
(
    @ProjectId int = NULL,
    @ComponentId int = NULL,
    @VersionId int = NULL,
    @PriorityId int = NULL,
    @TypeId int = NULL,
    @ResolutionId int = NULL,
    @StatusId int = NULL,
    @AssignedToUserName nvarchar(256) = NULL,
    @Keywords nvarchar(256) = NULL,
    @IncludeComments bit = NULL,
    @ReporterUserName nvarchar(255) = NULL,
    @FixedInVersionId int = NULL
)
AS
  
DECLARE @AssignedToUserId UNIQUEIDENTIFIER
SELECT @AssignedToUserId = UserId FROM aspnet_users WHERE Username = @AssignedToUserName
DECLARE @ReporterUserId UNIQUEIDENTIFIER
SELECT @ReporterUserId = UserId FROM aspnet_users WHERE Username = @ReporterUserName


  
IF @StatusId = 0

 SELECT
    *
FROM
    BugsView 
WHERE  
((@ProjectId IS NULL) OR (ProjectId = @ProjectId)) AND
    ((@ComponentId IS NULL) OR (ComponentId = @ComponentId)) AND
    ((@VersionId IS NULL) OR (VersionId = @VersionId)) AND
    ((@FixedInVersionId IS NULL) OR (FixedInVersionId = @FixedInVersionId)) AND
    ((@PriorityId IS NULL) OR (PriorityId = @PriorityId))AND
    ((@TypeId IS NULL) OR (TypeId = @TypeId)) AND
    ((@ResolutionId IS NULL) OR (ResolutionId = @ResolutionId)) AND
    ((@StatusId IS NULL) OR (StatusId In (1,2,3))) AND
    ((@ReporterUserId IS NULL) OR (ReporterUserId = @ReporterUserId)) AND
    ((@Keywords IS NULL) OR (Description LIKE '%' + @Keywords + '%' )  OR (Summary LIKE '%' + @Keywords + '%' ) ) AND
    ((@AssignedToUserName IS NULL) OR (@AssignedToUserName = '-1' AND AssignedToUserId IS NULL) 
    OR (AssignedToUserId IS NOT NULL AND AssignedToUserId = @AssignedToUserId))
 ORDER BY PriorityId ASC
 
ELSE

SELECT
    *
FROM
    BugsView
WHERE
    ((@ProjectId IS NULL) OR (ProjectId = @ProjectId)) AND
    ((@ComponentId IS NULL) OR (ComponentId = @ComponentId)) AND
    ((@VersionId IS NULL) OR (VersionId = @VersionId)) AND
    ((@FixedInVersionId IS NULL) OR (FixedInVersionId = @FixedInVersionId)) AND
    ((@PriorityId IS NULL) OR (PriorityId = @PriorityId))AND
    ((@TypeId IS NULL) OR (TypeId = @TypeId)) AND
    ((@ResolutionId IS NULL) OR (ResolutionId = @ResolutionId)) AND
    ((@StatusId IS NULL) OR (StatusId = @StatusId)) AND
    ((@AssignedToUserName IS NULL) OR (@AssignedToUserName = '-1' AND AssignedToUserId IS NULL) 
    OR (AssignedToUserId IS NOT NULL AND AssignedToUserId = @AssignedToUserId)) AND
    ((@ReporterUserId IS NULL) OR (ReporterUserId = @ReporterUserId)) AND
    ((@Keywords IS NULL) OR (Description LIKE '%' + @Keywords + '%' )  OR (Summary LIKE '%' + @Keywords + '%' ))
  ORDER BY PriorityId ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugsByProjectId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugsByProjectId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugsByProjectId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugsByProjectId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugsByProjectId]
	@ProjectId int
As
Select * from BugsView WHERE ProjectId = @ProjectId
Order By PriorityId,StatusId ASC

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugStatusCountByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugStatusCountByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugStatusCountByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugStatusCountByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugStatusCountByProject]
 @ProjectId int
AS
	SELECT s.Name,Count(b.StatusID) as 'Number',s.StatusID 
	From Status s 
	LEFT JOIN Bug b on s.StatusID = b.StatusID AND b.ProjectID = @ProjectId 
	Group BY s.Name,s.StatusID Order By s.StatusID ASC

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugTypeCountByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugTypeCountByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugTypeCountByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugTypeCountByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugTypeCountByProject]
	@ProjectId int
AS
	SELECT     t.Name, COUNT(nt.TypeID) AS Number, t.TypeID, t.ImageUrl
	FROM  Type t 
	LEFT OUTER JOIN (SELECT TypeID, ProjectID 
	FROM Bug b WHERE (b.StatusID <> 4) 
	AND (b.StatusID <> 5)) nt 
	ON t.TypeID = nt.TypeID 
	AND nt.ProjectID = @ProjectId
	GROUP BY t.Name, t.TypeID,t.ImageUrl


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugUnassignedCountByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugUnassignedCountByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugUnassignedCountByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugUnassignedCountByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugUnassignedCountByProject]
 @ProjectId int
AS
	SELECT     COUNT(BugID) AS Number 
	FROM Bug 
	WHERE (AssignedToUserId IS NULL) 
		AND (ProjectID = @ProjectId) 
		AND (StatusID <> 4) 
		AND (StatusID <> 5)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugUserCountByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugUserCountByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugUserCountByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugUserCountByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugUserCountByProject]
 @ProjectId int
AS
	SELECT u.UserID,u.Username, COUNT(b.BugID) AS Number FROM UserProjects pm 
	LEFT OUTER JOIN aspnet_Users u ON pm.UserId = u.UserId 
	LEFT OUTER JOIN Bug b ON b.AssignedToUserId = u.UserId
	WHERE (pm.ProjectID = @ProjectId) 
	 AND (b.ProjectID = @ProjectId ) 
	 AND (b.StatusID <> 4) 
	 AND (b.StatusID <> 5)  
	 GROUP BY u.Username, u.UserID
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetBugVersionCountByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetBugVersionCountByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetBugVersionCountByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetBugVersionCountByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetBugVersionCountByProject]
	@ProjectId int
AS
	SELECT v.Name, COUNT(nt.VersionID) AS Number, v.VersionID 
	FROM Version v 
	LEFT OUTER JOIN (SELECT VersionID  
	FROM Bug b  
	WHERE (b.StatusID <> 4) AND (b.StatusID <> 5)) nt ON v.VersionID = nt.VersionID 
	WHERE (v.ProjectID = @ProjectId) 
	GROUP BY v.Name, v.VersionID,v.SortOrder
	ORDER BY v.SortOrder ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetChangeLog
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetChangeLog'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetChangeLog]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetChangeLog]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetChangeLog] 
	@ProjectId int
AS

Select * from BugsView WHERE ProjectId = @ProjectId  AND StatusID = 5
Order By FixedInVersionId DESC,ComponentName ASC, TypeName ASC, AssignedToUserName ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetMonitoredBugsByUser
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetMonitoredBugsByUser'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetMonitoredBugsByUser]
  @UserName nvarchar(255)
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT 
	*
FROM 
	BugsView
	
	INNER JOIN BugNotification on BugsView.BugId = BugNotification.BugId
	AND BugNotification.CreatedUserId = @UserId
	WHERE StatusId In (1,2,3)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Bug_GetRecentlyAddedBugsByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetRecentlyAddedBugsByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_GetRecentlyAddedBugsByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_GetRecentlyAddedBugsByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetRecentlyAddedBugsByProject]
	@ProjectId int
AS
SELECT TOP 5
	*
FROM 
	BugsView
WHERE
	ProjectId = @ProjectId
ORDER BY BugID DESC

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Bug_GetRoadMap
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetRoadMap'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetRoadMap]
	@ProjectId int
AS


Select * from BugsView 
WHERE ProjectId = @ProjectId  
AND FixedInVersionId <> -1 
Order By FixedInVersionId DESC,StatusID ASC,ComponentName ASC, TypeName ASC, AssignedToUserName ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Bug_GetRoadMapProgress
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_GetRoadMapProgress'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_GetRoadMapProgress]
	@ProjectId int,
	@FixedInVersionId int
AS
	/* SET NOCOUNT ON */ 
SELECT (SELECT Count(*) from BugsView 
WHERE ProjectId = @ProjectId AND FixedInVersionId = @FixedInVersionId AND StatusId In (4,5)
AND FixedInVersionId <> -1) As ClosedCount , (SELECT Count(*) from BugsView 
WHERE ProjectId = @ProjectId AND FixedInVersionId = @FixedInVersionId  
AND FixedInVersionId <> -1) As TotalCount


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Bug_UpdateBug
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Bug_UpdateBug'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Bug_UpdateBug]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Bug_UpdateBug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Bug_UpdateBug]
  @BugId Int,
  @Summary nvarchar(500),
  @Description ntext,
  @ProjectId Int,
  @ComponentId Int,
  @StatusId Int,
  @PriorityId Int,
  @VersionId Int,
  @TypeId Int,
  @ResolutionId Int,
  @AssignedToUserName nvarchar(255),
  @LastUpdateUserName NVarChar(255),
  @DueDate datetime,
  @FixedInVersionId int,
  @Visibility int
AS
DECLARE @newIssueId Int
-- Get Last Update UserID
DECLARE @LastUpdateUserId UniqueIdentifier
DECLARE @AssignedToUserId UniqueIdentifier

SELECT @LastUpdateUserId = UserId FROM aspnet_users WHERE UserName = @LastUpdateUserName
SELECT @AssignedToUserId = UserId FROM aspnet_users WHERE UserName = @AssignedToUserName

	Update Bug Set
		Summary = @Summary,
		Description = @Description,
		StatusID =@StatusId,
		PriorityID =@PriorityId,
		TypeId = @TypeId,
		ComponentID = @ComponentId,
		AssignedToUserId=@AssignedToUserId,
		ProjectId =@ProjectId,
		ResolutionId =@ResolutionId,
		VersionId =@VersionId,
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate(),
		DueDate = @DueDate,
		FixedInVersionId = @FixedInVersionId,
		Visibility = @Visibility
	WHERE 
		BugId = @BugId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_BugNotification_CreateNewBugNotification
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_BugNotification_CreateNewBugNotification'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_BugNotification_CreateNewBugNotification]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_BugNotification_CreateNewBugNotification]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_BugNotification_CreateNewBugNotification]
	@BugId Int,
	@NotificationUsername NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @NotificationUsername
IF NOT EXISTS( SELECT BugNotificationId FROM BugNotification WHERE CreatedUserId = @UserId AND BugId = @BugId)
BEGIN
	INSERT BugNotification
	(
		BugId,
		CreatedUserId
	)
	VALUES
	(
		@BugId,
		@UserId
	)
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_BugNotification_DeleteBugNotification
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_BugNotification_DeleteBugNotification'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_BugNotification_DeleteBugNotification]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_BugNotification_DeleteBugNotification]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_BugNotification_DeleteBugNotification]
	@BugId Int,
	@Username NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @Username
DELETE 
	BugNotification
WHERE
	BugId = @BugId
	AND CreatedUserId = @UserId 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_BugNotification_GetBugNotificationsByBugId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_BugNotification_GetBugNotificationsByBugId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_BugNotification_GetBugNotificationsByBugId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_BugNotification_GetBugNotificationsByBugId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_BugNotification_GetBugNotificationsByBugId] 
	@BugId Int
AS
SELECT 
	BugNotificationId,
	BugId,
	Username NotificationUsername,
	Membership.Email NotificationEmail
FROM
	BugNotification
	INNER JOIN aspnet_Users Users ON BugNotification.CreatedUserId = Users.UserId
	INNER JOIN aspnet_membership Membership on BugNotification.CreatedUserId = Membership.UserId
WHERE
	BugId = @BugId
ORDER BY
	Username

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Comment_CreateNewComment
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Comment_CreateNewComment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Comment_CreateNewComment]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Comment_CreateNewComment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Comment_CreateNewComment]
	@BugId int,
	@CreatorUserName NVarChar(255),
	@Comment ntext
AS
-- Get Last Update UserID
DECLARE @CreatorUserId uniqueidentifier
SELECT @CreatorUserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
INSERT BugComment
(
	BugId,
	CreatedUserId,
	CreatedDate,
	Comment
) 
VALUES 
(
	@BugId,
	@CreatorUserId,
	GetDate(),
	@Comment
)

/* Update the LastUpdate fields of this bug*/
UPDATE Bug SET LastUpdate = GetDate(),LastUpdateUserId = @CreatorUserId WHERE BugId = @BugId

RETURN @@IDENTITY
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Comment_DeleteComment
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Comment_DeleteComment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Comment_DeleteComment]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Comment_DeleteComment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Comment_DeleteComment]
	@BugCommentId Int
AS
DELETE 
	BugComment
WHERE
	BugCommentId = @BugCommentId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Comment_GetCommentById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Comment_GetCommentById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Comment_GetCommentById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Comment_GetCommentById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Comment_GetCommentById]
 @BugCommentId INT
AS
SELECT
	BugCommentId,
	BugId,
	BugComment.CreatedUserId,
	CreatedDate,
	BugComment.Comment,
	Creators.UserName CreatorUserName,
	Membership.Email CreatorEmail
FROM 
	BugComment
	INNER JOIN aspnet_users Creators ON Creators.UserId = BugComment.CreatedUserId	
	INNER JOIN aspnet_membership Membership on Creators.UserId = Membership.UserId
WHERE
	BugCommentId = @BugCommentId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Comment_GetCommentsByBugId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Comment_GetCommentsByBugId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Comment_GetCommentsByBugId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Comment_GetCommentsByBugId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Comment_GetCommentsByBugId]
 @BugId INT
AS
SELECT
	BugCommentId,
	BugId,
	BugComment.CreatedUserId,
	CreatedDate,
	BugComment.Comment,
	Creators.UserName CreatorUserName,
	Membership.Email CreatorEmail
FROM 
	BugComment
	INNER JOIN aspnet_users Creators ON Creators.UserId = BugComment.CreatedUserId
	INNER JOIN aspnet_membership Membership on Creators.UserId = Membership.UserId	
WHERE
	BugId = @BugId
ORDER BY 
	CreatedDate DESC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Comment_UpdateComment
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Comment_UpdateComment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Comment_UpdateComment]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Comment_UpdateComment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Comment_UpdateComment]
	@BugCommentId int,
	@BugId int,
	@CreatorUserName nvarchar(255),
	@Comment ntext
AS

DECLARE @CreatorUserId uniqueidentifier
SELECT @CreatorUserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName

UPDATE BugComment SET
	BugId = @BugId,
	CreatedUserId = @CreatorUserId,
	Comment = @Comment
WHERE BugCommentId= @BugCommentId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Component_CreateNewComponent
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Component_CreateNewComponent'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Component_CreateNewComponent]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Component_CreateNewComponent]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Component_CreateNewComponent]
  @ProjectId int,
  @Name nvarchar(50),
  @ParentComponentId int
AS
	INSERT Component
	(
		ProjectID,
		Name,
		ParentComponentID
	)
	VALUES
	(
		@ProjectId,
		@Name,
		@ParentComponentId
	)
RETURN @@IDENTITY
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Component_DeleteComponent
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Component_DeleteComponent'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Component_DeleteComponent]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Component_DeleteComponent]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Component_DeleteComponent]
	@ComponentId Int 
AS
DELETE 
	Component
WHERE
	ComponentId = @ComponentId
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Component_GetChildComponentsByComponentId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Component_GetChildComponentsByComponentId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Component_GetChildComponentsByComponentId]
	@ComponentId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId,
	(SELECT COUNT(*) FROM Component WHERE ParentComponentId=c.ComponentId) ChildCount
FROM Component c
WHERE 
c.ParentComponentId = @ComponentId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Component_GetComponentById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Component_GetComponentById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Component_GetComponentById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Component_GetComponentById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Component_GetComponentById]
	@ComponentId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId,
	(SELECT COUNT(*) FROM Component WHERE ParentComponentId=c.ComponentId) ChildCount
FROM Component c
WHERE 
ComponentId = @ComponentId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Component_GetComponentsByProjectId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Component_GetComponentsByProjectId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Component_GetComponentsByProjectId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Component_GetComponentsByProjectId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Component_GetComponentsByProjectId]
	@ProjectId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId,
	(SELECT COUNT(*) FROM Component WHERE ParentComponentId=c.ComponentId) ChildCount
FROM Component c
WHERE 
ProjectId = @ProjectId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Component_GetRootComponentsByProjectId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Component_GetRootComponentsByProjectId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Component_GetRootComponentsByProjectId]
	@ProjectId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId,
	(SELECT COUNT(*) FROM Component WHERE ParentComponentId=c.ComponentId) ChildCount
FROM Component c
WHERE 
ProjectId = @ProjectId AND c.ParentComponentId = 0

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomField_CreateNewCustomField
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomField_CreateNewCustomField'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_CustomField_CreateNewCustomField]
	@ProjectId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId	int
AS
IF NOT EXISTS(SELECT CustomFieldId FROM ProjectCustomFields WHERE ProjectID = @ProjectID AND LOWER(CustomFieldName) = LOWER(@CustomFieldName) )
BEGIN
	INSERT ProjectCustomFields
	(
		ProjectId,
		CustomFieldName,
		CustomFieldDataType,
		CustomFieldRequired,
		CustomFieldTypeId
	)
	VALUES
	(
		@ProjectId,
		@CustomFieldName,
		@CustomFieldDataType,
		@CustomFieldRequired,
		@CustomFieldTypeId
	)

	RETURN @@IDENTITY
END
RETURN 0


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomField_DeleteCustomField
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomField_DeleteCustomField'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



CREATE PROCEDURE [dbo].[BugNet_CustomField_DeleteCustomField]
 @CustomIdToDelete INT
AS
DELETE FROM ProjectCustomFields WHERE CustomFieldId = @CustomIdToDelete


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomField_GetCustomFieldsByBugId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomField_GetCustomFieldsByBugId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



CREATE PROCEDURE [dbo].[BugNet_CustomField_GetCustomFieldsByBugId] 
	@BugId Int
AS
DECLARE @ProjectId Int
SELECT @ProjectId = ProjectId FROM Bug WHERE BugId = @BugId

SELECT
	Fields.ProjectId,
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	ISNULL(CustomFieldValue,'') CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	ProjectCustomFields Fields
	LEFT OUTER JOIN ProjectCustomFieldValues FieldValues ON (Fields.CustomFieldId = FieldValues.CustomFieldId AND FieldValues.BugId = @BugId)
WHERE
	Fields.ProjectId = @ProjectId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomField_GetCustomFieldsByProjectId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomField_GetCustomFieldsByProjectId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



CREATE PROCEDURE [dbo].[BugNet_CustomField_GetCustomFieldsByProjectId] 
	@ProjectId Int
AS
SELECT
	ProjectId,
	CustomFieldId,
	CustomFieldName,
	CustomFieldDataType,
	CustomFieldRequired,
	'' CustomFieldValue,
	CustomFieldTypeId
FROM
	ProjectCustomFields
WHERE
	ProjectId = @ProjectId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomField_SaveCustomFieldValue
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomField_SaveCustomFieldValue'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



CREATE PROCEDURE [dbo].[BugNet_CustomField_SaveCustomFieldValue]
	@BugId Int,
	@CustomFieldId Int, 
	@CustomFieldValue NVarChar(255)
AS
UPDATE ProjectCustomFieldValues SET
	CustomFieldValue = @CustomFieldValue
WHERE
	BugId = @BugId
	AND CustomFieldId = @CustomFieldId

IF @@ROWCOUNT = 0
	INSERT ProjectCustomFieldValues
	(
		BugId,
		CustomFieldId,
		CustomFieldValue
	)
	VALUES
	(
		@BugId,
		@CustomFieldId,
		@CustomFieldValue
	)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomFieldSelection_CreateNewCustomFieldSelection
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomFieldSelection_CreateNewCustomFieldSelection'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_CustomFieldSelection_CreateNewCustomFieldSelection]
	@CustomFieldId Int,
	@CustomFieldSelectionValue NVarChar(255),
	@CustomFieldSelectionName NVarChar(255)
AS

DECLARE @CustomFieldSelectionSortOrder int
SELECT @CustomFieldSelectionSortOrder = ISNULL(MAX(CustomFieldSelectionSortOrder),0) + 1 FROM ProjectCustomFieldSelection

IF NOT EXISTS(SELECT CustomFieldSelectionId FROM ProjectCustomFieldSelection WHERE CustomFieldId = @CustomFieldId AND LOWER(CustomFieldSelectionName) = LOWER(@CustomFieldSelectionName) )
BEGIN
	INSERT ProjectCustomFieldSelection
	(
		CustomFieldId,
		CustomFieldSelectionValue,
		CustomFieldSelectionName,
		CustomFieldSelectionSortOrder
	)
	VALUES
	(
		@CustomFieldId,
		@CustomFieldSelectionValue,
		@CustomFieldSelectionName,
		@CustomFieldSelectionSortOrder
		
	)

	RETURN @@IDENTITY
END
RETURN 0


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomFieldSelection_DeleteCustomFieldSelection
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomFieldSelection_DeleteCustomFieldSelection'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_CustomFieldSelection_DeleteCustomFieldSelection]
 @CustomSelectionIdToDelete INT
AS
DELETE FROM ProjectCustomFieldSelection WHERE CustomFieldSelectionId = @CustomSelectionIdToDelete


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomFieldSelection_GetCustomFieldSelection
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomFieldSelection_GetCustomFieldSelection'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



CREATE PROCEDURE [dbo].[BugNet_CustomFieldSelection_GetCustomFieldSelection] 
	@CustomFieldSelectionId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	ProjectCustomFieldSelection 
WHERE
	CustomFieldSelectionId = @CustomFieldSelectionId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



CREATE PROCEDURE [dbo].[BugNet_CustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId] 
	@CustomFieldId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	ProjectCustomFieldSelection 
WHERE
	CustomFieldId = @CustomFieldId
ORDER BY CustomFieldSelectionSortOrder


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_CustomFieldSelection_Update
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_CustomFieldSelection_Update'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_CustomFieldSelection_Update]
	@CustomFieldSelectionId int,
	@CustomFieldId int,
	@CustomFieldSelectionName nvarchar(255),
	@CustomFieldSelectionValue nvarchar(255),
	@CustomFieldSelectionSortOrder int
AS


UPDATE ProjectCustomFieldSelection SET
	CustomFieldId = @CustomFieldId,
	CustomFieldSelectionName = @CustomFieldSelectionName,
	CustomFieldSelectionValue = @CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
WHERE CustomFieldSelectionId= @CustomFieldSelectionId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_History_CreateNewHistory
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_History_CreateNewHistory'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_History_CreateNewHistory]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_History_CreateNewHistory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_History_CreateNewHistory]
  @BugId int,
  @CreatedUserName nvarchar(255),
  @FieldChanged nvarchar(50),
  @OldValue nvarchar(50),
  @NewValue nvarchar(50)
AS
DECLARE @CreatedUserId UniqueIdentifier
SELECT @CreatedUserId = UserId FROM aspnet_users WHERE UserName = @CreatedUserName

	INSERT BugHistory
	(
		BugId,
		CreatedUserId,
		FieldChanged,
		OldValue,
		NewValue,
		CreatedDate
	)
	VALUES
	(
		@BugId,
		@CreatedUserId,
		@FieldChanged,
		@OldValue,
		@NewValue,
		GetDate()
	)
RETURN @@IDENTITY
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_History_GetHistoryByBugId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_History_GetHistoryByBugId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_History_GetHistoryByBugId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_History_GetHistoryByBugId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_History_GetHistoryByBugId]
	@BugId int
AS
 SELECT
	BugHistoryID,
	BugId,
	CreateUser.UserName,
	FieldChanged,
	OldValue,
	NewValue,
	CreatedDate
FROM 
	BugHistory
JOIN 
	aspnet_users CreateUser 
ON
	BugHistory.CreatedUserId = CreateUser.UserId
WHERE 
	BugId = @BugId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_HostSettings_GetHostSettings
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_HostSettings_GetHostSettings'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_HostSettings_GetHostSettings]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_HostSettings_GetHostSettings]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_HostSettings_GetHostSettings] AS

SELECT SettingName, SettingValue FROM HostSettings
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_HostSettings_UpdateHostSetting
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_HostSettings_UpdateHostSetting'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_HostSettings_UpdateHostSetting]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_HostSettings_UpdateHostSetting]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_HostSettings_UpdateHostSetting]
 @SettingName	nvarchar(50),
 @SettingValue 	nvarchar(256)
AS
UPDATE HostSettings SET
	SettingName = @SettingName,
	SettingValue = @SettingValue
WHERE
	SettingName  = @SettingName
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Permission_AddRolePermission
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Permission_AddRolePermission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Permission_AddRolePermission]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Permission_AddRolePermission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_AddRolePermission]
	@PermissionId int,
	@RoleName nvarchar(200)
AS
DECLARE @RoleId UNIQUEIDENTIFIER
SELECT	@RoleId = RoleId FROM aspnet_roles WHERE Rolename = @RoleName

IF NOT EXISTS (SELECT PermissionId FROM RolePermission WHERE PermissionId = @PermissionId AND RoleId = @RoleId)
BEGIN
	INSERT  RolePermission
	(
		PermissionId,
		RoleId
	)
	VALUES
	(
		@PermissionId,
		@RoleId
	)
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Permission_DeleteRolePermission
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Permission_DeleteRolePermission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Permission_DeleteRolePermission]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Permission_DeleteRolePermission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_DeleteRolePermission]
	@PermissionId Int,
	@RoleName nvarchar(200) 
AS
DECLARE @RoleId UNIQUEIDENTIFIER
SELECT	@RoleId = RoleId FROM aspnet_roles WHERE Rolename = @RoleName

DELETE 
	RolePermission
WHERE
	PermissionId = @PermissionId
	AND RoleId = @RoleId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Permission_GetAllPermissions
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Permission_GetAllPermissions'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Permission_GetAllPermissions]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Permission_GetAllPermissions]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_GetAllPermissions] AS

SELECT PermissionId,PermissionKey, Name  FROM Permission
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Permission_GetPermissionsByRole
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Permission_GetPermissionsByRole'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Permission_GetPermissionsByRole]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Permission_GetPermissionsByRole]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_GetPermissionsByRole]
	@RoleName nvarchar(200) 
AS
DECLARE @RoleId UNIQUEIDENTIFIER
SELECT	@RoleId = RoleId FROM aspnet_roles WHERE Rolename = @RoleName

SELECT Permission.PermissionId,PermissionKey, Name  FROM Permission
Inner join RolePermission on RolePermission.PermissionId = Permission.PermissionId
WHERE RoleId = @RoleId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Permission_GetRolePermission
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Permission_GetRolePermission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Permission_GetRolePermission]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Permission_GetRolePermission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE  [dbo].[BugNet_Permission_GetRolePermission]  AS

Select R.RoleId, ProjectRoles.ProjectId,P.PermissionId,P.PermissionKey,R.RoleName
FROM RolePermission RP 
JOIN
Permission P ON RP.PermissionId = P.PermissionId
JOIN
aspnet_roles R ON RP.RoleId = R.RoleId
JOIN 
ProjectRoles ON R.RoleId = ProjectRoles.RoleId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Priority_GetAllPriorities
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Priority_GetAllPriorities'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Priority_GetAllPriorities]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Priority_GetAllPriorities]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Priority_GetAllPriorities]
AS
SELECT
	PriorityId,
	Name,
	ImageUrl
FROM 
	Priority


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Priority_GetPriorityById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Priority_GetPriorityById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Priority_GetPriorityById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Priority_GetPriorityById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Priority_GetPriorityById]
	@PriorityId int
AS
SELECT
	PriorityId,
	Name,
	ImageUrl
FROM 
	Priority
WHERE
	PriorityId = @PriorityId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_AddUserToProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_AddUserToProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_AddUserToProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_AddUserToProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_AddUserToProject]
@UserName nvarchar(255),
@ProjectId int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

IF NOT EXISTS (SELECT UserId FROM UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT  UserProjects
	(
		UserId,
		ProjectId,
		CreatedDate
	)
	VALUES
	(
		@UserId,
		@ProjectId,
		getdate()
	)
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_CreateNewProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_CreateNewProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_CreateNewProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_CreateNewProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
 @Name nvarchar(50),
 @Code nvarchar(3),
 @Description 	nvarchar(80),
 @ManagerUserName nvarchar(255),
 @UploadPath nvarchar(80),
 @Active int,
 @AccessType int,
 @CreatorUserName nvarchar(255)
AS
IF NOT EXISTS( SELECT ProjectId,Code  FROM Project WHERE LOWER(Name) = LOWER(@Name) OR LOWER(Code) = LOWER(@Code) )
BEGIN
	DECLARE @ManagerUserId UNIQUEIDENTIFIER
	DECLARE @CreatorUserId UNIQUEIDENTIFIER
	SELECT @ManagerUserId = UserId FROM aspnet_users WHERE Username = @ManagerUserName
	SELECT @CreatorUserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
	
	INSERT Project 
	(
		Name,
		Code,
		Description,
		UploadPath,
		ManagerUserId,
		CreateDate,
		CreatorUserId,
		AccessType,
		Active
	) 
	VALUES
	(
		@Name,
		@Code,
		@Description,
		@UploadPath,
		@ManagerUserId ,
		GetDate(),
		@CreatorUserId,
		@AccessType,
		@Active
	)
 	RETURN @@IDENTITY
END
ELSE
  RETURN 0
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_CreateProjectMailbox
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_CreateProjectMailbox'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_CreateProjectMailbox]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_CreateProjectMailbox]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_Project_CreateProjectMailbox]
	@MailBox nvarchar (100),
	@ProjectId int,
	@AssignToUserName nvarchar(255),
	@IssueTypeID int
AS

DECLARE @AssignToUserId UNIQUEIDENTIFIER
SELECT @AssignToUserId = UserId FROM aspnet_users WHERE Username = @AssignToUserName
	
INSERT ProjectMailBox 
(
	MailBox,
	ProjectId,
	AssignToUserId,
	IssueTypeID
)
VALUES
(
	@MailBox,
	@ProjectId,
	@AssignToUserId,
	@IssueTypeId
)
RETURN @@IDENTITY
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_DeleteProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_DeleteProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_DeleteProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_DeleteProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_DeleteProject]
	@ProjectId int
AS

DELETE FROM Project where ProjectId = @ProjectId

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_DeleteProjectMailbox
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_DeleteProjectMailbox'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_DeleteProjectMailbox]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_DeleteProjectMailbox]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_Project_DeleteProjectMailbox]
	@ProjectMailboxId int
AS
DELETE  ProjectMailBox 
WHERE
	ProjectMailboxId = @ProjectMailboxId

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_GetAllProjects
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetAllProjects'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_GetAllProjects]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_GetAllProjects]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetAllProjects]
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId	
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_GetMailboxByProjectId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetMailboxByProjectId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_GetMailboxByProjectId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_GetMailboxByProjectId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE  PROCEDURE [dbo].[BugNet_Project_GetMailboxByProjectId]
	@ProjectId int
AS

SELECT ProjectMailbox.*,
	u.Username AssignToName,
	Type.Name IssueTypeName
FROM 
	ProjectMailbox
	INNER JOIN aspnet_Users u ON u.UserId = AssignToUserID
	INNER JOIN Type ON Type.TypeId = IssueTypeId	
WHERE
	ProjectId = @ProjectId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_GetProjectByCode
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetProjectByCode'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_GetProjectByCode]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_GetProjectByCode]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectByCode]
 	@ProjectCode nvarchar(3)
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
WHERE
	Code = @ProjectCode
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_GetProjectById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetProjectById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_GetProjectById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_GetProjectById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectById]
 @ProjectId INT
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
WHERE
	ProjectId = @ProjectId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_GetProjectByMailbox
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetProjectByMailbox'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectByMailbox]
	(
	@mailbox nvarchar(256)
	)
	
AS
	SET NOCOUNT ON 
	
	SELECT  Mailbox,ProjectMailbox.ProjectId,IssueTypeId,Users.UserName as AssignToName, AssignToUserId FROM Project INNER JOIN ProjectMailbox 
	ON ProjectMailbox.ProjectId = Project.ProjectId
	INNER JOIN aspnet_users Users ON ProjectMailbox.AssignToUserId = Users.UserId	
	
	WHERE ProjectMailbox.Mailbox = @mailbox
	
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Project_GetProjectMembers
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetProjectMembers'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectMembers]
	@ProjectId Int
AS
SELECT Username
FROM 
	aspnet_users
LEFT OUTER JOIN
	UserProjects
ON
	aspnet_users.UserId = UserProjects.UserId
WHERE
	UserProjects.ProjectId = @ProjectId
ORDER BY Username ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Project_GetProjectsByUserName
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetProjectsByUserName'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

Create PROCEDURE [dbo].[BugNet_Project_GetProjectsByUserName]
	@UserName nvarchar(255),
	@ActiveOnly bit
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT DISTINCT
	Project.ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
	Left JOIN UserProjects ON UserProjects.ProjectId = Project.ProjectId
WHERE
	 (Project.AccessType = 1 AND Project.Active = @ActiveOnly) OR
              (Project.AccessType = 2 AND Project.Active = @ActiveOnly AND UserProjects.UserId = @UserId)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Project_GetPublicProjects
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetPublicProjects'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_GetPublicProjects]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_GetPublicProjects]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetPublicProjects]
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerUserId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.UserName ManagerDisplayName,
	Creators.UserName CreatorDisplayName
FROM 
	Project
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = Project.ManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = Project.CreatorUserId
WHERE 
	AccessType = 1 AND Project.Active = 1
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_IsUserProjectMember
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_IsUserProjectMember'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_IsUserProjectMember]
	@UserName	nvarchar(255),
 	@ProjectId	int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

IF EXISTS( SELECT UserId FROM UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
  RETURN 0
ELSE
  RETURN -1
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Project_RemoveUserFromProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_RemoveUserFromProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_RemoveUserFromProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_RemoveUserFromProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_RemoveUserFromProject]
	@UserName nvarchar(255),
	@ProjectId Int 
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

DELETE 
	UserProjects
WHERE
	UserId = @UserId
	AND ProjectId = @ProjectId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Project_UpdateProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_UpdateProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_UpdateProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_UpdateProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Project_UpdateProject]
 @ProjectId 		int,
 @Name				nvarchar(50),
 @Code				nvarchar(3),
 @Description 		nvarchar(80),
 @ManagerUserName	nvarchar(255),
 @UploadPath 		nvarchar(80),
 @AccessType		int,
 @Active 			int
AS
DECLARE @ManagerUserId UNIQUEIDENTIFIER
SELECT @ManagerUserId = UserId FROM aspnet_users WHERE Username = @ManagerUserName

UPDATE Project SET
	Name = @Name,
	Code = @Code,
	Description = @Description,
	ManagerUserId = @ManagerUserId,
	UploadPath = @UploadPath,
	AccessType = @AccessType,
	Active = @Active
WHERE
	ProjectId = @ProjectId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_RelatedBug_CreateNewRelatedBug
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_RelatedBug_CreateNewRelatedBug'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_RelatedBug_CreateNewRelatedBug]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_RelatedBug_CreateNewRelatedBug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedBug_CreateNewRelatedBug]
	@BugId Int,
	@LinkedBugId int
AS
IF NOT EXISTS( SELECT RelatedBugId FROM RelatedBug WHERE @BugId = @BugId  AND LinkedBugId = @LinkedBugId)
BEGIN
	INSERT RelatedBug
	(
		BugId,
		LinkedBugId
	)
	VALUES
	(
		@BugId,
		@LinkedBugId
	)
	INSERT RelatedBug
	(
		BugId,
		LinkedBugId
	)
	VALUES
	(
		@LinkedBugId,
		@BugId
	)
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_RelatedBug_DeleteRelatedBug
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_RelatedBug_DeleteRelatedBug'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_RelatedBug_DeleteRelatedBug]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_RelatedBug_DeleteRelatedBug]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedBug_DeleteRelatedBug]
	@BugId Int,
	@LinkedBugId int
AS

DELETE 
	RelatedBug
WHERE
	BugId =  @BugId AND
	LinkedBugId = @LinkedBugId
DELETE 
	RelatedBug
WHERE
	BugId = @LinkedBugId AND
	LinkedBugId = @BugId

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_RelatedBug_GetRelatedBugsByBugId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_RelatedBug_GetRelatedBugsByBugId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_RelatedBug_GetRelatedBugsByBugId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_RelatedBug_GetRelatedBugsByBugId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedBug_GetRelatedBugsByBugId]
	@BugId int
As
Select * from BugsView join RelatedBug on BugsView.BugId = RelatedBug.LinkedBugId
WHERE RelatedBug.BugId = @BugId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Resolution_GetAllResolutions
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Resolution_GetAllResolutions'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Resolution_GetAllResolutions]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Resolution_GetAllResolutions]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Resolution_GetAllResolutions]
AS
SELECT
	ResolutionId,
	Name
FROM 
	Resolution

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Resolution_GetResolutionById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Resolution_GetResolutionById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Resolution_GetResolutionById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Resolution_GetResolutionById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Resolution_GetResolutionById]
	@ResolutionId int
AS
SELECT
	ResolutionId,
	Name
FROM 
	Resolution
WHERE
	ResolutionId = @ResolutionId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Role_AddRoleToProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_AddRoleToProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Role_AddRoleToProject]
@RoleName nvarchar(255),
@ProjectId int
AS
DECLARE @RoleId UNIQUEIDENTIFIER
SELECT	@RoleId = RoleId FROM aspnet_roles WHERE RoleName = @RoleName

IF NOT EXISTS (SELECT RoleId FROM ProjectRoles WHERE RoleId = @RoleId AND ProjectId = @ProjectId)
BEGIN
	INSERT  ProjectRoles
	(
		RoleId,
		ProjectId,
		CreatedDate
	)
	VALUES
	(
		@RoleId,
		@ProjectId,
		getdate()
	)
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Role_GetRolesByProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_GetRolesByProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_GetRolesByProject]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_GetRolesByProject]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Role_GetRolesByProject]
	@ProjectId int
AS

SELECT RoleName FROM aspnet_roles 
JOIN ProjectRoles ON aspnet_roles.RoleId = ProjectRoles.RoleId 
WHERE ProjectRoles.ProjectId = @ProjectId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Role_GetRolesByUser
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_GetRolesByUser'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_GetRolesByUser]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_GetRolesByUser]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE procedure [dbo].[BugNet_Role_GetRolesByUser]
    
@UserName       nvarchar(255),
@ProjectId      int
as
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT     PR.ProjectRoleId, PR.RoleId, PR.ProjectId, PR.CreatedDate, R.ApplicationId, R.RoleId AS Expr1, R.RoleName, R.LoweredRoleName, 
                      R.Description
FROM         ProjectRoles AS PR 
INNER JOIN
             aspnet_Roles AS R ON PR.RoleId = R.RoleId 
INNER JOIN
             aspnet_UsersInRoles AS UR ON PR.RoleId = UR.RoleId
WHERE     (PR.ProjectId = @ProjectId) AND (UR.UserId = @UserID)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Role_RemoveRoleFromProject
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_RemoveRoleFromProject'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREate PROCEDURE [dbo].[BugNet_Role_RemoveRoleFromProject]
	@RoleName nvarchar(255),
	@ProjectId Int 
AS
DECLARE @RoleId UNIQUEIDENTIFIER
SELECT	@RoleId = RoleId FROM aspnet_roles WHERE RoleName = @RoleName

DELETE 
	ProjectRoles
WHERE
	RoleId = @RoleId
	AND ProjectId = @ProjectId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




--
-- Script for dbo.BugNet_Status_GetAllStatus
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Status_GetAllStatus'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Status_GetAllStatus]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Status_GetAllStatus]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Status_GetAllStatus]
AS
SELECT
	StatusId,
	Name
FROM 
	Status

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Status_GetStatusById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Status_GetStatusById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Status_GetStatusById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Status_GetStatusById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Status_GetStatusById]
	@StatusId int
AS
SELECT
	StatusId,
	Name
FROM 
	Status
WHERE
	StatusId = @StatusId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_TimeEntry_CreateNewTimeEntry
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_TimeEntry_CreateNewTimeEntry'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_TimeEntry_CreateNewTimeEntry]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_TimeEntry_CreateNewTimeEntry]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



CREATE PROCEDURE [dbo].[BugNet_TimeEntry_CreateNewTimeEntry]
	@BugId int,
	@CreatorUserName nvarchar(255),
	@WorkDate datetime ,
	@Duration decimal(4,2),
	@BugCommentId int
AS
-- Get Last Update UserID
DECLARE @CreatorUserId uniqueidentifier
SELECT @CreatorUserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
INSERT BugTimeEntry
(
	BugId,
	CreatedUserId,
	WorkDate,
	Duration,
	BugCommentId
) 
VALUES 
(
	@BugId,
	@CreatorUserId,
	@WorkDate,
	@Duration,
	@BugCommentID
)
RETURN @@IDENTITY
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_TimeEntry_DeleteTimeEntry
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_TimeEntry_DeleteTimeEntry'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_TimeEntry_DeleteTimeEntry]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_TimeEntry_DeleteTimeEntry]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_TimeEntry_DeleteTimeEntry]
	@BugTimeEntryId int
AS
DELETE 
	BugTimeEntry
WHERE
	BugTimeEntryId = @BugTimeEntryId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_TimeEntry_GetProjectWorkerWorkReport
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_TimeEntry_GetProjectWorkerWorkReport'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_TimeEntry_GetProjectWorkerWorkReport]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_TimeEntry_GetProjectWorkerWorkReport]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_TimeEntry_GetProjectWorkerWorkReport]
 @ProjectId INT,
 @ReporterUsername NVARCHAR(255)
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @ReporterUsername

SELECT     Project.ProjectId, Project.Name as ProjectName,Project.Code + '-' + str(Bug.BugId) as FullId, Bug.BugId, Bug.Summary, Creators.UserName AS Reporter,  BugTimeEntry.Duration,  BugTimeEntry.WorkDate,
                      ISNULL(BugComment.Comment, '') AS Comment
FROM         BugTimeEntry INNER JOIN
                      aspnet_users Creators ON Creators.UserId =  BugTimeEntry.CreatedUserId INNER JOIN
                      Bug ON  BugTimeEntry.BugId = Bug.BugId INNER JOIN
                      Project ON Bug.ProjectId = Project.ProjectId LEFT OUTER JOIN
                      BugComment ON BugComment.BugCommentId =  BugTimeEntry.BugCommentId
WHERE
	Project.ProjectID = @ProjectId 
AND
	BugTimeEntry.CreatedUserId = @UserId
ORDER BY Reporter, WorkDate
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId]
 @ReporterUserName nvarchar(255)
AS
DECLARE @ReporterUserId uniqueidentifier
SELECT @ReporterUserId = UserId FROM aspnet_users WHERE Username = @ReporterUserName

SELECT     Project.ProjectId, Project.Name, Bug.BugId, Bug.Summary, Creators.UserName AS CreatorDisplayName, BugTimeEntry.Duration, 
                      ISNULL(BugComment.Comment, '') AS Comment
FROM         BugTimeEntry INNER JOIN
                      aspnet_users Creators ON Creators.UserID =  BugTimeEntry.CreatedUserId INNER JOIN
                      Bug ON  BugTimeEntry.BugId = Bug.BugId INNER JOIN
                      Project ON Bug.ProjectId = Project.ProjectId LEFT OUTER JOIN
                      BugComment ON BugComment.BugCommentId =  BugTimeEntry.BugCommentId
WHERE
	 BugTimeEntry.CreatedUserId = @ReporterUserId
ORDER BY WorkDate
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_TimeEntry_GetWorkReportByBugId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_TimeEntry_GetWorkReportByBugId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_TimeEntry_GetWorkReportByBugId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_TimeEntry_GetWorkReportByBugId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_TimeEntry_GetWorkReportByBugId]
 @BugId INT
AS
SELECT      BugTimeEntry.*, Creators.UserName AS CreatorUserName, Membership.Email AS CreatorEmail, 
                      ISNULL(BugComment.Comment, '') Comment
FROM         BugTimeEntry
	 INNER JOIN aspnet_users Creators ON Creators.UserID =  BugTimeEntry.CreatedUserId
	 INNER JOIN aspnet_membership Membership ON Creators.UserId = Membership.UserId
	 LEFT OUTER JOIN BugComment ON BugComment.BugCommentId =  BugTimeEntry.BugCommentId
WHERE
	 BugTimeEntry.BugId = @BugId
ORDER BY WorkDate DESC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_TimeEntry_GetWorkReportByProjectId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_TimeEntry_GetWorkReportByProjectId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_TimeEntry_GetWorkReportByProjectId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_TimeEntry_GetWorkReportByProjectId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


CREATE PROCEDURE [dbo].[BugNet_TimeEntry_GetWorkReportByProjectId]
 @ProjectId INT
AS
SELECT     Project.ProjectID, Project.Name as ProjectName,Project.Code + '-' + str(Bug.BugID) as FullId,Bug.BugId, Bug.Summary, Creators.UserName AS Reporter,  BugTimeEntry.Duration, BugTimeEntry.WorkDate, 
                      ISNULL(BugComment.Comment, '') AS Comment
FROM        BugTimeEntry INNER JOIN
                      aspnet_users Creators ON Creators.UserId =  BugTimeEntry.CreatedUserId INNER JOIN
                      Bug ON  BugTimeEntry.BugId = Bug.BugId INNER JOIN
                      Project ON Bug.ProjectId = Project.ProjectId LEFT OUTER JOIN
                      BugComment ON BugComment.BugCommentId =  BugTimeEntry.BugCommentId
WHERE
	Project.ProjectId = @ProjectId
ORDER BY WorkDate
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Type_GetAllTypes
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Type_GetAllTypes'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Type_GetAllTypes]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Type_GetAllTypes]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Type_GetAllTypes]
AS
SELECT
	TypeId,
	Name,
	ImageUrl
FROM 
	Type


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Type_GetTypeById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Type_GetTypeById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Type_GetTypeById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Type_GetTypeById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Type_GetTypeById]
	@TypeId int
AS
SELECT
	TypeId,
	Name,
	ImageUrl
FROM 
	Type
WHERE
	TypeId = @TypeId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Version_CreateNewVersion
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Version_CreateNewVersion'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Version_CreateNewVersion]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Version_CreateNewVersion]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Version_CreateNewVersion]
  @ProjectId int,
  @Name nvarchar(50),
  @SortOrder int
AS
	INSERT Version
	(
		ProjectID,
		Name,
		SortOrder
	)
	VALUES
	(
		@ProjectId,
		@Name,
		@SortOrder
	)
RETURN @@IDENTITY
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Version_DeleteVersion
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Version_DeleteVersion'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Version_DeleteVersion]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Version_DeleteVersion]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Version_DeleteVersion]
	@VersionId Int 
AS
DELETE 
	Version
WHERE
	VersionId = @VersionId
/*We need to delete all bugs with this version too */
DELETE
	Bug
WHERE 
	VersionId = @VersionId
	
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Version_GetVersionById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Version_GetVersionById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Version_GetVersionById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Version_GetVersionById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Version_GetVersionById]
 @VersionId INT
AS
SELECT
	VersionId,
	ProjectId,
	Name,
	SortOrder
FROM 
	Version
WHERE
	VersionId = @VersionId

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Version_GetVersionByProjectId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Version_GetVersionByProjectId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Version_GetVersionByProjectId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Version_GetVersionByProjectId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Version_GetVersionByProjectId]
 @ProjectId INT
AS
SELECT
	VersionId,
	ProjectId,
	Name,
	SortOrder
FROM 
	Version
WHERE
	ProjectId = @ProjectId
ORDER BY SortOrder ASC
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_Version_Update
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Version_Update'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

CREATE PROCEDURE [dbo].[BugNet_Version_Update]
	@VersionId int,
	@ProjectId int,
	@Name nvarchar(255),
	@SortOrder int
AS


UPDATE Version SET
	ProjectId = @ProjectId,
	[Name] = @Name,
	SortOrder = @SortOrder
WHERE VersionId= @VersionId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET ANSI_NULLS ON 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


/* Drop Unused Tables and Stored Procs */

ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_Users]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_Roles]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

--
-- Script for dbo.BugNet_User_UpdateUser
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_User_UpdateUser'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_User_UpdateUser]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_User_UpdateUser]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_User_IsProjectMember
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_User_IsProjectMember'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_User_IsProjectMember]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_User_IsProjectMember]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_User_GetUsersByProjectId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_User_GetUsersByProjectId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_User_GetUsersByProjectId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_User_GetUsersByProjectId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_User_GetUserByUsername
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_User_GetUserByUsername'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_User_GetUserByUsername]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_User_GetUserByUsername]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_User_GetUserById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_User_GetUserById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_User_GetUserById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_User_GetUserById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_User_GetAllUsers
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_User_GetAllUsers'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_User_GetAllUsers]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_User_GetAllUsers]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_User_CreateNewUser
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_User_CreateNewUser'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_User_CreateNewUser]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_User_CreateNewUser]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_User_Authenticate
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_User_Authenticate'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_User_Authenticate]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_User_Authenticate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_UpdateRole
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_UpdateRole'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_UpdateRole]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_UpdateRole]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_RoleHasPermission
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_RoleHasPermission'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_RoleHasPermission]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_RoleHasPermission]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_RemoveUserFromRole
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_RemoveUserFromRole'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_RemoveUserFromRole]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_RemoveUserFromRole]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_IsUserInRole
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_IsUserInRole'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_IsUserInRole]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_IsUserInRole]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_GetRolesByUserId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_GetRolesByUserId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_GetRolesByUserId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_GetRolesByUserId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_GetRoleById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_GetRoleById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_GetRoleById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_GetRoleById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_GetAllRoles
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_GetAllRoles'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_GetAllRoles]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_GetAllRoles]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_DeleteRole
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_DeleteRole'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_DeleteRole]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_DeleteRole]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_CreateNewRole
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_CreateNewRole'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_CreateNewRole]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_CreateNewRole]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Role_AddUserToRole
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Role_AddUserToRole'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Role_AddUserToRole]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Role_AddUserToRole]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Project_GetProjectsByUserId
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Project_GetProjectsByUserId'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Project_GetProjectsByUserId]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Project_GetProjectsByUserId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_OperatingSystem_GetOperatingSystemById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_OperatingSystem_GetOperatingSystemById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_OperatingSystem_GetOperatingSystemById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_OperatingSystem_GetOperatingSystemById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_OperatingSystem_GetAllOperatingSystems
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_OperatingSystem_GetAllOperatingSystems'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_OperatingSystem_GetAllOperatingSystems]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_OperatingSystem_GetAllOperatingSystems]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Hardware_GetHardwareById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Hardware_GetHardwareById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Hardware_GetHardwareById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Hardware_GetHardwareById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Hardware_GetAllHardware
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Hardware_GetAllHardware'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Hardware_GetAllHardware]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Hardware_GetAllHardware]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Environment_GetEnvironmentById
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Environment_GetEnvironmentById'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Environment_GetEnvironmentById]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Environment_GetEnvironmentById]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.BugNet_Environment_GetAllEnvironments
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.BugNet_Environment_GetAllEnvironments'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[BugNet_Environment_GetAllEnvironments]') and OBJECTPROPERTY(id, 'IsProcedure')=1)
  drop procedure [dbo].[BugNet_Environment_GetAllEnvironments]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.Users
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Users'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[Users]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Users]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.UserRoles
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.UserRoles'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[UserRoles]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[UserRoles]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.Roles
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Roles'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[Roles]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Roles]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.OperatingSystem
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.OperatingSystem'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[OperatingSystem]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[OperatingSystem]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.Hardware
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Hardware'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[Hardware]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Hardware]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


--
-- Script for dbo.Environment
-- Foreign keys etc. will appear at the end
--

PRINT 'Updating dbo.Environment'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
if exists (select * from sysobjects where id=object_id('[dbo].[Environment]') and OBJECTPROPERTY(id, 'IsUserTable')=1)
  drop table [dbo].[Environment]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

/* 
	Data Migration Updates 
	
*/

PRINT 'Updating Host Settings'


UPDATE HostSettings SET SettingValue = '0.7.719.0' WHERE SettingName = 'Version'
GO
UPDATE HostSettings SET SettingValue = '60000' WHERE SettingName = 'Pop3Interval'
GO
INSERT INTO HostSettings (SettingName, SettingValue) VALUES ('ADPath','')
GO
INSERT INTO HostSettings (SettingName, SettingValue) VALUES ('EmailErrors','False')
GO
INSERT INTO HostSettings (SettingName, SettingValue) VALUES ('ErrorLoggingEmailAddress','youremail@domain.com')
GO
INSERT INTO HostSettings(SettingName,SettingValue) Values('SMTPUseSSL','false')
GO
INSERT INTO HostSettings(SettingName,SettingValue) Values('SMTPPort','25')
GO
INSERT INTO ProjectCustomFieldType(CustomFieldTypeName) Values ('Text')
GO
INSERT INTO ProjectCustomFieldType(CustomFieldTypeName) Values ('Drop Down List')
GO
INSERT INTO ProjectCustomFieldType(CustomFieldTypeName) Values ('Date')
GO
INSERT INTO ProjectCustomFieldType(CustomFieldTypeName) Values ('Rich Text')
GO
INSERT INTO ProjectCustomFieldType(CustomFieldTypeName) Values ('Yes / No')
GO
INSERT INTO ProjectCustomFieldType(CustomFieldTypeName) Values ('User List')


PRINT 'Adding Default Roles'

DECLARE @ApplicationName varchar(255)
SET @ApplicationName = 'BugNET'

EXEC dbo.aspnet_Roles_CreateRole @ApplicationName,@RoleName = 'Super Users'
EXEC dbo.aspnet_Roles_CreateRole @ApplicationName,@RoleName = 'Project Administrators'
EXEC dbo.aspnet_Roles_CreateRole @ApplicationName,@RoleName = 'Read Only'
EXEC dbo.aspnet_Roles_CreateRole @ApplicationName,@RoleName = 'Reporter'
EXEC dbo.aspnet_Roles_CreateRole @ApplicationName,@RoleName = 'Developer'
EXEC dbo.aspnet_Roles_CreateRole @ApplicationName,@RoleName = 'Quality Assurance'
GO

PRINT 'Adding Permissions'

DECLARE @RoleName varchar(255)
SET @RoleName = 'Project Administrators'

EXEC dbo.BugNet_Permission_AddRolePermission 1, @RoleName 
EXEC dbo.BugNet_Permission_AddRolePermission 2, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 3, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 4, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 5, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 6, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 7, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 8, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 9, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 10, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 11, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 12, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 13, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 14, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 15, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 16, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 17, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 18, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 19, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 20, @RoleName

SET @RoleName = 'Read Only'
EXEC dbo.BugNet_Permission_AddRolePermission 5, @RoleName

SET @RoleName = 'Reporter'
EXEC dbo.BugNet_Permission_AddRolePermission 2, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 7, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 10, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 12, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 15, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 3, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 5, @RoleName

SET @RoleName = 'Developer'
EXEC dbo.BugNet_Permission_AddRolePermission 2, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 7, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 10, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 12, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 15, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 3, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 4, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 5, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 19, @RoleName

SET @RoleName = 'Quality Assurance'
EXEC dbo.BugNet_Permission_AddRolePermission 2, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 7, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 10, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 12, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 15, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 3, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 4, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 5, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 19, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 17, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 14, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 1, @RoleName
EXEC dbo.BugNet_Permission_AddRolePermission 6, @RoleName

GO

PRINT 'Updating Project Role Mappings'

/*

	Create Project - Roles Mapping 
 
*/
declare @pId int
declare @RowNum int
declare @ProjectCount int
	
set @RowNum = 0 

select @ProjectCount = count(ProjectId) from Project
select top 1 @pId = ProjectId from Project


WHILE @RowNum < @ProjectCount

BEGIN
	set @RowNum = @RowNum + 1
	exec BugNet_Role_AddRoleToProject @ProjectId = @pID, @RoleName = 'Project Administrators'
	exec BugNet_Role_AddRoleToProject @ProjectId = @pID, @RoleName = 'Read Only'
	exec BugNet_Role_AddRoleToProject @ProjectId = @pID, @RoleName = 'Reporter'
	exec BugNet_Role_AddRoleToProject @ProjectId = @pID, @RoleName = 'Developer'
	exec BugNet_Role_AddRoleToProject @ProjectId = @pID, @RoleName = 'Quality Assurance'
	select top 1 @pId=ProjectId from Project where ProjectId > @pID 
END

/* Transaction Script */

IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO




