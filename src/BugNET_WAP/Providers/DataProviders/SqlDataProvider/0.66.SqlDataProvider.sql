/************************************************************/
/*****              SqlDataProvider                     *****/
/*****	    Version 0.66 Schema Upgrade Script          *****/
/*****                                                  *****/
/***** 												    *****/
/*****      										    *****/
/*****      										 	*****/
/*****                                                  *****/
/************************************************************/


/* BEGIN TRANSACTION */
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO


PRINT 'Altering  Existing Objects'
GO

/* Alter Users Table */
EXEC sp_rename 'BugComment.Date', 'CreatedDate', 'COLUMN'
GO
EXEC sp_rename 'BugHistory.Date', 'CreatedDate', 'COLUMN'
GO
EXEC sp_rename 'BugAttachment.Size', 'FileSize', 'COLUMN'
GO
ALTER TABLE Users ADD [IsSuperUser] [bit] NOT NULL CONSTRAINT [DF_Users_IsSuperUser] DEFAULT (0)
GO
ALTER TABLE Users DROP CONSTRAINT DF_Users_RoleID
GO
ALTER TABLE Users DROP COLUMN RoleID
GO
ALTER TABLE Users ALTER COLUMN UserName nvarchar(50) not null
GO
ALTER TABLE Users DROP CONSTRAINT DF__Users__active__0F975522
GO
ALTER TABLE Users ALTER COLUMN [Active] [bit] NOT NULL 
GO
ALTER TABLE Users ADD 
	CONSTRAINT [DF_Users_Active] DEFAULT (0) FOR Active
GO


ALTER TABLE [dbo].[Hardware]  ALTER COLUMN [Name] NVARCHAR(20) NOT NULL
ALTER TABLE [dbo].[Priority]  ALTER COLUMN [Name] NVARCHAR(20) NOT NULL
ALTER TABLE [dbo].[Priority]  ALTER COLUMN [ImageUrl] NVARCHAR(50) NULL
ALTER TABLE [dbo].[Status]  ALTER COLUMN [Name] NVARCHAR(20) NOT NULL
ALTER TABLE [dbo].[Type]  ALTER COLUMN [ImageUrl] NVARCHAR(50) NULL
ALTER TABLE [dbo].[Resolution]  ALTER COLUMN [Name] NVARCHAR(20) NOT NULL
ALTER TABLE [dbo].[OperatingSystem]  ALTER COLUMN [Name] NVARCHAR(20) NOT NULL
ALTER TABLE [dbo].[Environment]  ALTER COLUMN [Name] NVARCHAR(50) NOT NULL
ALTER TABLE [dbo].[Version]  ALTER COLUMN [Name] NVARCHAR(20) NOT NULL
ALTER TABLE [dbo].[BugHistory]  ALTER COLUMN [FieldChanged] NVARCHAR(50) NOT NULL
ALTER TABLE [dbo].[BugHistory]  ALTER COLUMN [OldValue] NVARCHAR(50) NOT NULL
ALTER TABLE [dbo].[BugHistory]  ALTER COLUMN [NewValue] NVARCHAR(50) NOT NULL
ALTER TABLE [dbo].[Bug]  ALTER COLUMN [Summary] NVARCHAR(500) NOT NULL
ALTER TABLE [dbo].[Bug]  ALTER COLUMN [Url] NVARCHAR(500) NOT NULL
ALTER TABLE [dbo].[BugAttachment]  ALTER COLUMN [FileName] NVARCHAR(100) NOT NULL
ALTER TABLE [dbo].[BugAttachment]  ALTER COLUMN [Description] NVARCHAR(80) NOT NULL
ALTER TABLE [dbo].[BugAttachment]  ALTER COLUMN [Type] NVARCHAR(50) NOT NULL
ALTER TABLE [dbo].[Roles]  ALTER COLUMN [RoleName] NVARCHAR(20) NOT NULL
ALTER TABLE [dbo].[Users]  ALTER COLUMN [Password] NVARCHAR(20) NOT NULL
ALTER TABLE [dbo].[Project]  ALTER COLUMN [Name] NVARCHAR(30) NOT NULL
ALTER TABLE [dbo].[Project]  ALTER COLUMN [Description] NVARCHAR(80) NOT NULL
ALTER TABLE [dbo].[Component]  ALTER COLUMN [Name] NVARCHAR(50) NOT NULL
GO

/*
*----------------------------------
* Bug Comment Table
*----------------------------------
*/
ALTER TABLE BugComment ADD Comment1 ntext not null CONSTRAINT DF__Bug__Comment DEFAULT ('')
GO
UPDATE BugComment SET  Comment1 = Comment
GO
If exists (select sc.name From sysobjects so join syscolumns sc on so.id = sc.id where so.name = 'BugComment' and sc.name = 'Comment')
BEGIN
	Alter table BugComment Drop column Comment
END
GO
EXEC sp_rename 'BugComment.Comment1', 'Comment', 'COLUMN'
GO
ALTER TABLE BugComment DROP CONSTRAINT DF__Bug__Comment
GO

/* 
*---------------------------
* Bug Table
*---------------------------
*/
ALTER TABLE Bug ADD Description1 ntext not null CONSTRAINT DF__Bug__Description DEFAULT ('')
GO
UPDATE Bug SET  Description1 = Description
GO
If exists (select sc.name From sysobjects so join syscolumns sc on so.id = sc.id where so.name = 'BugComment' and sc.name = 'Comment')
BEGIN
	Alter table Bug Drop column Description
END
GO
EXEC sp_rename 'Bug.Description1', 'Description', 'COLUMN'
GO
ALTER TABLE Bug DROP CONSTRAINT DF__Bug__Description
GO

/* 
*---------------------------
* Project Table
*---------------------------
*/
ALTER TABLE Project ADD Code nvarchar(3) not null CONSTRAINT DF__Project__Code DEFAULT ('')
GO
ALTER TABLE Project ADD AccessType int not null CONSTRAINT DF__Project__AccessType DEFAULT (2)
GO

/* 
*-------------------------------------------------
*	CREATE NEW TABLES 
*-------------------------------------------------
*/
PRINT 'Creating New Objects'
GO


CREATE TABLE [dbo].[BugTimeEntry] (
	[BugTimeEntryId] [int] IDENTITY (1, 1) NOT NULL ,
	[BugId] [int] NOT NULL ,
	[UserId] [int] NOT NULL ,
	[WorkDate] [datetime] NOT NULL ,
	[Duration] [decimal](4, 2) NOT NULL ,
	[BugCommentId] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[HostSettings] (
	[SettingName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[SettingValue] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Permission] (
	[PermissionId] [int] IDENTITY (1, 1) NOT NULL ,
	[PermissionKey] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ProjectMailBox] (
	[ProjectMailboxId] [int] IDENTITY (1, 1) NOT NULL ,
	[MailBox] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ProjectID] [int] NOT NULL ,
	[AssignToUserID] [int] NULL ,
	[IssueTypeID] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[RolePermission] (
	[RolePermissionId] [int] IDENTITY (1, 1) NOT NULL ,
	[RoleId] [int] NOT NULL ,
	[PermissionId] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[UserProjects] (
	[UserId] [int] NOT NULL ,
	[ProjectId] [int] NOT NULL ,
	[UserProjectId] [int] IDENTITY (1, 1) NOT NULL ,
	[CreatedDate] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[UserRoles] (
	[UserRoleId] [int] IDENTITY (1, 1) NOT NULL ,
	[UserId] [int] NOT NULL ,
	[RoleId] [int] NOT NULL 
) ON [PRIMARY]
GO

/* Drop the Existing Roles Table & Re-Add the new one */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Roles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Roles]
GO

CREATE TABLE [dbo].[Roles] (
	[RoleID] [int] IDENTITY (1, 1) NOT NULL ,
	[ProjectID] [int] NOT NULL ,
	[RoleName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

/* Add Constraints */

ALTER TABLE [dbo].[BugTimeEntry] ADD 
	CONSTRAINT [PK_BugTimeEntry] PRIMARY KEY  CLUSTERED 
	(
		[BugTimeEntryId]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[HostSettings] ADD 
	CONSTRAINT [PK_HostSettings] PRIMARY KEY  CLUSTERED 
	(
		[SettingName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Permission] ADD 
	CONSTRAINT [PK_Permission] PRIMARY KEY  CLUSTERED 
	(
		[PermissionId]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ProjectMailBox] ADD 
	CONSTRAINT [PK_ProjectMailBox] PRIMARY KEY  CLUSTERED 
	(
		[ProjectMailboxId]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[RolePermission] ADD 
	CONSTRAINT [PK_RolePermission] PRIMARY KEY  CLUSTERED 
	(
		[RolePermissionId]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Roles] ADD 
	CONSTRAINT [PK__Role__0BC6C43E] PRIMARY KEY  CLUSTERED 
	(
		[RoleID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[UserProjects] ADD 
	CONSTRAINT [PK_UserProjects] PRIMARY KEY  CLUSTERED 
	(
		[UserId],
		[ProjectId]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[UserRoles] ADD 
	CONSTRAINT [PK_UserRoles] PRIMARY KEY  CLUSTERED 
	(
		[UserRoleId]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Bug] ADD 
	CONSTRAINT [FK_Bug_Environment] FOREIGN KEY 
	(
		[EnvironmentID]
	) REFERENCES [dbo].[Environment] (
		[EnvironmentID]
	),
	CONSTRAINT [FK_Bug_Hardware] FOREIGN KEY 
	(
		[HardwareID]
	) REFERENCES [dbo].[Hardware] (
		[HardwareID]
	),
	CONSTRAINT [FK_Bug_OperatingSystem] FOREIGN KEY 
	(
		[OperatingSystemID]
	) REFERENCES [dbo].[OperatingSystem] (
		[OperatingSystemID]
	),
	CONSTRAINT [FK_Bug_Priority] FOREIGN KEY 
	(
		[PriorityID]
	) REFERENCES [dbo].[Priority] (
		[PriorityID]
	),
	CONSTRAINT [FK_Bug_Project] FOREIGN KEY 
	(
		[ProjectID]
	) REFERENCES [dbo].[Project] (
		[ProjectID]
	) ON DELETE CASCADE,
	CONSTRAINT [FK_Bug_Resolution] FOREIGN KEY 
	(
		[ResolutionID]
	) REFERENCES [dbo].[Resolution] (
		[ResolutionID]
	),
	CONSTRAINT [FK_Bug_Status] FOREIGN KEY 
	(
		[StatusID]
	) REFERENCES [dbo].[Status] (
		[StatusID]
	),
	CONSTRAINT [FK_Bug_Type] FOREIGN KEY 
	(
		[TypeID]
	) REFERENCES [dbo].[Type] (
		[TypeID]
	)
GO

ALTER TABLE [dbo].[BugAttachment] ADD 
	CONSTRAINT [FK_BugAttachment_Bug] FOREIGN KEY 
	(
		[BugID]
	) REFERENCES [dbo].[Bug] (
		[BugID]
	) ON DELETE CASCADE 
GO

ALTER TABLE [dbo].[BugComment] ADD 
	CONSTRAINT [FK_BugComment_Bug] FOREIGN KEY 
	(
		[BugID]
	) REFERENCES [dbo].[Bug] (
		[BugID]
	) ON DELETE CASCADE 
GO

ALTER TABLE [dbo].[BugHistory] ADD 
	CONSTRAINT [FK_BugHistory_Bug] FOREIGN KEY 
	(
		[BugID]
	) REFERENCES [dbo].[Bug] (
		[BugID]
	) ON DELETE CASCADE 
GO

ALTER TABLE [dbo].[BugNotification] ADD 
	CONSTRAINT [FK_BugNotification_Bug] FOREIGN KEY 
	(
		[BugID]
	) REFERENCES [dbo].[Bug] (
		[BugID]
	) ON DELETE CASCADE 
GO

ALTER TABLE [dbo].[BugTimeEntry] ADD 
	CONSTRAINT [FK_BugTimeEntry_Bug] FOREIGN KEY 
	(
		[BugId]
	) REFERENCES [dbo].[Bug] (
		[BugID]
	) ON DELETE CASCADE 
GO

ALTER TABLE [dbo].[Component] ADD 
	CONSTRAINT [FK_Component_Project] FOREIGN KEY 
	(
		[ProjectID]
	) REFERENCES [dbo].[Project] (
		[ProjectID]
	) ON DELETE CASCADE 
GO

ALTER TABLE [dbo].[ProjectMailBox] ADD 
	CONSTRAINT [FK_ProjectMailBox_Project] FOREIGN KEY 
	(
		[ProjectID]
	) REFERENCES [dbo].[Project] (
		[ProjectID]
	) ON DELETE CASCADE 
GO

ALTER TABLE [dbo].[RelatedBug] ADD 
	CONSTRAINT [FK_RelatedBug_Bug] FOREIGN KEY 
	(
		[BugID]
	) REFERENCES [dbo].[Bug] (
		[BugID]
	) ON DELETE CASCADE 
GO

ALTER TABLE [dbo].[RolePermission] ADD 
	CONSTRAINT [FK_RolePermission_Permission] FOREIGN KEY 
	(
		[PermissionId]
	) REFERENCES [dbo].[Permission] (
		[PermissionId]
	),
	CONSTRAINT [FK_RolePermission_Roles] FOREIGN KEY 
	(
		[RoleId]
	) REFERENCES [dbo].[Roles] (
		[RoleID]
	)
GO

ALTER TABLE [dbo].[UserProjects] ADD 
	CONSTRAINT [FK_UserProjects_Users] FOREIGN KEY 
	(
		[UserId]
	) REFERENCES [dbo].[Users] (
		[UserID]
	)
GO

ALTER TABLE [dbo].[UserRoles] ADD 
	CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY 
	(
		[RoleId]
	) REFERENCES [dbo].[Roles] (
		[RoleID]
	),
	CONSTRAINT [FK_UserRoles_Users] FOREIGN KEY 
	(
		[UserId]
	) REFERENCES [dbo].[Users] (
		[UserID]
	)
GO

ALTER TABLE [dbo].[Version] ADD 
	CONSTRAINT [FK_Version_Project] FOREIGN KEY 
	(
		[ProjectID]
	) REFERENCES [dbo].[Project] (
		[ProjectID]
	) ON DELETE CASCADE 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/* 
*---------------------------------------------------
*
*	Stored Procedures 
*
*---------------------------------------------------
*/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Attachment_CreateNewAttachment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Attachment_CreateNewAttachment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Attachment_GetAttachmentById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Attachment_GetAttachmentById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Attachment_GetAttachmentsByBugId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Attachment_GetAttachmentsByBugId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_BugNotification_CreateNewBugNotification]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_BugNotification_CreateNewBugNotification]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_BugNotification_DeleteBugNotification]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_BugNotification_DeleteBugNotification]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_BugNotification_GetBugNotificationsByBugId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_BugNotification_GetBugNotificationsByBugId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_CreateNewBug]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_CreateNewBug]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugComponentCountByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugComponentCountByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugPriorityCountByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugPriorityCountByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugStatusCountByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugStatusCountByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugTypeCountByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugTypeCountByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugUnassignedCountByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugUnassignedCountByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugUserCountByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugUserCountByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugVersionCountByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugVersionCountByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugsByCriteria]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugsByCriteria]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetBugsByProjectId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetBugsByProjectId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetChangeLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetChangeLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_GetRecentlyAddedBugsByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_GetRecentlyAddedBugsByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Bug_UpdateBug]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Bug_UpdateBug]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Comment_CreateNewComment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Comment_CreateNewComment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Comment_DeleteComment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Comment_DeleteComment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Comment_GetCommentById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Comment_GetCommentById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Comment_GetCommentsByBugId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Comment_GetCommentsByBugId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Comment_UpdateComment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Comment_UpdateComment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Component_CreateNewComponent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Component_CreateNewComponent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Component_DeleteComponent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Component_DeleteComponent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Component_GetComponentById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Component_GetComponentById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Component_GetComponentsByProjectId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Component_GetComponentsByProjectId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Environment_GetAllEnvironments]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Environment_GetAllEnvironments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Environment_GetEnvironmentById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Environment_GetEnvironmentById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Hardware_GetAllHardware]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Hardware_GetAllHardware]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Hardware_GetHardwareById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Hardware_GetHardwareById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_History_CreateNewHistory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_History_CreateNewHistory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_History_GetHistoryByBugId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_History_GetHistoryByBugId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_HostSettings_GetHostSettings]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_HostSettings_GetHostSettings]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_HostSettings_UpdateHostSetting]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_HostSettings_UpdateHostSetting]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_OperatingSystem_GetAllOperatingSystems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_OperatingSystem_GetAllOperatingSystems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_OperatingSystem_GetOperatingSystemById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_OperatingSystem_GetOperatingSystemById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Permission_AddRolePermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Permission_AddRolePermission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Permission_DeleteRolePermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Permission_DeleteRolePermission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Permission_GetAllPermissions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Permission_GetAllPermissions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Permission_GetPermissionsByRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Permission_GetPermissionsByRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Permission_GetRolePermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Permission_GetRolePermission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Priority_GetAllPriorities]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Priority_GetAllPriorities]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Priority_GetPriorityById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Priority_GetPriorityById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_AddUserToProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_AddUserToProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_CreateNewProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_CreateNewProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_CreateProjectMailbox]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_CreateProjectMailbox]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_DeleteProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_DeleteProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_DeleteProjectMailbox]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_DeleteProjectMailbox]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_GetAllProjects]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_GetAllProjects]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_GetMailboxByProjectId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_GetMailboxByProjectId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_GetProjectByCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_GetProjectByCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_GetProjectById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_GetProjectById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_GetProjectsByUserId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_GetProjectsByUserId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_GetPublicProjects]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_GetPublicProjects]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_RemoveUserFromProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_RemoveUserFromProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Project_UpdateProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Project_UpdateProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_RelatedBug_CreateNewRelatedBug]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_RelatedBug_CreateNewRelatedBug]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_RelatedBug_DeleteRelatedBug]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_RelatedBug_DeleteRelatedBug]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_RelatedBug_GetRelatedBugsByBugId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_RelatedBug_GetRelatedBugsByBugId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Resolution_GetAllResolutions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Resolution_GetAllResolutions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Resolution_GetResolutionById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Resolution_GetResolutionById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_AddUserToRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_AddUserToRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_CreateNewRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_CreateNewRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_DeleteRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_DeleteRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_GetAllRoles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_GetAllRoles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_GetRoleById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_GetRoleById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_GetRolesByProject]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_GetRolesByProject]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_GetRolesByUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_GetRolesByUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_GetRolesByUserId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_GetRolesByUserId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_IsUserInRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_IsUserInRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_RemoveUserFromRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_RemoveUserFromRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_RoleHasPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_RoleHasPermission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Role_UpdateRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Role_UpdateRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Status_GetAllStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Status_GetAllStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Status_GetStatusById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Status_GetStatusById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_TimeEntry_CreateNewTimeEntry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_TimeEntry_CreateNewTimeEntry]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_TimeEntry_DeleteTimeEntry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_TimeEntry_DeleteTimeEntry]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_TimeEntry_GetProjectWorkerWorkReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_TimeEntry_GetProjectWorkerWorkReport]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_TimeEntry_GetWorkReportByBugId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_TimeEntry_GetWorkReportByBugId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_TimeEntry_GetWorkReportByProjectId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_TimeEntry_GetWorkReportByProjectId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Type_GetAllTypes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Type_GetAllTypes]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Type_GetTypeById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Type_GetTypeById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_User_Authenticate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_User_Authenticate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_User_CreateNewUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_User_CreateNewUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_User_GetAllUsers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_User_GetAllUsers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_User_GetUserById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_User_GetUserById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_User_GetUserByUsername]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_User_GetUserByUsername]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_User_GetUsersByProjectId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_User_GetUsersByProjectId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_User_IsProjectMember]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_User_IsProjectMember]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_User_UpdateUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_User_UpdateUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Version_CreateNewVersion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Version_CreateNewVersion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Version_DeleteVersion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Version_DeleteVersion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Version_GetVersionById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Version_GetVersionById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BugNet_Version_GetVersionByProjectId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[BugNet_Version_GetVersionByProjectId]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Attachment_CreateNewAttachment
  @BugId int,
  @FileName nvarchar(100),
  @Description nvarchar(80),
  @FileSize Int,
  @ContentType nvarchar(50),
  @UploadedUserName nvarchar(100)
AS
-- Get Uploaded UserID
DECLARE @UploadedUserId Int
SELECT @UploadedUserId = UserId FROM Users WHERE Username = @UploadedUserName
	INSERT BugAttachment
	(
		BugID,
		FileName,
		Description,
		FileSize,
		Type,
		UploadedDate,
		UploadedUser
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Attachment_GetAttachmentById
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
	UploadedUser,
	Creators.UserName CreatorUserName,
	Creators.DisplayName CreatorDisplayName
FROM 
	BugAttachment
	INNER JOIN Users Creators ON Creators.UserId = BugAttachment.UploadedUser
WHERE
	BugAttachmentId = @AttachmentId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Attachment_GetAttachmentsByBugId
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
	UploadedUser,
	Creators.UserName CreatorUserName,
	Creators.DisplayName CreatorDisplayName
FROM 
	BugAttachment
	INNER JOIN Users Creators ON Creators.UserId = BugAttachment.UploadedUser
WHERE
	BugId = @BugId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_BugNotification_CreateNewBugNotification
	@BugId Int,
	@NotificationUsername NVarChar(255) 
AS
DECLARE @UserId Int
SELECT @UserId = UserId FROM Users WHERE Username = @NotificationUsername
IF NOT EXISTS( SELECT BugNotificationId FROM BugNotification WHERE UserId = @UserId AND BugId = @BugId)
BEGIN
	INSERT BugNotification
	(
		BugId,
		UserId
	)
	VALUES
	(
		@BugId,
		@UserId
	)
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_BugNotification_DeleteBugNotification
	@BugId Int,
	@Username NVarChar(255)
AS
DECLARE @UserId Int
SELECT @UserId = UserId FROM Users WHERE Username = @Username
DELETE 
	BugNotification
WHERE
	BugId = @BugId
	AND UserId = @UserId 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_BugNotification_GetBugNotificationsByBugId 
	@BugId Int
AS
SELECT 
	BugNotificationId,
	BugId,
	Username NotificationUsername,
	DisplayName NotificationDisplayName,
	Email NotificationEmail
FROM
	BugNotification
	INNER JOIN Users ON BugNotification.UserId = Users.UserId
WHERE
	BugId = @BugId
ORDER BY
	DisplayName

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_CreateNewBug
  @Summary nvarchar(500),
  @Description text,
  @Url nvarchar(500),
  @ProjectId Int,
  @ComponentId Int,
  @StatusId Int,
  @PriorityId Int,
  @VersionId Int,
  @HardwareId Int,
  @EnvironmentId int,
  @TypeId Int,
  @OperatingSystemId Int,
  @ResolutionId Int,
  @AssignedTo Int,
  @ReportedUser NVarChar(200)
AS
DECLARE @newIssueId Int
-- Get Reporter UserID
DECLARE @ReporterId Int
SELECT @ReporterId = UserId FROM Users WHERE Username = @ReportedUser
	INSERT Bug
	(
		Summary,
		Description,
		Url,
		ReportedUser,
		ReportedDate,
		StatusID,
		PriorityID,
		TypeId,
		EnvironmentID,
		ComponentID,
		AssignedTo,
		HardwareId,
		OperatingSystemId,
		ProjectId,
		ResolutionId,
		VersionId,
		LastUpdateUser,
		LastUpdate
	)
	VALUES
	(
		@Summary,
		@Description,
		@Url,
		@ReporterId,
		GetDate(),
		@StatusId,
		@PriorityId,
		@TypeId,
		@EnvironmentId,
		@ComponentId,
		@AssignedTo,
		@HardwareId,
		@OperatingSystemId,
		@ProjectId,
		@ResolutionId,
		@VersionId,
		@ReporterId,
		GetDate()
	)
RETURN scope_identity()
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugById 
  @BugId Int
AS
SELECT 
	*
FROM 
	BugsView
WHERE
	BugId = @BugId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugComponentCountByProject
 @ProjectId int,
 @ComponentId int
AS
	SELECT     Count(BugId) From Bug Where ProjectId = @ProjectId 
	AND ComponentId = @ComponentId AND StatusId <> 4 AND StatusId <> 5

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugPriorityCountByProject
 @ProjectId int
AS
	SELECT p.Name, COUNT(nt.PriorityID) AS Number, p.PriorityID 
	FROM   Priority p 
	LEFT OUTER JOIN (SELECT  PriorityID, ProjectID FROM   
	Bug b WHERE  (b.StatusID <> 4) AND (b.StatusID <> 5)) nt 
	ON p.PriorityID = nt.PriorityID AND nt.ProjectID = @ProjectId
	GROUP BY p.Name, p.PriorityID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugStatusCountByProject
 @ProjectId int
AS
	SELECT s.Name,Count(b.StatusID) as 'Number',s.StatusID 
	From Status s 
	LEFT JOIN Bug b on s.StatusID = b.StatusID AND b.ProjectID = @ProjectId 
	Group BY s.Name,s.StatusID Order By s.StatusID ASC

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugTypeCountByProject
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugUnassignedCountByProject
 @ProjectId int
AS
	SELECT     COUNT(BugID) AS Number 
	FROM Bug 
	WHERE (AssignedTo = 0) 
		AND (ProjectID = @ProjectId) 
		AND (StatusID <> 4) 
		AND (StatusID <> 5)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugUserCountByProject
 @ProjectId int
AS
	SELECT u.UserID,u.DisplayName, COUNT(b.BugID) AS Number FROM UserProjects pm 
	LEFT OUTER JOIN Users u ON pm.UserID = u.UserID 
	LEFT OUTER JOIN Bug b ON b.AssignedTo = u.UserID
	 WHERE (pm.ProjectID = @ProjectId) 
	 AND (b.ProjectID= @ProjectId ) 
	 AND (b.StatusID <> 4) 
	 AND (b.StatusID <> 5)  
	 GROUP BY u.DisplayName, u.UserID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugVersionCountByProject
	@ProjectId int
AS
	SELECT v.Name, COUNT(nt.VersionID) AS Number, v.VersionID 
	FROM Version v 
	LEFT OUTER JOIN (SELECT VersionID  
	FROM Bug b  
	WHERE (b.StatusID <> 4) AND (b.StatusID <> 5)) nt ON v.VersionID = nt.VersionID 
	WHERE (v.ProjectID = @ProjectId) 
	GROUP BY v.Name, v.VersionID
	ORDER BY v.VersionID DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.BugNet_Bug_GetBugsByCriteria
(
    @ProjectId int = NULL,
    @ComponentId int = NULL,
    @VersionId int = NULL,
    @PriorityId int = NULL,
    @TypeId int = NULL,
    @ResolutionId int = NULL,
    @StatusId int = NULL,
    @AssignedTo int = NULL,
    @HardwareId int = NULL,
    @OperatingSystemId int = NULL,
    @Keywords nvarchar(256) = NULL,
    @IncludeComments bit = NULL
)
AS
if @StatusId = 0 
 SELECT
    *
FROM
    BugsView 
WHERE
    ((@ProjectId IS NULL) OR (ProjectId = @ProjectId)) AND
    ((@ComponentId IS NULL) OR (ComponentId = @ComponentId)) AND
    ((@VersionId IS NULL) OR (VersionId = @VersionId)) AND
    ((@PriorityId IS NULL) OR (PriorityId = @PriorityId))AND
    ((@TypeId IS NULL) OR (TypeId = @TypeId)) AND
    ((@ResolutionId IS NULL) OR (ResolutionId = @ResolutionId)) AND
    ((@StatusId IS NULL) OR (StatusId In (1,2,3))) AND
    ((@AssignedTo IS NULL) OR (AssignedTo = @AssignedTo)) AND
    ((@HardwareId IS NULL) OR (HardwareId = @HardwareId)) AND
    ((@OperatingSystemId IS NULL) OR (OperatingSystemId = @OperatingSystemId))  AND 
    ((@Keywords IS NULL) OR (Description LIKE '%' + @Keywords + '%' )  OR (Summary LIKE '%' + @Keywords + '%' ) )
else
SELECT
    *
FROM
    BugsView
WHERE
    ((@ProjectId IS NULL) OR (ProjectId = @ProjectId)) AND
    ((@ComponentId IS NULL) OR (ComponentId = @ComponentId)) AND
    ((@VersionId IS NULL) OR (VersionId = @VersionId)) AND
    ((@PriorityId IS NULL) OR (PriorityId = @PriorityId))AND
    ((@TypeId IS NULL) OR (TypeId = @TypeId)) AND
    ((@ResolutionId IS NULL) OR (ResolutionId = @ResolutionId)) AND
    ((@StatusId IS NULL) OR (StatusId = @StatusId)) AND
    ((@AssignedTo IS NULL) OR (AssignedTo = @AssignedTo)) AND
    ((@HardwareId IS NULL) OR (HardwareId = @HardwareId)) AND
    ((@OperatingSystemId IS NULL) OR (OperatingSystemId = @OperatingSystemId)) AND
    ((@Keywords IS NULL) OR (Description LIKE '%' + @Keywords + '%' )  OR (Summary LIKE '%' + @Keywords + '%' ))
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetBugsByProjectId
	@ProjectId int
As
Select * from BugsView WHERE ProjectId = @ProjectId
Order By StatusId,PriorityName

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Bug_GetChangeLog 
	@ProjectId int
AS

Select * from BugsView WHERE ProjectId = @ProjectId  AND StatusID = 5
Order By VersionId DESC,ComponentName ASC, TypeName ASC, AssignedUserDisplayName ASC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_GetRecentlyAddedBugsByProject
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Bug_UpdateBug
  @BugId Int,
  @Summary nvarchar(500),
  @Description text,
  @Url nvarchar(500),
  @ProjectId Int,
  @ComponentId Int,
  @StatusId Int,
  @PriorityId Int,
  @VersionId Int,
  @HardwareId Int,
  @EnvironmentId int,
  @TypeId Int,
  @OperatingSystemId Int,
  @ResolutionId Int,
  @AssignedTo Int,
  @LastUpdateUserName NVarChar(200)
AS
DECLARE @newIssueId Int
-- Get Last Update UserID
DECLARE @LastUpdateUserId Int
SELECT @LastUpdateUserId = UserId FROM Users WHERE Username = @LastUpdateUserName
	Update Bug Set
		Summary = @Summary,
		Description =@Description,
		Url =@Url,
		StatusID =@StatusId,
		PriorityID =@PriorityId,
		TypeId = @TypeId,
		EnvironmentID =@EnvironmentId,
		ComponentID = @ComponentId,
		AssignedTo=@AssignedTo,
		HardwareId =@HardwareId,
		OperatingSystemId =@OperatingSystemId,
		ProjectId =@ProjectId,
		ResolutionId =@ResolutionId,
		VersionId =@VersionId,
		LastUpdateUser = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		BugId = @BugId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Comment_CreateNewComment
	@BugId int,
	@CreatorUserName NVarChar(100),
	@Comment text
AS
-- Get Last Update UserID
DECLARE @CreatorUserId Int
SELECT @CreatorUserId = UserId FROM Users WHERE Username = @CreatorUserName
INSERT BugComment
(
	BugId,
	UserId,
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
RETURN @@IDENTITY
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Comment_DeleteComment
	@BugCommentId Int
AS
DELETE 
	BugComment
WHERE
	BugCommentId = @BugCommentId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Comment_GetCommentById
 @BugCommentId INT
AS
SELECT
	BugCommentId,
	BugId,
	BugComment.UserId,
	CreatedDate,
	Comment,
	Creators.UserName CreatorUserName,
	Creators.Email CreatorEmail,
	Creators.DisplayName CreatorDisplayName
FROM 
	BugComment
	INNER JOIN Users Creators ON Creators.UserId = BugComment.UserId	
WHERE
	BugCommentId = @BugCommentId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Comment_GetCommentsByBugId
 @BugId INT
AS
SELECT
	BugCommentId,
	BugId,
	BugComment.UserId,
	CreatedDate,
	Comment,
	Creators.UserName CreatorUserName,
	Creators.Email CreatorEmail,
	Creators.DisplayName CreatorDisplayName
FROM 
	BugComment
	INNER JOIN Users Creators ON Creators.UserId = BugComment.UserId	
WHERE
	BugId = @BugId
ORDER BY 
	CreatedDate DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Comment_UpdateComment
	@BugCommentId int,
	@BugId int,
	@CreatorId int,
	@Comment ntext
AS

UPDATE BugComment SET
	BugId = @BugId,
	UserId = @CreatorId,
	Comment = @Comment
WHERE BugCommentId= @BugCommentId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Component_CreateNewComponent
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Component_DeleteComponent
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Component_GetComponentById
	@ComponentId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId
FROM Component
WHERE 
ComponentId = @ComponentId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Component_GetComponentsByProjectId
	@ProjectId int
AS
SELECT
	ComponentId,
	ProjectId,
	Name,
	ParentComponentId
FROM Component
WHERE 
ProjectId = @ProjectId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Environment_GetAllEnvironments
AS
SELECT
	EnvironmentId,
	Name
FROM 
	Environment

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE  BugNet_Environment_GetEnvironmentById
	@EnvironmentId int
AS
SELECT
	EnvironmentId,
	Name
FROM 
	Environment
WHERE 
	EnvironmentId = @EnvironmentId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Hardware_GetAllHardware
AS
SELECT
	HardwareId,
	Name
FROM 
	Hardware

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Hardware_GetHardwareById
	@HardwareId int
AS
SELECT
	HardwareId,
	Name
FROM 
	Hardware
WHERE
	HardwareId = @HardwareId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_History_CreateNewHistory
  @BugId int,
  @UserId int,
  @FieldChanged nvarchar(50),
  @OldValue nvarchar(50),
  @NewValue nvarchar(50)
AS
	INSERT BugHistory
	(
		BugId,
		UserId,
		FieldChanged,
		OldValue,
		NewValue,
		CreatedDate
	)
	VALUES
	(
		@BugId,
		@UserId,
		@FieldChanged,
		@OldValue,
		@NewValue,
		GetDate()
	)
RETURN @@IDENTITY
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_History_GetHistoryByBugId
	@BugId int
AS
 SELECT
	BugHistoryID,
	BugId,
	BugHistory.UserId,
	FieldChanged,
	OldValue,
	NewValue,
	CreatedDate,
	CreateUser.DisplayName
FROM 
	BugHistory
JOIN 
	Users CreateUser 
ON
	BugHistory.UserId = CreateUser.UserId
WHERE 
	BugId = @BugId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_HostSettings_GetHostSettings AS

SELECT SettingName, SettingValue FROM HostSettings
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_HostSettings_UpdateHostSetting
 @SettingName	nvarchar(50),
 @SettingValue 	nvarchar(256)
AS
UPDATE HostSettings SET
	SettingName = @SettingName,
	SettingValue = @SettingValue
WHERE
	SettingName  = @SettingName
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_OperatingSystem_GetAllOperatingSystems
AS
SELECT
	OperatingSystemId,
	Name
FROM 
	OperatingSystem

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_OperatingSystem_GetOperatingSystemById
	@OperatingSystemId int
AS
SELECT
	OperatingSystemId,
	Name
FROM 
	OperatingSystem
WHERE
	OperatingSystemId = @OperatingSystemId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Permission_AddRolePermission
	@PermissionId int,
	@RoleId int
AS
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Permission_DeleteRolePermission
	@PermissionId Int,
	@RoleId Int 
AS
DELETE 
	RolePermission
WHERE
	PermissionId = @PermissionId
	AND RoleId = @RoleId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Permission_GetAllPermissions AS

SELECT PermissionId,PermissionKey, Name  FROM Permission
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Permission_GetPermissionsByRole
	@RoleId int
 AS
SELECT Permission.PermissionId,PermissionKey, Name  FROM Permission
Inner join RolePermission on RolePermission.PermissionId = Permission.PermissionId
WHERE RoleId = @RoleId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE  BugNet_Permission_GetRolePermission  AS

Select R.RoleId, R.ProjectId,P.PermissionId,P.PermissionKey,R.RoleName
FROM RolePermission RP 
JOIN
Permission P ON RP.PermissionId = P.PermissionId
JOIN
Roles R ON RP.RoleId = R.RoleId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Priority_GetAllPriorities
AS
SELECT
	PriorityId,
	Name,
	ImageUrl
FROM 
	Priority


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Priority_GetPriorityById
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Project_AddUserToProject
@UserId int,
@ProjectId int
AS
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Project_CreateNewProject
 @Name nvarchar(50),
 @Code nvarchar(3),
 @Description 	nvarchar(80),
 @ManagerId 	 Int,
 @UploadPath nvarchar(80),
 @Active int,
 @AccessType int,
 @CreatorUserId	int
AS
IF NOT EXISTS( SELECT ProjectId  FROM Project WHERE LOWER(Name) = LOWER(@Name))
BEGIN
	INSERT Project 
	(
		Name,
		Code,
		Description,
		UploadPath,
		ManagerId,
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
		@ManagerId,
		GetDate(),
		@CreatorUserId,
		@AccessType,
		@Active
	)
 	RETURN @@IDENTITY
END
ELSE
  RETURN 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE BugNet_Project_CreateProjectMailbox
	@MailBox nvarchar (100),
	@ProjectID int,
	@AssignToUserID int,
	@IssueTypeID int
AS
INSERT ProjectMailBox 
(
	MailBox,
	ProjectID,
	AssignToUserID,
	IssueTypeID
)
VALUES
(
	@MailBox,
	@ProjectID,
	@AssignToUserID,
	@IssueTypeID
)
RETURN @@IDENTITY
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Project_DeleteProject
	@ProjectId int
AS

DELETE FROM Project where ProjectId = @ProjectId

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE BugNet_Project_DeleteProjectMailbox
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Project_GetAllProjects
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.DisplayName ManagerDisplayName,
	Creators.DisplayName CreatorDisplayName
FROM 
	Project
	INNER JOIN Users Managers ON Managers.UserId = ManagerId	
	INNER JOIN Users Creators ON Creators.UserId = CreatorUserId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE  PROCEDURE BugNet_Project_GetMailboxByProjectId
	@ProjectId int
AS

SELECT ProjectMailbox.*,
	Users.DisplayName AssignToName,
	Type.Name IssueTypeName
FROM 
	ProjectMailbox
	INNER JOIN Users ON Users.UserID = AssignToUserID
	INNER JOIN Type ON Type.TypeID = IssueTypeID	
WHERE
	ProjectId = @ProjectId


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Project_GetProjectByCode
 	@ProjectCode nvarchar(3)
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.DisplayName ManagerDisplayName,
	Creators.DisplayName CreatorDisplayName
FROM 
	Project
	INNER JOIN Users Managers ON Managers.UserId = ManagerId	
	INNER JOIN Users Creators ON Creators.UserId = CreatorUserId	
WHERE
	Code = @ProjectCode
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Project_GetProjectById
 @ProjectId INT
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.DisplayName ManagerDisplayName,
	Creators.DisplayName CreatorDisplayName
FROM 
	Project
	INNER JOIN Users Managers ON Managers.UserId = ManagerId	
	INNER JOIN Users Creators ON Creators.UserId = CreatorUserId	
WHERE
	ProjectId = @ProjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Project_GetProjectsByUserId
	@UserId int,
	@ActiveOnly bit
AS
SELECT DISTINCT
	Project.ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.DisplayName ManagerDisplayName,
	Creators.DisplayName CreatorDisplayName
FROM 
	Project
	Left JOIN Users Managers ON Managers.UserId = ManagerId	
	Left JOIN Users Creators ON Creators.UserId = CreatorUserId
	Left JOIN UserProjects ON UserProjects.ProjectId = Project.ProjectId
WHERE
	 (Project.AccessType = 1 AND Project.Active = @ActiveOnly) OR  UserProjects.UserId = @UserId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Project_GetPublicProjects
AS
SELECT
	ProjectId,
	Name,
	Code,
	Description,
	UploadPath,
	ManagerId,
	CreatorUserId,
	CreateDate,
	Project.Active,
	AccessType,
	Managers.DisplayName ManagerDisplayName,
	Creators.DisplayName CreatorDisplayName
FROM 
	Project
	INNER JOIN Users Managers ON Managers.UserId = ManagerId	
	INNER JOIN Users Creators ON Creators.UserId = CreatorUserId

WHERE AccessType = 1 AND Project.Active = 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Project_RemoveUserFromProject
	@UserId Int,
	@ProjectId Int 
AS
DELETE 
	UserProjects
WHERE
	UserId = @UserId
	AND ProjectId = @ProjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Project_UpdateProject
 @ProjectId 	int,
 @Name	nvarchar(50),
 @Code		nvarchar(3),
 @Description 	nvarchar(80),
 @ManagerId 	int,
 @UploadPath 	nvarchar(80),
 @AccessType int,
 @Active 	int
AS
UPDATE Project SET
	Name = @Name,
	Code = @Code,
	Description = @Description,
	ManagerID = @ManagerId,
	UploadPath = @UploadPath,
	AccessType = @AccessType,
	Active = @Active
WHERE
	ProjectId = @ProjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_RelatedBug_CreateNewRelatedBug
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_RelatedBug_DeleteRelatedBug
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_RelatedBug_GetRelatedBugsByBugId
	@BugId int
As
Select * from BugsView join RelatedBug on BugsView.BugId = RelatedBug.LinkedBugId
WHERE RelatedBug.BugId = @BugId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Resolution_GetAllResolutions
AS
SELECT
	ResolutionId,
	Name
FROM 
	Resolution

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Resolution_GetResolutionById
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Role_AddUserToRole
	@UserId int,
	@RoleId int
AS
IF NOT EXISTS (SELECT UserId FROM UserRoles WHERE UserId = @UserId AND RoleId = @RoleId)
BEGIN
	INSERT  UserRoles
	(
		UserId,
		RoleId
	)
	VALUES
	(
		@UserId,
		@RoleId
	)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Role_CreateNewRole
  @ProjectId 	int,
  @Name 	nvarchar(50),
  @Description 	nvarchar(256)
AS
	INSERT Roles
	(
		ProjectID,
		RoleName,
		Description
	)
	VALUES
	(
		@ProjectId,
		@Name,
		@Description
	)
RETURN @@IDENTITY
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Role_DeleteRole
	@RoleId Int 
AS
DELETE 
	Roles
WHERE
	RoleId = @RoleId
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Role_GetAllRoles
AS
SELECT RoleId, RoleName FROM Roles

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Role_GetRoleById
	@RoleId int
AS
SELECT RoleId, ProjectId,RoleName, Description FROM Roles
WHERE RoleId = @RoleId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Role_GetRolesByProject
	@ProjectId int
AS
SELECT RoleId,ProjectId, RoleName, Description FROM Roles
WHERE ProjectId = @ProjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE procedure BugNet_Role_GetRolesByUser
    
@UserId        int,
@ProjectId      int
as

select Roles.RoleName,
	Roles.ProjectId,
Roles.Description,
       Roles.RoleId
from UserRoles
inner join Users on UserRoles.UserId = Users.UserId
inner join Roles on UserRoles.RoleId = Roles.RoleId
where  Users.UserId = @UserId
and    Roles.ProjectId = @ProjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE procedure BugNet_Role_GetRolesByUserId
    
@UserId        int
as

select Roles.RoleName,
	Roles.ProjectId,
Roles.Description,
       Roles.RoleId
from UserRoles
inner join Users on UserRoles.UserId = Users.UserId
inner join Roles on UserRoles.RoleId = Roles.RoleId
where  Users.UserId = @UserId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

create procedure BugNet_Role_IsUserInRole
    
@UserId        int,
@RoleId        int,
@ProjectId      int

as

select UserRoles.UserId,
       UserRoles.RoleId
from UserRoles
inner join Roles on UserRoles.RoleId = Roles.RoleId
where  UserRoles.UserId = @UserId
and    UserRoles.RoleId = @RoleId
and    Roles.ProjectId = @ProjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Role_RemoveUserFromRole
	@UserId Int,
	@RoleId Int 
AS
DELETE 
	UserRoles
WHERE
	UserId = @UserId
	AND RoleId = @RoleId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Role_RoleHasPermission 
	@ProjectID 	int,
	@Role 		nvarchar(50),
	@PermissionKey nvarchar(50)
AS

select count(*) from RolePermission inner join Roles on Roles.RoleId = RolePermission.RoleId inner join
Permission on RolePermission.PermissionId = Permission.PermissionId

WHERE ProjectId = @ProjectID 
AND 
PermissionKey = @PermissionKey
AND 
Roles.RoleName = @Role
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_Role_UpdateRole
 @RoleId 	int,
 @Name	nvarchar(50),
 @Description 	 nvarchar(256)
AS
UPDATE Roles SET
	RoleName = @Name,
	Description = @Description
WHERE
	RoleId = @RoleId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Status_GetAllStatus
AS
SELECT
	StatusId,
	Name
FROM 
	Status

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Status_GetStatusById
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE BugNet_TimeEntry_CreateNewTimeEntry
	@BugId int,
	@CreatorUserName varchar(100),
	@WorkDate datetime ,
	@Duration decimal(4,2),
	@BugCommentId int
AS
-- Get Last Update UserID
DECLARE @CreatorUserId Int
SELECT @CreatorUserId = UserId FROM Users WHERE Username = @CreatorUserName
INSERT BugTimeEntry
(
	BugId,
	UserId,
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE BugNet_TimeEntry_DeleteTimeEntry
	@BugTimeEntryId int
AS
DELETE 
	BugTimeEntry
WHERE
	BugTimeEntryId = @BugTimeEntryId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE BugNet_TimeEntry_GetProjectWorkerWorkReport
 @ProjectId INT,
 @ReporterId INT
AS
SELECT     Project.ProjectId, Project.Name, Bug.BugId, Bug.Summary, Creators.DisplayName AS ReporterDisplayName,  BugTimeEntry.Duration,  BugTimeEntry.WorkDate,
                      ISNULL(BugComment.Comment, '') AS Comment
FROM         BugTimeEntry INNER JOIN
                      Users Creators ON Creators.UserId =  BugTimeEntry.UserId INNER JOIN
                      Bug ON  BugTimeEntry.BugId = Bug.BugId INNER JOIN
                      Project ON Bug.ProjectId = Project.ProjectId LEFT OUTER JOIN
                      BugComment ON BugComment.BugCommentId =  BugTimeEntry.BugCommentId
WHERE
	Project.ProjectID = @ProjectId AND
	( BugTimeEntry.UserId = @ReporterId OR @ReporterId = -1)
ORDER BY ReporterDisplayName, WorkDate
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE BugNet_TimeEntry_GetWorkReportByBugId
 @BugId INT
AS
SELECT      BugTimeEntry.*, Creators.UserName AS CreatorUserName, Creators.Email AS CreatorEmail, Creators.DisplayName AS CreatorDisplayName, 
                      ISNULL(BugComment.Comment, '') Comment
FROM         BugTimeEntry
	 INNER JOIN Users Creators ON Creators.UserID =  BugTimeEntry.UserId
	 LEFT OUTER JOIN BugComment ON BugComment.BugCommentId =  BugTimeEntry.BugCommentId
WHERE
	 BugTimeEntry.BugId = @BugId
ORDER BY WorkDate DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE BugNet_TimeEntry_GetWorkReportByProjectId
 @ProjectId INT
AS
SELECT     Project.ProjectID, Project.Name, Bug.BugID, Bug.Summary, Creators.DisplayName AS ReporterDisplayName,  BugTimeEntry.Duration, BugTimeEntry.WorkDate, 
                      ISNULL(BugComment.Comment, '') AS Comment
FROM        BugTimeEntry INNER JOIN
                      Users Creators ON Creators.UserId =  BugTimeEntry.UserId INNER JOIN
                      Bug ON  BugTimeEntry.BugId = Bug.BugId INNER JOIN
                      Project ON Bug.ProjectId = Project.ProjectId LEFT OUTER JOIN
                      BugComment ON BugComment.BugCommentId =  BugTimeEntry.BugCommentId
WHERE
	Project.ProjectId = @ProjectId
ORDER BY WorkDate
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId
 @ReporterId INT
AS
SELECT     Project.ProjectId, Project.Name, Bug.BugId, Bug.Summary, Creators.DisplayName AS CreatorDisplayName, BugTimeEntry.Duration, 
                      ISNULL(BugComment.Comment, '') AS Comment
FROM         BugTimeEntry INNER JOIN
                      Users Creators ON Creators.UserID =  BugTimeEntry.UserId INNER JOIN
                      Bug ON  BugTimeEntry.BugId = Bug.BugId INNER JOIN
                      Project ON Bug.ProjectId = Project.ProjectId LEFT OUTER JOIN
                      BugComment ON BugComment.BugCommentId =  BugTimeEntry.BugCommentId
WHERE
	 BugTimeEntry.UserId = @ReporterId
ORDER BY WorkDate
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Type_GetAllTypes
AS
SELECT
	TypeId,
	Name,
	ImageUrl
FROM 
	Type


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Type_GetTypeById
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.BugNet_User_Authenticate
@Username 	nvarchar(50),
  @Password	nvarchar(20)
AS
IF EXISTS( SELECT UserId FROM Users WHERE Username = @Username AND Password = @Password)
  RETURN 0
ELSE
  RETURN -1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_User_CreateNewUser
	@Username 	NVarChar(50),
	@Email 		NVarChar(250),
	@DisplayName 	NVarChar(250),
	@Password 	NVarChar(250),
	@Active 	bit,
	@IsSuperUser 	bit
AS
IF EXISTS(SELECT UserId FROM Users WHERE Username = @Username)
	RETURN 0
INSERT Users
(
	Username,
	Email,
	DisplayName,
	Password,
	Active,
	IsSuperUser
) 
VALUES 
(
	@Username,
	@Email,
	@DisplayName,
	@Password,
	@Active,
	@IsSuperUser
)
RETURN @@IDENTITY
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.BugNet_User_GetAllUsers
AS
SELECT 
	UserId, Username, Password, Email, DisplayName,Active, IsSuperUser
FROM 
	Users
ORDER BY DisplayName ASC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_User_GetUserById
	@UserId Int
AS
SELECT 
	UserId, Username, Password, Email, DisplayName,Active, IsSuperUser
FROM 
	Users
WHERE 
	UserId = @UserId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_User_GetUserByUsername
	@Username nvarchar(50)
AS
SELECT 
	UserId, Username, Password, Email, DisplayName,Active, IsSuperUser
FROM 
	Users
WHERE 
	Username = @Username
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_User_GetUsersByProjectId
	@ProjectId Int
AS
SELECT Users.UserId, Username, Password, DisplayName, Email, Active,IsSuperUser
FROM 
	Users
LEFT OUTER JOIN
	UserProjects
ON
	Users.UserId = UserProjects.UserId
WHERE
	UserProjects.ProjectId = @ProjectId
ORDER BY DisplayName ASC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_User_IsProjectMember
	@UserId	int,
 	@ProjectId	int
AS
IF EXISTS( SELECT UserId FROM UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
  RETURN 0
ELSE
  RETURN -1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.BugNet_User_UpdateUser
	@UserId Int,
	@Username NVarChar(250),
	@Email NVarChar(250),
	@DisplayName NVarChar(250),
	@Password NVarChar(250),
	@Active bit,
	@IsSuperUser bit
AS
IF EXISTS(SELECT UserId FROM Users WHERE Username = @Username AND UserID <> @UserId)
	RETURN 1
UPDATE Users SET
	Username = @Username,
	Email = @Email,
	DisplayName = @DisplayName,
	Password = @Password,
	Active = @Active,
	IsSuperUser = @IsSuperUser
WHERE 
	UserId = @UserId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Version_CreateNewVersion
  @ProjectId int,
  @Name nvarchar(50)
AS
	INSERT Version
	(
		ProjectID,
		Name
	)
	VALUES
	(
		@ProjectId,
		@Name
	)
RETURN @@IDENTITY
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Version_DeleteVersion
	@VersionId Int 
AS
DELETE 
	Version
WHERE
	VersionId = @VersionId
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Version_GetVersionById
 @VersionId INT
AS
SELECT
	VersionId,
	ProjectId,
	Name
FROM 
	Version
WHERE
	VersionId = @VersionId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE BugNet_Version_GetVersionByProjectId
 @ProjectId INT
AS
SELECT
	VersionId,
	ProjectId,
	Name
FROM 
	Version
WHERE
	ProjectId = @ProjectId
ORDER BY VersionId DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



/* Drop Uneeded Procedures */
PRINT 'Drop Unused Objects'
GO

DROP PROCEDURE BugNet_User_GetAllUsersByRoleName
GO

DROP PROCEDURE BugNet_Project_GetProjectsByMemberUserId
GO


/* Data Migration */
PRINT 'Data Migration'
GO

INSERT INTO UserProjects (UserId,ProjectId,CreatedDate)
SELECT UserId, ProjectId, GetDate()
FROM ProjectMembers
ORDER BY UserId
GO

DROP TABLE ProjectMembers
GO

ALTER VIEW dbo.BugsView
AS
SELECT     dbo.Bug.*, dbo.Status.Name AS StatusName, ISNULL(dbo.Component.Name, 'All Components') AS ComponentName, 
                      dbo.Environment.Name AS EnvironmentName, dbo.Hardware.Name AS HardwareName, dbo.OperatingSystem.Name AS OperatingSystemName, 
                      dbo.Priority.Name AS PriorityName, dbo.Project.Name AS ProjectName, dbo.Project.Code AS ProjectCode, dbo.Resolution.Name AS ResolutionName, 
                      dbo.Type.Name AS TypeName, ISNULL(dbo.Version.Name, 'Unassigned') AS VersionName, ISNULL(AssignedUsers.DisplayName, 'Unassigned') 
                      AS AssignedUserDisplayName, ReportedUsers.DisplayName AS ReporterDisplayName, 
                      LastUpdateUsers.DisplayName AS LastUpdateUserDisplayName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ReportedUsers.UserName AS ReporterUserName
FROM         dbo.Bug LEFT OUTER JOIN
                      dbo.Component ON dbo.Bug.ComponentID = dbo.Component.ComponentID LEFT OUTER JOIN
                      dbo.Environment ON dbo.Bug.EnvironmentID = dbo.Environment.EnvironmentID LEFT OUTER JOIN
                      dbo.Hardware ON dbo.Bug.HardwareID = dbo.Hardware.HardwareID LEFT OUTER JOIN
                      dbo.OperatingSystem ON dbo.Bug.OperatingSystemID = dbo.OperatingSystem.OperatingSystemID LEFT OUTER JOIN
                      dbo.Priority ON dbo.Bug.PriorityID = dbo.Priority.PriorityID LEFT OUTER JOIN
                      dbo.Project ON dbo.Bug.ProjectID = dbo.Project.ProjectID LEFT OUTER JOIN
                      dbo.Resolution ON dbo.Bug.ResolutionID = dbo.Resolution.ResolutionID LEFT OUTER JOIN
                      dbo.Status ON dbo.Bug.StatusID = dbo.Status.StatusID LEFT OUTER JOIN
                      dbo.Type ON dbo.Bug.TypeID = dbo.Type.TypeID LEFT OUTER JOIN
                      dbo.Version ON dbo.Bug.VersionID = dbo.Version.VersionID LEFT OUTER JOIN
                      dbo.Users AssignedUsers ON dbo.Bug.AssignedTo = AssignedUsers.UserID LEFT OUTER JOIN
                      dbo.Users ReportedUsers ON dbo.Bug.ReportedUser = ReportedUsers.UserID LEFT OUTER JOIN
                      dbo.Users LastUpdateUsers ON dbo.Bug.LastUpdateUser = LastUpdateUsers.UserID
GO

/* Permissions */
INSERT INTO Permission(PermissionKey,Name) Values ('CLOSE_ISSUE','Close Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('ADD_ISSUE','Add Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('ASSIGN_ISSUE','Assign Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('EDIT_ISSUE','Edit Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('SUBSCRIBE_ISSUE','Subscribe Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('DELETE_ISSUE','Delete Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('ADD_COMMENT','Add Comment')
INSERT INTO Permission(PermissionKey,Name) Values ('EDIT_COMMENT','Edit Comment')
INSERT INTO Permission(PermissionKey,Name) Values ('DELETE_COMMENT','Delete Comment')
INSERT INTO Permission(PermissionKey,Name) Values ('ADD_ATTACHMENT','Add Attachment')
INSERT INTO Permission(PermissionKey,Name) Values ('DELETE_ATTACHMENT','Delete Attachment')
INSERT INTO Permission(PermissionKey,Name) Values ('ADD_RELATED','Add Related Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('DELETE_RELATED','Delete Related Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('REOPEN_ISSUE','Re-Open Issue')
INSERT INTO Permission(PermissionKey,Name) Values ('OWNER_EDIT_COMMENT','Edit Own Comments')
INSERT INTO Permission(PermissionKey,Name) Values ('EDIT_ISSUE_DESCRIPTION','Edit Issue Description')
INSERT INTO Permission(PermissionKey,Name) Values ('EDIT_ISSUE_SUMMARY','Edit Issue Summary')
INSERT INTO Permission(PermissionKey,Name) Values ('ADMIN_EDIT_PROJECT','Admin Edit Project')
INSERT INTO Permission(PermissionKey,Name) Values ('ADD_TIME_ENTRY','Add Time Entry')
INSERT INTO Permission(PermissionKey,Name) Values ('DELETE_TIME_ENTRY','Delete Time Entry')

/* Host Settings */
INSERT INTO HostSettings(SettingName,SettingValue) Values('Version','0.66')
INSERT INTO HostSettings(SettingName,SettingValue) Values('DefaultUrl','http://localhost/BugNet/')
INSERT INTO HostSettings(SettingName,SettingValue) Values('HostEmailAddress','BugNet&lt;noreply@mysmtpserver&gt;')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3BodyTemplate','&lt;div &gt;Sent by:{1} on: {2}&lt;br&gt;{0}&lt;/div&gt;')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3DeleteAllMessages','False')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3InlineAttachedPictures','False')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3Interval','10')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3Password','')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3ReaderEnabled','False')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3ReportingUsername','Admin')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3Server','')
INSERT INTO HostSettings(SettingName,SettingValue) Values('Pop3Username','bugnetuser')
INSERT INTO HostSettings(SettingName,SettingValue) Values('SMTPAuthentication','False')
INSERT INTO HostSettings(SettingName,SettingValue) Values('SMTPPassword','')
INSERT INTO HostSettings(SettingName,SettingValue) Values('SMTPServer','localhost')
INSERT INTO HostSettings(SettingName,SettingValue) Values('SMTPUsername','')
INSERT INTO HostSettings(SettingName,SettingValue) Values('UserAccountSource','None')
INSERT INTO HostSettings(SettingName,SettingValue) Values('WelcomeMessage','')
INSERT INTO HostSettings(SettingName,SettingValue) Values('ADUserName','')
INSERT INTO HostSettings(SettingName,SettingValue) Values('ADPassword','')
INSERT INTO HostSettings(SettingName,SettingValue) Values('DisableUserRegistration','False')
INSERT INTO HostSettings(SettingName,SettingValue) Values('DisableAnonymousAccess','False')

/*Create read only & admin roles for each project */
declare @ProjectId int
declare @RowNum int
declare @ProjectCount int
	
set @RowNum = 0 

select @ProjectCount = count(ProjectId) from Project
select top 1 @ProjectId = ProjectId from Project


WHILE @RowNum < @ProjectCount

BEGIN
	set @RowNum = @RowNum + 1
	INSERT INTO Roles(ProjectId,RoleName, Description) Values(@ProjectId,'Administrators','Project Administration')
	INSERT INTO Roles(ProjectId,RoleName, Description) Values(@ProjectId,'Read Only','Read Only Users')
	select top 1 @ProjectId=ProjectID from Project where ProjectId > @ProjectID 
END

/*Update Admin user with super user privilidges */
UPDATE Users SET IsSuperUser = 1 WHERE Username = 'Admin'



/* END TRANSACTION */


--end of db update code
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update was successful'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO