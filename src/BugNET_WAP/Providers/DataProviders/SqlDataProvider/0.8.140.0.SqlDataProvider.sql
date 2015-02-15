/************************************************************/
/*****              SqlDataProvider                     *****/
/************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN

IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_IssueAttachments_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_IssueAttachments_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_IssueAttachments] DROP CONSTRAINT [DF_BugNet_IssueAttachments_DateCreated]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_IssueComments_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_IssueComments_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_IssueComments] DROP CONSTRAINT [DF_BugNet_IssueComments_DateCreated]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_IssueHistory_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_IssueHistory_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_IssueHistory] DROP CONSTRAINT [DF_BugNet_IssueHistory_DateCreated]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_DueDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_DueDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [DF_BugNet_Issues_DueDate]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_Estimation]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_Estimation]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [DF_BugNet_Issues_Estimation]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_IssueProgress]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_IssueProgress]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [DF_BugNet_Issues_IssueProgress]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [DF_BugNet_Issues_DateCreated]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_Disabled]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [DF_BugNet_Issues_Disabled]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_ProjectCategories_ParentCategoryId]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_ProjectCategories_ParentCategoryId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_ProjectCategories] DROP CONSTRAINT [DF_BugNet_ProjectCategories_ParentCategoryId]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelections]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldSelections] DROP CONSTRAINT [DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_ProjectMilestones_CreateDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_ProjectMilestones_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_ProjectMilestones] DROP CONSTRAINT [DF_BugNet_ProjectMilestones_CreateDate]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Projects_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Projects_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Projects] DROP CONSTRAINT [DF_BugNet_Projects_DateCreated]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Projects_Active]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Projects_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Projects] DROP CONSTRAINT [DF_BugNet_Projects_Active]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Projects_AllowAttachments]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Projects_AllowAttachments]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Projects] DROP CONSTRAINT [DF_BugNet_Projects_AllowAttachments]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Queries_IsPublic]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Queries_IsPublic]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Queries] DROP CONSTRAINT [DF_BugNet_Queries_IsPublic]
END


End
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueAttachments_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]'))
ALTER TABLE [dbo].[BugNet_IssueAttachments] DROP CONSTRAINT [FK_BugNet_IssueAttachments_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueAttachments_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]'))
ALTER TABLE [dbo].[BugNet_IssueAttachments] DROP CONSTRAINT [FK_BugNet_IssueAttachments_BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueComments_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]'))
ALTER TABLE [dbo].[BugNet_IssueComments] DROP CONSTRAINT [FK_BugNet_IssueComments_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueComments_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]'))
ALTER TABLE [dbo].[BugNet_IssueComments] DROP CONSTRAINT [FK_BugNet_IssueComments_BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueHistory_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]'))
ALTER TABLE [dbo].[BugNet_IssueHistory] DROP CONSTRAINT [FK_BugNet_IssueHistory_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueHistory_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]'))
ALTER TABLE [dbo].[BugNet_IssueHistory] DROP CONSTRAINT [FK_BugNet_IssueHistory_BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueNotifications_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotifications]'))
ALTER TABLE [dbo].[BugNet_IssueNotifications] DROP CONSTRAINT [FK_BugNet_IssueNotifications_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueNotifications_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotifications]'))
ALTER TABLE [dbo].[BugNet_IssueNotifications] DROP CONSTRAINT [FK_BugNet_IssueNotifications_BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueRevisions_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevisions]'))
ALTER TABLE [dbo].[BugNet_IssueRevisions] DROP CONSTRAINT [FK_BugNet_IssueRevisions_BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_aspnet_Users1]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users2]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_aspnet_Users2]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users3]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_aspnet_Users3]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectCategories]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectCategories]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectIssueTypes]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectIssueTypes]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectMilestones]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectMilestones1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones1]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectPriorities]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectPriorities]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectResolutions]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectResolutions]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] DROP CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectStatus]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueWorkReports_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReports]'))
ALTER TABLE [dbo].[BugNet_IssueWorkReports] DROP CONSTRAINT [FK_BugNet_IssueWorkReports_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueWorkReports_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReports]'))
ALTER TABLE [dbo].[BugNet_IssueWorkReports] DROP CONSTRAINT [FK_BugNet_IssueWorkReports_BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCategories_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories]'))
ALTER TABLE [dbo].[BugNet_ProjectCategories] DROP CONSTRAINT [FK_BugNet_ProjectCategories_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFields]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFields] DROP CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFields_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFields]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFields] DROP CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelections]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldSelections] DROP CONSTRAINT [FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldValues_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldValues]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues] DROP CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldValues]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues] DROP CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectIssueTypes_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes]'))
ALTER TABLE [dbo].[BugNet_ProjectIssueTypes] DROP CONSTRAINT [FK_BugNet_ProjectIssueTypes_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectMailBoxes_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMailBoxes]'))
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes] DROP CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectMilestones_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones]'))
ALTER TABLE [dbo].[BugNet_ProjectMilestones] DROP CONSTRAINT [FK_BugNet_ProjectMilestones_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectNotifications_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotifications]'))
ALTER TABLE [dbo].[BugNet_ProjectNotifications] DROP CONSTRAINT [FK_BugNet_ProjectNotifications_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectNotifications_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotifications]'))
ALTER TABLE [dbo].[BugNet_ProjectNotifications] DROP CONSTRAINT [FK_BugNet_ProjectNotifications_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectPriorities_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities]'))
ALTER TABLE [dbo].[BugNet_ProjectPriorities] DROP CONSTRAINT [FK_BugNet_ProjectPriorities_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectResolutions_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions]'))
ALTER TABLE [dbo].[BugNet_ProjectResolutions] DROP CONSTRAINT [FK_BugNet_ProjectResolutions_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Projects_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
ALTER TABLE [dbo].[BugNet_Projects] DROP CONSTRAINT [FK_BugNet_Projects_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Projects_aspnet_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
ALTER TABLE [dbo].[BugNet_Projects] DROP CONSTRAINT [FK_BugNet_Projects_aspnet_Users1]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectStatus_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus]'))
ALTER TABLE [dbo].[BugNet_ProjectStatus] DROP CONSTRAINT [FK_BugNet_ProjectStatus_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Queries_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]'))
ALTER TABLE [dbo].[BugNet_Queries] DROP CONSTRAINT [FK_BugNet_Queries_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Queries_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]'))
ALTER TABLE [dbo].[BugNet_Queries] DROP CONSTRAINT [FK_BugNet_Queries_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_QueryClauses_BugNet_Queries]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_QueryClauses]'))
ALTER TABLE [dbo].[BugNet_QueryClauses] DROP CONSTRAINT [FK_BugNet_QueryClauses_BugNet_Queries]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RelatedIssues_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]'))
ALTER TABLE [dbo].[BugNet_RelatedIssues] DROP CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RelatedIssues_BugNet_Issues1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]'))
ALTER TABLE [dbo].[BugNet_RelatedIssues] DROP CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues1]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RolePermissions_BugNet_Permissions]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RolePermissions]'))
ALTER TABLE [dbo].[BugNet_RolePermissions] DROP CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Permissions]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RolePermissions_BugNet_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RolePermissions]'))
ALTER TABLE [dbo].[BugNet_RolePermissions] DROP CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Roles_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Roles]'))
ALTER TABLE [dbo].[BugNet_Roles] DROP CONSTRAINT [FK_BugNet_Roles_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserProjects_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserProjects]'))
ALTER TABLE [dbo].[BugNet_UserProjects] DROP CONSTRAINT [FK_BugNet_UserProjects_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserProjects_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserProjects]'))
ALTER TABLE [dbo].[BugNet_UserProjects] DROP CONSTRAINT [FK_BugNet_UserProjects_BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserRoles_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserRoles]'))
ALTER TABLE [dbo].[BugNet_UserRoles] DROP CONSTRAINT [FK_BugNet_UserRoles_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserRoles_BugNet_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserRoles]'))
ALTER TABLE [dbo].[BugNet_UserRoles] DROP CONSTRAINT [FK_BugNet_UserRoles_BugNet_Roles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByAssignedUserName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssuesByAssignedUserName]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByCreatorUserName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssuesByCreatorUserName]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByOwnerUserName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssuesByOwnerUserName]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssuesByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByRelevancy]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssuesByRelevancy]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssueById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetRoadMap]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetRoadMap]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetRoadMapProgress]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetRoadMapProgress]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetChangeLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetChangeLog]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_DeleteCustomField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_GetCustomFieldsByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByIssueId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_SaveCustomFieldValue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomField_SaveCustomFieldValue]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssuesView]'))
DROP VIEW [dbo].[BugNet_IssuesView]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory_CreateNewIssueHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueHistory_CreateNewIssueHistory]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotification_CreateNewIssueNotification]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueNotification_CreateNewIssueNotification]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotification_DeleteIssueNotification]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueNotification_DeleteIssueNotification]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReport_DeleteIssueWorkReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueWorkReport_DeleteIssueWorkReport]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]'))
DROP VIEW [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachment_DeleteIssueAttachment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueAttachment_DeleteIssueAttachment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_CreateNewIssueComment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueComment_CreateNewIssueComment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_DeleteIssueComment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueComment_DeleteIssueComment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_GetIssueCommentById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_UpdateIssueComment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueComment_UpdateIssueComment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevision_CreateNewIssueRevision]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevision_DeleteIssueRevisions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueRevision_DeleteIssueRevisions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_CreateNewChildIssue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewChildIssue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_CreateNewParentIssue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewParentIssue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_CreateNewRelatedIssue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewRelatedIssue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_DeleteChildIssue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteChildIssue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_DeleteParentIssue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteParentIssue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_DeleteRelatedIssue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteRelatedIssue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_GetChildIssues]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_GetChildIssues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_GetParentIssues]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_GetParentIssues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_GetRelatedIssues]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedIssue_GetRelatedIssues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_RelatedIssues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_Update]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_DeleteQuery]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Query_DeleteQuery]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_GetSavedQuery]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Query_GetSavedQuery]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_SaveQueryClause]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Query_SaveQueryClause]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_AddUserToRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_AddUserToRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetRolesByUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_GetRolesByUser]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_IsUserInRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_IsUserInRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_RemoveUserFromRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_RemoveUserFromRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_RoleHasPermission]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_RoleHasPermission]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetProjectRolesByUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_GetProjectRolesByUser]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevisions]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_IssueRevisions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_IssueComments]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_IssueHistory]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_IssueAttachments]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueStatusCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssueStatusCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueTypeCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssueTypeCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueUnassignedCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssueUnassignedCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueUserCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssueUserCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_UpdateIssue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_UpdateIssue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReports]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_IssueWorkReports]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_AddRolePermission]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Permission_AddRolePermission]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_DeleteRolePermission]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Permission_DeleteRolePermission]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotifications]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_IssueNotifications]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueCategoryCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssueCategoryCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueMilestoneCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuePriorityCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_CreateNewIssue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_CreateNewIssue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Issue_Delete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_GetPermissionsByRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Permission_GetPermissionsByRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_GetRolePermission]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Permission_GetRolePermission]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetMemberRolesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetMemberRolesByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_CloneProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_CloneProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldValues]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectCustomFieldValues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_CreateNewIssueType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CreateNewIssueType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_DeleteIssueType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectIssueTypes_DeleteIssueType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_GetIssueTypeById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypeById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_GetIssueTypesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypesByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_UpdateIssueType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectIssueTypes_UpdateIssueType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_CreateNewCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCategories_CreateNewCategory]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_DeleteCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCategories_DeleteCategory]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_GetCategoryById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoryById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_UpdateCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCategories_UpdateCategory]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_CreateNewCustomField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomField_CreateNewCustomField]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_UpdateCustomField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomField_UpdateCustomField]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_GetCustomFieldsByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_GetCustomFieldById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetProjectById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectMembers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetProjectMembers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectsByMemberUsername]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUsername]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetPublicProjects]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetPublicProjects]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_AddUserToProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_AddUserToProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_IsUserProjectMember]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_IsUserProjectMember]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_RemoveUserFromProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_RemoveUserFromProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_Issues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetRoleById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_GetRoleById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetRolesByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_GetRolesByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetAllProjects]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetAllProjects]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_User_GetUsersByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_UserRoles]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_UserRoles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_UpdateRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_UpdateRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RolePermissions]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_RolePermissions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_RoleExists]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_RoleExists]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_CreateNewRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_CreateNewRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_DeleteRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_DeleteRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetAllRoles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Role_GetAllRoles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_QueryClauses]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_QueryClauses]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_SaveQuery]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Query_SaveQuery]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_GetQueriesByUserName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Query_GetQueriesByUserName]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelections]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectCustomFieldSelections]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_CreateNewStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectStatus_CreateNewStatus]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_DeleteStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectStatus_DeleteStatus]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_GetStatusById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_GetStatusByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_UpdateStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectStatus_UpdateStatus]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_CreateNewMilestone]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMilestones_CreateNewMilestone]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_DeleteMilestone]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMilestones_DeleteMilestone]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_GetMilestoneById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestoneById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_UpdateMilestone]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectMilestones_UpdateMilestone]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotification_DeleteProjectNotification]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectNotification_DeleteProjectNotification]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_CreateNewPriority]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectPriorities_CreateNewPriority]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_DeletePriority]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectPriorities_DeletePriority]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_GetPrioritiesByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPrioritiesByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_GetPriorityById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPriorityById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_UpdatePriority]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectPriorities_UpdatePriority]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_CreateNewResolution]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectResolutions_CreateNewResolution]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_DeleteResolution]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectResolutions_DeleteResolution]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_GetResolutionById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_GetResolutionsByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionsByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_UpdateResolution]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ProjectResolutions_UpdateResolution]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectStatus]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectResolutions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotifications]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectNotifications]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectPriorities]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectsView]'))
DROP VIEW [dbo].[BugNet_ProjectsView]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_Queries]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Roles]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_Roles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_UserProjects]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_UserProjects]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_UpdateProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_UpdateProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectCategories]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFields]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectCustomFields]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_CreateNewProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_DeleteProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_DeleteProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMailBoxes]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectMailBoxes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectMilestones]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectIssueTypes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_CreateProjectMailbox]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_CreateProjectMailbox]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectByCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetProjectByCode]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetMailboxByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetMailboxByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectByMailbox]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetProjectByMailbox]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueVote_CreateNewIssueVote]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueVote_CreateNewIssueVote]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueVote_HasUserVoted]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_IssueVote_HasUserVoted]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_Projects]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RequiredField_GetRequiredFieldListForIssues]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RequiredField_GetRequiredFieldListForIssues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_HostSetting_GetHostSettings]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_HostSetting_GetHostSettings]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_HostSetting_UpdateHostSetting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_HostSetting_UpdateHostSetting]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ApplicationLog_ClearLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ApplicationLog_ClearLog]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ApplicationLog_GetLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ApplicationLog_GetLog]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_GetAllPermissions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Permission_GetAllPermissions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueVotes]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_IssueVotes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permissions]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_Permissions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_DeleteProjectMailbox]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_DeleteProjectMailbox]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_HostSettings]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_HostSettings]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ApplicationLog]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ApplicationLog]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RequiredFieldList]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_RequiredFieldList]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldTypes]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_ProjectCustomFieldTypes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_StringResources]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_StringResources]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_UserProfiles]') AND type in (N'U'))
DROP TABLE [dbo].[BugNet_UserProfiles]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_UserProfiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_UserProfiles](
	[UserName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[DisplayName] [nvarchar](100) NULL,
	[IssuesPageSize] [int] NULL,
	[NotificationTypes] [nvarchar](255) NULL,
	[PreferredLocale] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_BugNet_UserProfiles] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_StringResources]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_StringResources](
	[resourceType] [nvarchar](256) NOT NULL,
	[cultureCode] [nvarchar](10) NOT NULL,
	[resourceKey] [nvarchar](128) NOT NULL,
	[resourceValue] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_BugNet_StringResources] PRIMARY KEY CLUSTERED 
(
	[resourceType] ASC,
	[cultureCode] ASC,
	[resourceKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectCustomFieldTypes](
	[CustomFieldTypeId] [int] IDENTITY(1,1) NOT NULL,
	[CustomFieldTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCustomFieldTypes] PRIMARY KEY CLUSTERED 
(
	[CustomFieldTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RequiredFieldList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_RequiredFieldList](
	[RequiredFieldId] [int] NOT NULL,
	[FieldName] [nvarchar](50) NOT NULL,
	[FieldValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BugNet_RequiredFieldList] PRIMARY KEY CLUSTERED 
(
	[RequiredFieldId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ApplicationLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ApplicationLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Thread] [varchar](255) NOT NULL,
	[Level] [varchar](50) NOT NULL,
	[Logger] [varchar](255) NOT NULL,
	[User] [nvarchar](50) NOT NULL,
	[Message] [varchar](4000) NOT NULL,
	[Exception] [varchar](2000) NULL,
 CONSTRAINT [PK_BugNet_ApplicationLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_HostSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_HostSettings](
	[SettingName] [nvarchar](50) NOT NULL,
	[SettingValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_BugNet_HostSettings] PRIMARY KEY CLUSTERED 
(
	[SettingName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_DeleteProjectMailbox]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_Project_DeleteProjectMailbox]
	@ProjectMailboxId int
AS
DELETE  ProjectMailBox 
WHERE
	ProjectMailboxId = @ProjectMailboxId

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permissions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_Permissions](
	[PermissionId] [int] NOT NULL,
	[PermissionKey] [nvarchar](50) NOT NULL,
	[PermissionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BugNet_Permissions] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueVotes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_IssueVotes](
	[IssueVoteId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueVotes] PRIMARY KEY CLUSTERED 
(
	[IssueVoteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_GetAllPermissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Permission_GetAllPermissions] AS

SELECT PermissionId, PermissionKey, PermissionName  FROM BugNet_Permissions
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ApplicationLog_GetLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_GetLog] 
@FilterType nvarchar(50) = NULL
AS


SELECT L.* FROM BugNet_ApplicationLog L 
WHERE  
((@FilterType IS NULL) OR (Level = @FilterType))
ORDER BY L.Date DESC





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ApplicationLog_ClearLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_ClearLog] 
	
AS
	DELETE FROM BugNet_ApplicationLog
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_HostSetting_UpdateHostSetting]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_HostSetting_UpdateHostSetting]
 @SettingName	nvarchar(50),
 @SettingValue 	nvarchar(2000)
AS
UPDATE BugNet_HostSettings SET
	SettingName = @SettingName,
	SettingValue = @SettingValue
WHERE
	SettingName  = @SettingName

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_HostSetting_GetHostSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_HostSetting_GetHostSettings] AS

SELECT SettingName, SettingValue FROM BugNet_HostSettings
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RequiredField_GetRequiredFieldListForIssues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_RequiredField_GetRequiredFieldListForIssues] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RequiredFieldId, FieldName, FieldValue FROM BugNet_RequiredFieldList
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_Projects](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](50) NOT NULL,
	[ProjectCode] [nvarchar](50) NOT NULL,
	[ProjectDescription] [nvarchar](max) NOT NULL,
	[AttachmentUploadPath] [nvarchar](256) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[ProjectDisabled] [bit] NOT NULL,
	[ProjectAccessType] [int] NOT NULL,
	[ProjectManagerUserId] [uniqueidentifier] NOT NULL,
	[ProjectCreatorUserId] [uniqueidentifier] NOT NULL,
	[AllowAttachments] [bit] NOT NULL,
	[AttachmentStorageType] [int] NULL,
	[SvnRepositoryUrl] [nvarchar](255) NULL,
 CONSTRAINT [PK_BugNet_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueVote_HasUserVoted]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueVote_HasUserVoted]
	@IssueId Int,
	@VoteUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @VoteUserName

BEGIN
    IF EXISTS(SELECT IssueVoteId FROM BugNet_IssueVotes WHERE UserId = @UserId AND IssueId = @IssueId)
        RETURN(1)
    ELSE
        RETURN(0)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueVote_CreateNewIssueVote]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueVote_CreateNewIssueVote]
	@IssueId Int,
	@VoteUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @VoteUserName

IF NOT EXISTS( SELECT IssueVoteId FROM BugNet_IssueVotes WHERE UserId = @UserId AND IssueId = @IssueId)
BEGIN
	INSERT BugNet_IssueVotes
	(
		IssueId,
		UserId,
		DateCreated
	)
	VALUES
	(
		@IssueId,
		@UserId,
		GETDATE()
	)
	RETURN scope_identity()
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectByMailbox]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectByMailbox]
	(
	@mailbox nvarchar(256)
	)
	
AS
	SET NOCOUNT ON 
	
	SELECT  Mailbox,ProjectMailbox.ProjectId,IssueTypeId,Users.UserName as AssignToName, AssignToUserId FROM Project INNER JOIN ProjectMailbox 
	ON ProjectMailbox.ProjectId = Project.ProjectId
	INNER JOIN aspnet_users Users ON ProjectMailbox.AssignToUserId = Users.UserId	
	
	WHERE ProjectMailbox.Mailbox = @mailbox
	' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetMailboxByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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

' 
END
GO
/****** Object:  StoredProcedure [dbo].[BugNet_Project_CreateProjectMailbox]    Script Date: 10/17/2009 10:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_CreateProjectMailbox]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
RETURN @@IDENTITY' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectIssueTypes](
	[IssueTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[IssueTypeName] [nvarchar](50) NOT NULL,
	[IssueTypeImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectIssueTypes] PRIMARY KEY CLUSTERED 
(
	[IssueTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectMilestones](
	[MilestoneId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[MilestoneName] [nvarchar](50) NOT NULL,
	[MilestoneImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[MilestoneDueDate] [datetime] NULL,
 CONSTRAINT [PK_BugNet_ProjectMilestones] PRIMARY KEY CLUSTERED 
(
	[MilestoneId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMailBoxes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectMailBoxes](
	[ProjectMailboxId] [int] IDENTITY(1,1) NOT NULL,
	[MailBox] [nvarchar](100) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[AssignToUserId] [uniqueidentifier] NULL,
	[IssueTypeId] [int] NULL,
 CONSTRAINT [PK_BugNet_ProjectMailBoxes] PRIMARY KEY CLUSTERED 
(
	[ProjectMailboxId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_DeleteProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_DeleteProject]
	@ProjectIdToDelete int
AS

UPDATE BugNet_Projects SET ProjectDisabled = 1 WHERE ProjectId = @ProjectIdToDelete
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_CreateNewProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
 @ProjectName nvarchar(50),
 @ProjectCode nvarchar(50),
 @ProjectDescription 	nvarchar(1000),
 @ProjectManagerUserName nvarchar(255),
 @AttachmentUploadPath nvarchar(80),
 @ProjectAccessType int,
 @ProjectCreatorUserName nvarchar(255),
 @AllowAttachments int,
 @AttachmentStorageType	int,
 @SvnRepositoryUrl	nvarchar(255)
AS
IF NOT EXISTS( SELECT ProjectId,ProjectCode  FROM BugNet_Projects WHERE LOWER(ProjectName) = LOWER(@ProjectName) OR LOWER(ProjectCode) = LOWER(@ProjectCode) )
BEGIN
	DECLARE @ProjectManagerUserId UNIQUEIDENTIFIER
	DECLARE @ProjectCreatorUserId UNIQUEIDENTIFIER
	SELECT @ProjectManagerUserId = UserId FROM aspnet_users WHERE Username = @ProjectManagerUserName
	SELECT @ProjectCreatorUserId = UserId FROM aspnet_users WHERE Username = @ProjectCreatorUserName
	
	INSERT BugNet_Projects 
	(
		ProjectName,
		ProjectCode,
		ProjectDescription,
		AttachmentUploadPath,
		ProjectManagerUserId,
		DateCreated,
		ProjectCreatorUserId,
		ProjectAccessType,
		AllowAttachments,
		AttachmentStorageType,
		SvnRepositoryUrl
	) 
	VALUES
	(
		@ProjectName,
		@ProjectCode,
		@ProjectDescription,
		@AttachmentUploadPath,
		@ProjectManagerUserId ,
		GetDate(),
		@ProjectCreatorUserId,
		@ProjectAccessType,
		@AllowAttachments,
		@AttachmentStorageType,
		@SvnRepositoryUrl
	)
 	RETURN scope_identity()
END
ELSE
  RETURN 0


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFields]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectCustomFields](
	[CustomFieldId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[CustomFieldName] [nvarchar](50) NOT NULL,
	[CustomFieldRequired] [bit] NOT NULL,
	[CustomFieldDataType] [int] NOT NULL,
	[CustomFieldTypeId] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCustomFields] PRIMARY KEY CLUSTERED 
(
	[CustomFieldId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectCategories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[ParentCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCategories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_UpdateProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_Project_UpdateProject]
 @ProjectId 				int,
 @ProjectName				nvarchar(50),
 @ProjectCode				nvarchar(50),
 @ProjectDescription 		nvarchar(1000),
 @ProjectManagerUserName	nvarchar(255),
 @AttachmentUploadPath 		nvarchar(80),
 @ProjectAccessType			int,
 @ProjectDisabled			int,
 @AllowAttachments			bit,
 @AttachmentStorageType		int,
 @SvnRepositoryUrl	nvarchar(255)
AS
DECLARE @ProjectManagerUserId UNIQUEIDENTIFIER
SELECT @ProjectManagerUserId = UserId FROM aspnet_users WHERE Username = @ProjectManagerUserName

UPDATE BugNet_Projects SET
	ProjectName = @ProjectName,
	ProjectCode = @ProjectCode,
	ProjectDescription = @ProjectDescription,
	ProjectManagerUserId = @ProjectManagerUserId,
	AttachmentUploadPath = @AttachmentUploadPath,
	ProjectAccessType = @ProjectAccessType,
	ProjectDisabled = @ProjectDisabled,
	AllowAttachments = @AllowAttachments,
	AttachmentStorageType = @AttachmentStorageType,
	SvnRepositoryUrl = @SvnRepositoryUrl
WHERE
	ProjectId = @ProjectId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_UserProjects]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_UserProjects](
	[UserId] [uniqueidentifier] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[UserProjectId] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_BugNet_UserProjects] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[ProjectId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[RoleDescription] [nvarchar](256) NOT NULL,
	[AutoAssign] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_Queries](
	[QueryId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[QueryName] [nvarchar](255) NOT NULL,
	[IsPublic] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_Queries] PRIMARY KEY CLUSTERED 
(
	[QueryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectsView]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[BugNet_ProjectsView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_Projects.ProjectId, dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, 
                      dbo.BugNet_Projects.ProjectDescription, dbo.BugNet_Projects.AttachmentUploadPath, dbo.BugNet_Projects.ProjectManagerUserId, 
                      dbo.BugNet_Projects.ProjectCreatorUserId, dbo.BugNet_Projects.DateCreated, dbo.BugNet_Projects.ProjectDisabled, 
                      dbo.BugNet_Projects.ProjectAccessType, Managers.UserName AS ManagerUserName, ISNULL(ManagerUsersProfile.DisplayName, N''none'') 
                      AS ManagerDisplayName, Creators.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, N''none'') AS CreatorDisplayName, 
                      dbo.BugNet_Projects.AllowAttachments, dbo.BugNet_Projects.AttachmentStorageType, dbo.BugNet_Projects.SvnRepositoryUrl
FROM         dbo.BugNet_Projects INNER JOIN
                      dbo.aspnet_Users AS Managers ON Managers.UserId = dbo.BugNet_Projects.ProjectManagerUserId INNER JOIN
                      dbo.aspnet_Users AS Creators ON Creators.UserId = dbo.BugNet_Projects.ProjectCreatorUserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS CreatorUsersProfile ON Creators.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS ManagerUsersProfile ON Managers.UserName = ManagerUsersProfile.UserName
ORDER BY dbo.BugNet_Projects.ProjectName
'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectPriorities](
	[PriorityId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[PriorityName] [nvarchar](50) NOT NULL,
	[PriorityImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectPriorities] PRIMARY KEY CLUSTERED 
(
	[PriorityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotifications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectNotifications](
	[ProjectNotificationid] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectNotifications] PRIMARY KEY CLUSTERED 
(
	[ProjectNotificationid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectResolutions](
	[ResolutionId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[ResolutionName] [nvarchar](50) NOT NULL,
	[ResolutionImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectResolutions] PRIMARY KEY CLUSTERED 
(
	[ResolutionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectStatus](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
	[StatusImageUrl] [nvarchar](50) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsClosedState] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectStatus] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_UpdateResolution]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_UpdateResolution]
	@ProjectId int,
	@ResolutionId int,
	@ResolutionName NVARCHAR(50),
	@ResolutionImageUrl NVARCHAR(50),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldResolutionId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectResolutions WHERE ResolutionId = @ResolutionId
SELECT @OldResolutionId = ResolutionId FROM BugNet_ProjectResolutions WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectResolutions SET
	ProjectId = @ProjectId,
	ResolutionName = @ResolutionName,
	ResolutionImageUrl = @ResolutionImageUrl,
	SortOrder = @SortOrder
WHERE ResolutionId = @ResolutionId

UPDATE BugNet_ProjectResolutions SET
	SortOrder = @OldSortOrder
WHERE ResolutionId = @OldResolutionId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_GetResolutionsByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionsByProjectId]
		@ProjectId Int
AS
SELECT ResolutionId, ProjectId, ResolutionName,SortOrder, ResolutionImageUrl 
FROM BugNet_ProjectResolutions
WHERE ProjectId = @ProjectId
ORDER BY SortOrder 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_GetResolutionById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionById]
	@ResolutionId int
AS
SELECT
	ResolutionId,
	ProjectId,
	ResolutionName,
	SortOrder,
	ResolutionImageUrl
FROM 
	BugNet_ProjectResolutions
WHERE
	ResolutionId = @ResolutionId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_DeleteResolution]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_DeleteResolution]
 	@ResolutionIdToDelete INT
AS
DELETE
	BugNet_ProjectResolutions
WHERE
	ResolutionId = @ResolutionIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions_CreateNewResolution]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_CreateNewResolution]
 	@ProjectId INT,
	@ResolutionName NVARCHAR(50),
	@ResolutionImageUrl NVARCHAR(50)
AS
IF NOT EXISTS(SELECT ResolutionId  FROM BugNet_ProjectResolutions WHERE LOWER(ResolutionName)= LOWER(@ResolutionName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectResolutions WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectResolutions
	(
		ProjectId, 
		ResolutionName ,
		ResolutionImageUrl,
		SortOrder
	) VALUES (
		@ProjectId, 
		@ResolutionName,
		@ResolutionImageUrl,
		@SortOrder
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_UpdatePriority]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_UpdatePriority]
	@ProjectId int,
	@PriorityId int,
	@PriorityName NVARCHAR(50),
	@PriorityImageUrl NVARCHAR(50),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldPriorityId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectPriorities WHERE PriorityId = @PriorityId
SELECT @OldPriorityId = PriorityId FROM BugNet_ProjectPriorities WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectPriorities SET
	ProjectId = @ProjectId,
	PriorityName = @PriorityName,
	PriorityImageUrl = @PriorityImageUrl,
	SortOrder = @SortOrder
WHERE PriorityId = @PriorityId

UPDATE BugNet_ProjectPriorities SET
	SortOrder = @OldSortOrder
WHERE PriorityId = @OldPriorityId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_GetPriorityById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPriorityById]
	@PriorityId int
AS
SELECT
	PriorityId,
	ProjectId,
	PriorityName,
	SortOrder,
	PriorityImageUrl
FROM 
	BugNet_ProjectPriorities
WHERE
	PriorityId = @PriorityId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_GetPrioritiesByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPrioritiesByProjectId]
	@ProjectId int
AS
SELECT
	PriorityId,
	ProjectId,
	PriorityName,
	SortOrder,
	PriorityImageUrl
FROM 
	BugNet_ProjectPriorities
WHERE
	ProjectId = @ProjectId
ORDER BY SortOrder' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_DeletePriority]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_DeletePriority]
 @PriorityIdToDelete	INT
AS
DELETE 
	BugNet_ProjectPriorities
WHERE
	PriorityId = @PriorityIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetOpenIssues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetOpenIssues]
@ProjectId Int
AS
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
ORDER BY
	IssueId Desc'


END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities_CreateNewPriority]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_CreateNewPriority]
 @ProjectId	    INT,
 @PriorityName        NVARCHAR(50),
 @PriorityImageUrl NVarChar(50)
AS
IF NOT EXISTS(SELECT PriorityId  FROM BugNet_ProjectPriorities WHERE LOWER(PriorityName)= LOWER(@PriorityName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectPriorities WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectPriorities 
   	( 
		ProjectId, 
		PriorityName,
		PriorityImageUrl ,
		SortOrder
   	) VALUES (
		@ProjectId, 
		@PriorityName,
		@PriorityImageUrl,
		@SortOrder
  	)
   	RETURN scope_identity()
END
RETURN 0' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername] 
	@Username nvarchar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @UserName

SELECT 
	ProjectNotificationId,
	P.ProjectId,
	ProjectName,
	U.UserId NotificationUserId,
	U.UserName NotificationUsername,
	IsNull(DisplayName,'''') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_ProjectNotifications
	INNER JOIN aspnet_Users U ON BugNet_ProjectNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_ProjectNotifications.UserId = M.UserId
	INNER JOIN BugNet_Projects P ON BugNet_ProjectNotifications.ProjectId = P.ProjectId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	U.UserId = @UserId
ORDER BY
	DisplayName

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId] 
	@ProjectId Int
AS

SELECT 
	ProjectNotificationId,
	P.ProjectId,
	ProjectName,
	U.UserId NotificationUserId,
	U.UserName NotificationUsername,
	IsNull(DisplayName,'''') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_ProjectNotifications
	INNER JOIN aspnet_Users U ON BugNet_ProjectNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_ProjectNotifications.UserId = M.UserId
	INNER JOIN BugNet_Projects P ON BugNet_ProjectNotifications.ProjectId = P.ProjectId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	P.ProjectId = @ProjectId
ORDER BY
	DisplayName

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotification_DeleteProjectNotification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_DeleteProjectNotification]
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE UserName = @Username
DELETE 
	BugNet_ProjectNotifications
WHERE
	ProjectId = @ProjectId
	AND UserId = @UserId 


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]
	@ProjectId Int,
	@NotificationUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @NotificationUserName

IF NOT EXISTS( SELECT ProjectNotificationId FROM BugNet_ProjectNotifications WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT BugNet_ProjectNotifications
	(
		ProjectId,
		UserId
	)
	VALUES
	(
		@ProjectId,
		@UserId
	)
	RETURN scope_identity()
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_UpdateMilestone]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_UpdateMilestone]
	@ProjectId int,
	@MilestoneId int,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@SortOrder int,
	@MilestoneDueDate DATETIME
AS

DECLARE @OldSortOrder int
DECLARE @OldMilestoneId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectMilestones WHERE MilestoneId = @MilestoneId
SELECT @OldMilestoneId = MilestoneId FROM BugNet_ProjectMilestones WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectMilestones SET
	ProjectId = @ProjectId,
	MilestoneName = @MilestoneName,
	MilestoneImageUrl = @MilestoneImageUrl,
	SortOrder = @SortOrder,
	MilestoneDueDate = @MilestoneDueDate
WHERE MilestoneId = @MilestoneId

UPDATE BugNet_ProjectMilestones SET
	SortOrder = @OldSortOrder
WHERE MilestoneId = @OldMilestoneId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]
	@ProjectId INT
AS
SELECT * FROM BugNet_ProjectMilestones WHERE ProjectId=@ProjectId ORDER BY SortOrder ASC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_GetMilestoneById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestoneById]
 @MilestoneId INT
AS
SELECT
	MilestoneId,
	ProjectId,
	MilestoneName,
	MilestoneImageUrl,
	SortOrder,
	MilestoneDueDate
FROM 
	BugNet_ProjectMilestones
WHERE
	MilestoneId = @MilestoneId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_DeleteMilestone]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_DeleteMilestone]
	@MilestoneIdToDelete INT
AS
DELETE 
	BugNet_ProjectMilestones
WHERE
	MilestoneId = @MilestoneIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones_CreateNewMilestone]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_CreateNewMilestone]
 	@ProjectId INT,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@MilestoneDueDate DATETIME
AS
IF NOT EXISTS(SELECT MilestoneId  FROM BugNet_ProjectMilestones WHERE LOWER(MilestoneName)= LOWER(@MilestoneName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectMilestones 
	(
		ProjectId, 
		MilestoneName ,
		MilestoneImageUrl,
		SortOrder,
		MilestoneDueDate 
	) VALUES (
		@ProjectId, 
		@MilestoneName,
		@MilestoneImageUrl,
		@SortOrder,
		@MilestoneDueDate
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_UpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_UpdateStatus]
	@ProjectId int,
	@StatusId int,
	@StatusName NVARCHAR(50),
	@StatusImageUrl NVARCHAR(50),
	@SortOrder int,
	@IsClosedState bit
AS

DECLARE @OldSortOrder int
DECLARE @OldStatusId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectStatus WHERE StatusId = @StatusId
SELECT @OldStatusId = StatusId FROM BugNet_ProjectStatus WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectStatus SET
	ProjectId = @ProjectId,
	StatusName = @StatusName,
	StatusImageUrl = @StatusImageUrl,
	SortOrder = @SortOrder,
	IsClosedState = @IsClosedState
WHERE StatusId = @StatusId

UPDATE BugNet_ProjectStatus SET
	SortOrder = @OldSortOrder
WHERE StatusId = @OldStatusId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_GetStatusByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusByProjectId]
		@ProjectId Int
AS
SELECT StatusId, ProjectId, StatusName,SortOrder, StatusImageUrl, IsClosedState
FROM BugNet_ProjectStatus
WHERE ProjectId = @ProjectId
ORDER BY SortOrder 


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_GetStatusById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusById]
	@StatusId int
AS
SELECT
	StatusId,
	ProjectId,
	StatusName,
	SortOrder,
	StatusImageUrl,
	IsClosedState
FROM 
	BugNet_ProjectStatus
WHERE
	StatusId = @StatusId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_DeleteStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_DeleteStatus]
 	@StatusIdToDelete INT
AS
DELETE
	BugNet_ProjectStatus
WHERE
	StatusId = @StatusIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus_CreateNewStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_CreateNewStatus]
 	@ProjectId INT,
	@StatusName NVARCHAR(50),
	@StatusImageUrl NVARCHAR(50),
	@IsClosedState bit
AS
IF NOT EXISTS(SELECT StatusId  FROM BugNet_ProjectStatus WHERE LOWER(StatusName)= LOWER(@StatusName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectStatus
	(
		ProjectId, 
		StatusName ,
		StatusImageUrl,
		SortOrder,
		IsClosedState
	) VALUES (
		@ProjectId, 
		@StatusName,
		@StatusImageUrl,
		@SortOrder,
		@IsClosedState
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelections]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectCustomFieldSelections](
	[CustomFieldSelectionId] [int] IDENTITY(1,1) NOT NULL,
	[CustomFieldId] [int] NOT NULL,
	[CustomFieldSelectionValue] [nchar](255) NOT NULL,
	[CustomFieldSelectionName] [nchar](255) NOT NULL,
	[CustomFieldSelectionSortOrder] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCustomFieldSelections] PRIMARY KEY CLUSTERED 
(
	[CustomFieldSelectionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_GetQueriesByUserName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Query_GetQueriesByUserName] 
	@UserName NVarChar(255),
	@ProjectId Int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT
	QueryId,
	QueryName + '' ('' + BugNet_UserProfiles.DisplayName + '')'' AS QueryName
FROM
	BugNet_Queries INNER JOIN
	aspnet_Users M ON BugNet_Queries.UserId = M.UserId JOIN
	BugNet_UserProfiles ON M.UserName = BugNet_UserProfiles.UserName
WHERE
	IsPublic = 1 AND ProjectId = @ProjectId
UNION
SELECT
	QueryId,
	QueryName
FROM
	BugNet_Queries
WHERE
	UserId = @UserId
	AND ProjectID = @ProjectId
	AND IsPublic = 0
ORDER BY
	QueryName ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_SaveQuery]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Query_SaveQuery] 
	@UserName NVarChar(255),
	@ProjectId Int,
	@QueryName NVarChar(50),
	@IsPublic bit 
AS
-- Get UserID
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @UserName

IF EXISTS(SELECT QueryName FROM BugNet_Queries WHERE QueryName = @QueryName AND UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	RETURN 0
END

INSERT BugNet_Queries
(
	UserId,
	ProjectId,
	QueryName,
	IsPublic
)
VALUES
(
	@UserId,
	@ProjectId,
	@QueryName,
	@IsPublic
)
RETURN scope_identity()' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_QueryClauses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_QueryClauses](
	[QueryClauseId] [int] IDENTITY(1,1) NOT NULL,
	[QueryId] [int] NOT NULL,
	[BooleanOperator] [nvarchar](50) NOT NULL,
	[FieldName] [nvarchar](50) NOT NULL,
	[ComparisonOperator] [nvarchar](50) NOT NULL,
	[FieldValue] [nvarchar](50) NOT NULL,
	[DataType] [int] NOT NULL,
	[IsCustomField] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_QueryClauses] PRIMARY KEY CLUSTERED 
(
	[QueryClauseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetAllRoles]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_GetAllRoles]
AS
SELECT RoleId, RoleName,RoleDescription,ProjectId,AutoAssign FROM BugNet_Roles

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_DeleteRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_DeleteRole]
	@RoleId Int 
AS
DELETE 
	BugNet_Roles
WHERE
	RoleId = @RoleId
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_CreateNewRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_CreateNewRole]
  @ProjectId 	int,
  @RoleName 		nvarchar(256),
  @RoleDescription 	nvarchar(256),
  @AutoAssign	bit
AS
	INSERT BugNet_Roles
	(
		ProjectId,
		RoleName,
		RoleDescription,
		AutoAssign
	)
	VALUES
	(
		@ProjectId,
		@RoleName,
		@RoleDescription,
		@AutoAssign
	)
RETURN scope_identity()' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_RoleExists]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_RoleExists]
    @RoleName   nvarchar(256),
    @ProjectId	int
AS
BEGIN
    IF (EXISTS (SELECT RoleName FROM BugNet_Roles WHERE @RoleName = RoleName AND ProjectId = @ProjectId))
        RETURN(1)
    ELSE
        RETURN(0)
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RolePermissions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_RolePermissions](
	[PermissionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_RolePermissions] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_UpdateRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_UpdateRole]
	@RoleId 			int,
	@RoleName			nvarchar(256),
	@RoleDescription 	nvarchar(256),
	@AutoAssign			bit,
	@ProjectId			int
AS
UPDATE BugNet_Roles SET
	RoleName = @RoleName,
	RoleDescription = @RoleDescription,
	AutoAssign = @AutoAssign,
	ProjectId = @ProjectId	
WHERE
	RoleId = @RoleId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_UserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_UserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_BugNet_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_User_GetUsersByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
	@ProjectId Int
AS
SELECT U.UserId, U.UserName, FirstName, LastName, DisplayName FROM 
	aspnet_Users U
JOIN BugNet_UserProjects
	ON U.UserId = BugNet_UserProjects.UserId
JOIN BugNet_UserProfiles
	ON U.UserName = BugNet_UserProfiles.UserName
JOIN  aspnet_Membership M 
	ON U.UserId = M.UserId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId 
	AND M.IsApproved = 1
ORDER BY U.UserName ASC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetAllProjects]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_GetAllProjects]
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectDisabled = 0


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetRolesByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_GetRolesByProject]
	@ProjectId int
AS
SELECT RoleId,ProjectId, RoleName, RoleDescription, AutoAssign
FROM BugNet_Roles
WHERE ProjectId = @ProjectId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetRoleById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_GetRoleById]
	@RoleId int
AS
SELECT RoleId, ProjectId, RoleName, RoleDescription, AutoAssign 
FROM BugNet_Roles
WHERE RoleId = @RoleId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_Issues](
	[IssueId] [int] IDENTITY(1,1) NOT NULL,
	[IssueTitle] [nvarchar](500) NOT NULL,
	[IssueDescription] [nvarchar](max) NOT NULL,
	[IssueStatusId] [int] NOT NULL,
	[IssuePriorityId] [int] NOT NULL,
	[IssueTypeId] [int] NOT NULL,
	[IssueCategoryId] [int] NULL,
	[ProjectId] [int] NOT NULL,
	[IssueAffectedMilestoneId] [int] NULL,
	[IssueResolutionId] [int] NULL,
	[IssueCreatorUserId] [uniqueidentifier] NOT NULL,
	[IssueAssignedUserId] [uniqueidentifier] NULL,
	[IssueOwnerUserId] [uniqueidentifier] NULL,
	[IssueDueDate] [datetime] NULL,
	[IssueMilestoneId] [int] NULL,
	[IssueVisibility] [int] NOT NULL,
	[IssueEstimation] [decimal](5, 2) NOT NULL,
	[IssueProgress] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateUserId] [uniqueidentifier] NOT NULL,
	[Disabled] [bit] NOT NULL,
 CONSTRAINT [PK_BugNet_Issues] PRIMARY KEY CLUSTERED 
(
	[IssueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_RemoveUserFromProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_RemoveUserFromProject]
	@UserName nvarchar(255),
	@ProjectId Int 
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

DELETE 
	BugNet_UserProjects
WHERE
	UserId = @UserId AND ProjectId = @ProjectId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_IsUserProjectMember]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_IsUserProjectMember]
	@Username	nvarchar(255),
 	@ProjectId	int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @Username

IF EXISTS( SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
  RETURN 0
ELSE
  RETURN -1' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_AddUserToProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_AddUserToProject]
@UserName nvarchar(255),
@ProjectId int
AS
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

IF NOT EXISTS (SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId)
BEGIN
	INSERT  BugNet_UserProjects
	(
		UserId,
		ProjectId,
		DateCreated
	)
	VALUES
	(
		@UserId,
		@ProjectId,
		getdate()
	)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetPublicProjects]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_GetPublicProjects]
AS
SELECT * FROM 
	BugNet_ProjectsView
WHERE 
	ProjectAccessType = 1 AND ProjectDisabled = 0
ORDER BY ProjectName ASC

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectsByMemberUsername]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUsername]
	@Username nvarchar(255),
	@ActiveOnly bit
AS
DECLARE @Disabled bit
SET @Disabled = 1
DECLARE @UserId UNIQUEIDENTIFIER
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @Username
IF @ActiveOnly = 1
BEGIN
	SET @Disabled = 0
END
/*
SELECT DISTINCT
	P.ProjectId,
	ProjectName,
	ProjectCode,
	ProjectDescription,
	AttachmentUploadPath,
	ProjectManagerUserId,
	ProjectCreatorUserId,
	P.DateCreated,
	P.ProjectDisabled,
	ProjectAccessType,
	Managers.UserName ManagerUserName,
	ISNULL(ManagerUsersProfile.DisplayName, N''none'') AS ManagerDisplayName,
	Creators.UserName CreatorUserName,
	ISNULL(CreatorUsersProfile.DisplayName, N''none'') AS CreatorDisplayName,
	AllowAttachments,
	AllowAttachments,
	AttachmentStorageType,
	SvnRepositoryUrl
FROM 
	BugNet_Projects P
	INNER JOIN aspnet_users AS Managers ON Managers.UserId = P.ProjectManagerUserId	
	INNER JOIN aspnet_users AS Creators ON Creators.UserId = P.ProjectCreatorUserId
	Left JOIN BugNet_UserProjects UP ON UP.ProjectId = P.ProjectId
	LEFT OUTER JOIN dbo.BugNet_UserProfiles AS CreatorUsersProfile ON Creators.UserName = CreatorUsersProfile.UserName 
	LEFT OUTER JOIN dbo.BugNet_UserProfiles AS ManagerUsersProfile ON Managers.UserName = ManagerUsersProfile.UserName 
WHERE
	 (P.ProjectAccessType = 1 AND P.ProjectDisabled = @Disabled) OR
     (P.ProjectAccessType = 2 AND P.ProjectDisabled = @Disabled AND UP.UserId = @UserId)
              
ORDER BY ProjectName ASC
*/
SELECT DISTINCT 
	[BugNet_ProjectsView].ProjectId,
	ProjectName,
	ProjectCode,
	ProjectDescription,
	AttachmentUploadPath,
	ProjectManagerUserId,
	ProjectCreatorUserId,
	[BugNet_ProjectsView].DateCreated,
	ProjectDisabled,
	ProjectAccessType,
	ManagerUserName,
	ManagerDisplayName,
	CreatorUserName,
	CreatorDisplayName,
	AllowAttachments,
	AllowAttachments,
	AttachmentStorageType,
	SvnRepositoryUrl
 FROM [BugNet_ProjectsView]
	Left JOIN BugNet_UserProjects UP ON UP.ProjectId = [BugNet_ProjectsView].ProjectId 
WHERE
	 (ProjectAccessType = 1 AND ProjectDisabled = @Disabled) OR
     (ProjectAccessType = 2 AND ProjectDisabled = @Disabled AND UP.UserId = @UserId)


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectMembers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectMembers]
	@ProjectId Int
AS
SELECT Username
FROM 
	aspnet_users
LEFT OUTER JOIN
	BugNet_UserProjects
ON
	aspnet_users.UserId = BugNet_UserProjects.UserId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId
ORDER BY Username ASC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectById]
 @ProjectId INT
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectId = @ProjectId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_GetCustomFieldById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldById] 
	@CustomFieldId Int
AS

SELECT
	Fields.ProjectId,
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	'''' CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields Fields
WHERE
	Fields.CustomFieldId = @CustomFieldId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_GetCustomFieldsByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByProjectId] 
	@ProjectId Int
AS
SELECT
	ProjectId,
	CustomFieldId,
	CustomFieldName,
	CustomFieldDataType,
	CustomFieldRequired,
	'''' CustomFieldValue,
	CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields
WHERE
	ProjectId = @ProjectId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_UpdateCustomField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_UpdateCustomField]
	@CustomFieldId Int,
	@ProjectId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId	int
AS
UPDATE 
	BugNet_ProjectCustomFields 
SET
	ProjectId = @ProjectId,
	CustomFieldName = @CustomFieldName,
	CustomFieldDataType = @CustomFieldDataType,
	CustomFieldRequired = @CustomFieldRequired,
	CustomFieldTypeId = @CustomFieldTypeId
WHERE 
	CustomFieldId = @CustomFieldId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_CreateNewCustomField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_CreateNewCustomField]
	@ProjectId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId	int
AS
IF NOT EXISTS(SELECT CustomFieldId FROM BugNet_ProjectCustomFields WHERE ProjectId = @ProjectId AND LOWER(CustomFieldName) = LOWER(@CustomFieldName) )
BEGIN
	INSERT BugNet_ProjectCustomFields
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

	RETURN scope_identity()
END
RETURN 0' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_UpdateCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_UpdateCategory]
	@CategoryId int,
	@ProjectId int,
	@CategoryName nvarchar(100),
	@ParentCategoryId int
AS


UPDATE BugNet_ProjectCategories SET
	ProjectId = @ProjectId,
	CategoryName = @CategoryName,
	ParentCategoryId = @ParentCategoryId
WHERE CategoryId = @CategoryId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId=c.CategoryId) ChildCount
FROM BugNet_ProjectCategories c
WHERE 
ProjectId = @ProjectId AND c.ParentCategoryId = 0
ORDER BY CategoryName
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]
	@CategoryId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId = c.CategoryId) ChildCount
FROM BugNet_ProjectCategories c
WHERE 
c.ParentCategoryId = @CategoryId
ORDER BY CategoryName

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_GetCategoryById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoryById]
	@CategoryId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId=c.CategoryId) ChildCount
FROM BugNet_ProjectCategories c
WHERE 
CategoryId = @CategoryId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]
	@ProjectId int
AS
SELECT
	CategoryId,
	ProjectId,
	CategoryName,
	ParentCategoryId,
	(SELECT COUNT(*) FROM BugNet_ProjectCategories WHERE ParentCategoryId=c.CategoryId) ChildCount
FROM BugNet_ProjectCategories c
WHERE 
ProjectId = @ProjectId
ORDER BY CategoryName

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_DeleteCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_DeleteCategory]
	@CategoryId Int 
AS
DELETE 
	BugNet_ProjectCategories
WHERE
	CategoryId = @CategoryId
IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories_CreateNewCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_CreateNewCategory]
  @ProjectId int,
  @CategoryName nvarchar(100),
  @ParentCategoryId int
AS
	INSERT BugNet_ProjectCategories
	(
		ProjectId,
		CategoryName,
		ParentCategoryId
	)
	VALUES
	(
		@ProjectId,
		@CategoryName,
		@ParentCategoryId
	)
RETURN scope_identity()
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_UpdateIssueType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_UpdateIssueType]
	@ProjectId int,
	@IssueTypeId int,
	@IssueTypeName NVARCHAR(50),
	@IssueTypeImageUrl NVARCHAR(255),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldIssueTypeId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectIssueTypes WHERE IssueTypeId = @IssueTypeId
SELECT @OldIssueTypeId = IssueTypeId FROM BugNet_ProjectIssueTypes WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectIssueTypes SET
	ProjectId = @ProjectId,
	IssueTypeName = @IssueTypeName,
	IssueTypeImageUrl = @IssueTypeImageUrl,
	SortOrder = @SortOrder
WHERE IssueTypeId = @IssueTypeId

UPDATE BugNet_ProjectIssueTypes SET
	SortOrder = @OldSortOrder
WHERE IssueTypeId = @OldIssueTypeId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_GetIssueTypesByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypesByProjectId]
	@ProjectId int
AS
SELECT
	IssueTypeId,
	ProjectId,
	IssueTypeName,
	SortOrder,
	IssueTypeImageUrl
FROM 
	BugNet_ProjectIssueTypes
WHERE
	ProjectId = @ProjectId
ORDER BY SortOrder' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_GetIssueTypeById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypeById]
 @IssueTypeId INT
AS
SELECT
	IssueTypeId,
	ProjectId,
	IssueTypeName,
	IssueTypeImageUrl,
	SortOrder
FROM 
	BugNet_ProjectIssueTypes
WHERE
	IssueTypeId = @IssueTypeId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_DeleteIssueType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_DeleteIssueType]
	@IssueTypeIdToDelete INT
AS
DELETE 
	BugNet_ProjectIssueTypes
WHERE
	IssueTypeId = @IssueTypeIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes_CreateNewIssueType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CreateNewIssueType]
 @ProjectId	    INT,
 @IssueTypeName NVARCHAR(50),
 @IssueTypeImageUrl NVarChar(50)
AS
IF NOT EXISTS(SELECT IssueTypeId  FROM BugNet_ProjectIssueTypes WHERE LOWER(IssueTypeName)= LOWER(@IssueTypeName) AND ProjectId = @ProjectId)
BEGIN
	DECLARE @SortOrder int
	SELECT @SortOrder = ISNULL(MAX(SortOrder + 1),1) FROM BugNet_ProjectIssueTypes WHERE ProjectId = @ProjectId
	INSERT BugNet_ProjectIssueTypes 
   	( 
		ProjectId, 
		IssueTypeName,
		IssueTypeImageUrl ,
		SortOrder
   	) VALUES (
		@ProjectId, 
		@IssueTypeName,
		@IssueTypeImageUrl,
		@SortOrder
  	)
   	RETURN scope_identity()
END
RETURN -1' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_ProjectCustomFieldValues](
	[CustomFieldValueId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[CustomFieldId] [int] NOT NULL,
	[CustomFieldValue] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_BugNet_ProjectCustomFieldValues] PRIMARY KEY CLUSTERED 
(
	[CustomFieldValueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_CloneProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_Project_CloneProject] 
(
  @ProjectId INT,
  @ProjectName NVarChar(256)
)
AS
-- Copy Project
INSERT BugNet_Projects
(
  ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  DateCreated,
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  ProjectCreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl 
)
SELECT
  @ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  GetDate(),
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  ProjectCreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl
FROM 
  BugNet_Projects
WHERE
  ProjectId = @ProjectId
  
DECLARE @NewProjectId INT
SET @NewProjectId = SCOPE_IDENTITY()

-- Copy Milestones
INSERT BugNet_ProjectMilestones
(
  ProjectId,
  MilestoneName,
  MilestoneImageUrl,
  SortOrder,
  DateCreated
)
SELECT
  @NewProjectId,
  MilestoneName,
  MilestoneImageUrl,
  SortOrder,
  GetDate()
FROM
  BugNet_ProjectMilestones
WHERE
  ProjectId = @ProjectId  

-- Copy Project Members
INSERT BugNet_UserProjects
(
  UserId,
  ProjectId,
  DateCreated
)
SELECT
  UserId,
  @NewProjectId,
  GetDate()
FROM
  BugNet_UserProjects
WHERE
  ProjectId = @ProjectId

-- Copy Project Roles
INSERT BugNet_Roles
( 
	ProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
)
SELECT 
	@NewProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
FROM
	BugNet_Roles
WHERE
	ProjectId = @ProjectId

CREATE TABLE #OldRoles
(
  OldRowNumber INT IDENTITY,
  OldRoleId INT,
)

INSERT #OldRoles
(
  OldRoleId
)
SELECT
	RoleId
FROM
	BugNet_Roles
WHERE
	ProjectId = @ProjectId
ORDER BY 
	RoleId

CREATE TABLE #NewRoles
(
  NewRowNumber INT IDENTITY,
  NewRoleId INT,
)

INSERT #NewRoles
(
  NewRoleId
)
SELECT
	RoleId
FROM
	BugNet_Roles
WHERE
	ProjectId = @NewProjectId
ORDER BY 
	RoleId

INSERT BugNet_UserRoles
(
	UserId,
	RoleId
)
SELECT 
	UserId,
	RoleId = NewRoleId
FROM 
	#OldRoles 
INNER JOIN #NewRoles ON  OldRowNumber = NewRowNumber
INNER JOIN BugNet_UserRoles UR ON UR.RoleId = OldRoleId

-- Copy Role Permissions
INSERT BugNet_RolePermissions
(
   PermissionId,
   RoleId
)
SELECT Perm.PermissionId, NewRoles.RoleId
FROM BugNet_RolePermissions Perm
INNER JOIN BugNet_Roles OldRoles ON Perm.RoleId = OldRoles.RoleID
INNER JOIN BugNet_Roles NewRoles ON NewRoles.RoleName = OldRoles.RoleName
WHERE OldRoles.ProjectId = @ProjectId 
      and NewRoles.ProjectId = @NewProjectId


-- Copy Custom Fields
INSERT BugNet_ProjectCustomFields
(
  ProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
)
SELECT
  @NewProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @ProjectId
  
-- Copy Custom Field Selections
CREATE TABLE #OldCustomFields
(
  OldRowNumber INT IDENTITY,
  OldCustomFieldId INT,
)
INSERT #OldCustomFields
(
  OldCustomFieldId
)
SELECT
	CustomFieldId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @ProjectId
ORDER BY CustomFieldId

CREATE TABLE #NewCustomFields
(
  NewRowNumber INT IDENTITY,
  NewCustomFieldId INT,
)

INSERT #NewCustomFields
(
  NewCustomFieldId
)
SELECT
  CustomFieldId
FROM
  BugNet_ProjectCustomFields
WHERE
  ProjectId = @NewProjectId
ORDER BY CustomFieldId

INSERT BugNet_ProjectCustomFieldSelections
(
	CustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
)
SELECT 
	CustomFieldId = NewCustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
FROM 
	#OldCustomFields 
INNER JOIN #NewCustomFields ON  OldRowNumber = NewRowNumber
INNER JOIN BugNet_ProjectCustomFieldSelections CFS ON CFS.CustomFieldId = OldCustomFieldId

-- Copy Project Mailboxes
/*INSERT BugNet_ProjectMailbox
(
  MailBox,
  ProjectId,
  AssignToUserId,
  IssueTypeId
)
SELECT
  Mailbox,
  @NewProjectId,
  AssignToUserId,
  IssueTypeId
FROM
  ProjectMailBox
WHERE
  ProjectId = @ProjectId
*/
-- Copy Categories
INSERT BugNet_ProjectCategories
(
  ProjectId,
  CategoryName,
  ParentCategoryId
)
SELECT
  @NewProjectId,
  CategoryName,
  ParentCategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @ProjectId  


CREATE TABLE #OldCategories
(
  OldRowNumber INT IDENTITY,
  OldCategoryId INT,
)

INSERT #OldCategories
(
  OldCategoryId
)
SELECT
  CategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @ProjectId
ORDER BY CategoryId

CREATE TABLE #NewCategories
(
  NewRowNumber INT IDENTITY,
  NewCategoryId INT,
)

INSERT #NewCategories
(
  NewCategoryId
)
SELECT
  CategoryId
FROM
  BugNet_ProjectCategories
WHERE
  ProjectId = @NewProjectId
ORDER BY CategoryId

UPDATE BugNet_ProjectCategories SET
  ParentCategoryId = NewCategoryId
FROM
  #OldCategories INNER JOIN #NewCategories ON OldRowNumber = NewRowNumber
WHERE
  ProjectId = @NewProjectId
  And ParentCategoryID = OldCategoryId 

-- Copy Status''s
INSERT BugNet_ProjectStatus
(
  ProjectId,
  StatusName,
  StatusImageUrl,
  SortOrder,
  IsClosedState
)
SELECT
  @NewProjectId,
  StatusName,
  StatusImageUrl,
  SortOrder,
  IsClosedState
FROM
  BugNet_ProjectStatus
WHERE
  ProjectId = @ProjectId 
 
-- Copy Priorities
INSERT BugNet_ProjectPriorities
(
  ProjectId,
  PriorityName,
  PriorityImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  PriorityName,
  PriorityImageUrl,
  SortOrder
FROM
  BugNet_ProjectPriorities
WHERE
  ProjectId = @ProjectId 

-- Copy Resolutions
INSERT BugNet_ProjectResolutions
(
  ProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
FROM
  BugNet_ProjectResolutions
WHERE
  ProjectId = @ProjectId
 
-- Copy Issue Types
INSERT BugNet_ProjectIssueTypes
(
  ProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
)
SELECT
  @NewProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
FROM
  BugNet_ProjectIssueTypes
WHERE
  ProjectId = @ProjectId

-- Copy Project Notifications
INSERT BugNet_ProjectNotifications
(
  ProjectId,
  UserId
)
SELECT
  @NewProjectId,
  UserId
FROM
  BugNet_ProjectNotifications
WHERE
  ProjectId = @ProjectId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetMemberRolesByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_Project_GetMemberRolesByProjectId]
	@ProjectId Int
AS

SELECT ISNULL(UsersProfile.DisplayName, aspnet_Users.UserName) as DisplayName, BugNet_Roles.RoleName
FROM
	aspnet_Users INNER JOIN
	BugNet_UserProjects ON aspnet_Users.UserId = BugNet_UserProjects.UserId INNER JOIN
	BugNet_UserRoles ON aspnet_Users.UserId = BugNet_UserRoles.UserId INNER JOIN
	BugNet_Roles ON BugNet_UserRoles.RoleId = BugNet_Roles.RoleId LEFT OUTER JOIN
	BugNet_UserProfiles AS UsersProfile ON aspnet_Users.UserName = UsersProfile.UserName

WHERE
	BugNet_UserProjects.ProjectId = @ProjectId
ORDER BY DisplayName, RoleName ASC

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_GetRolePermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE  [dbo].[BugNet_Permission_GetRolePermission]  AS

SELECT R.RoleId, R.ProjectId,P.PermissionId,P.PermissionKey,R.RoleName, P.PermissionName
FROM BugNet_RolePermissions RP
JOIN
BugNet_Permissions P ON RP.PermissionId = P.PermissionId
JOIN
BugNet_Roles R ON RP.RoleId = R.RoleId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_GetPermissionsByRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Permission_GetPermissionsByRole]
	@RoleId int
 AS
SELECT BugNet_Permissions.PermissionId, PermissionKey, PermissionName  FROM BugNet_Permissions
INNER JOIN BugNet_RolePermissions on BugNet_RolePermissions.PermissionId = BugNet_Permissions.PermissionId
WHERE RoleId = @RoleId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_Delete]
	@IssueId Int
AS
UPDATE BugNet_Issues SET
	Disabled = 1
WHERE
	IssueId = @IssueId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_CreateNewIssue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_CreateNewIssue]
  @IssueTitle nvarchar(500),
  @IssueDescription nvarchar(max),
  @ProjectId Int,
  @IssueCategoryId Int,
  @IssueStatusId Int,
  @IssuePriorityId Int,
  @IssueMilestoneId Int,
  @IssueAffectedMilestoneId Int,
  @IssueTypeId Int,
  @IssueResolutionId Int,
  @IssueAssignedUserName NVarChar(255),
  @IssueCreatorUserName NVarChar(255),
  @IssueOwnerUserName NVarChar(255),
  @IssueDueDate datetime,
  @IssueVisibility int,
  @IssueEstimation decimal(4,2),
  @IssueProgress int
AS

DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueCreatorUserId		UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER

SELECT @IssueAssignedUserId = UserId FROM aspnet_users WHERE UserName = @IssueAssignedUserName
SELECT @IssueCreatorUserId = UserId FROM aspnet_users WHERE UserName = @IssueCreatorUserName
SELECT @IssueOwnerUserId = UserId FROM aspnet_users WHERE UserName = @IssueOwnerUserName

	INSERT BugNet_Issues
	(
		IssueTitle,
		IssueDescription,
		IssueCreatorUserId,
		DateCreated,
		IssueStatusId,
		IssuePriorityId,
		IssueTypeId,
		IssueCategoryId,
		IssueAssignedUserId,
		ProjectId,
		IssueResolutionId,
		IssueMilestoneId,
		IssueAffectedMilestoneId,
		LastUpdateUserId,
		LastUpdate,
		IssueDueDate,
		IssueVisibility,
		IssueEstimation,
		IssueProgress,
		IssueOwnerUserId
	)
	VALUES
	(
		@IssueTitle,
		@IssueDescription,
		@IssueCreatorUserId,
		GetDate(),
		@IssueStatusId,
		@IssuePriorityId,
		@IssueTypeId,
		@IssueCategoryId,
		@IssueAssignedUserId,
		@ProjectId,
		@IssueResolutionId,
		@IssueMilestoneId,
		@IssueAffectedMilestoneId,
		@IssueCreatorUserId,
		GetDate(),
		@IssueDueDate,
		@IssueVisibility,
		@IssueEstimation,
		@IssueProgress,
		@IssueOwnerUserId
	)
RETURN scope_identity()' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuePriorityCountByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]
 @ProjectId int
AS
	SELECT 
		p.PriorityName, COUNT(nt.IssuePriorityId) AS Number, p.PriorityId, p.PriorityImageUrl
	FROM   
		BugNet_ProjectPriorities p
	
	LEFT JOIN 
		(SELECT  
			IssuePriorityId, ProjectId 
		FROM   
			BugNet_Issues
		WHERE  
			Disabled = 0
			AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)) nt  
		ON 
			p.PriorityId = nt.IssuePriorityId AND nt.ProjectId = @ProjectId
		WHERE 
			p.ProjectId = @ProjectId
		GROUP BY 
			p.PriorityName, p.PriorityId, p.PriorityImageUrl
	









' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueMilestoneCountByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject] 
	@ProjectId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT v.MilestoneName, COUNT(nt.IssueMilestoneId) AS Number, v.MilestoneId, v.MilestoneImageUrl
	FROM BugNet_ProjectMilestones v 
	LEFT OUTER JOIN 
(SELECT IssueMilestoneId
	FROM BugNet_Issues   
	WHERE 
		Disabled = 0 
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)) nt 
	ON 
		v.MilestoneId = nt.IssueMilestoneId 
	WHERE 
		(v.ProjectId = @ProjectId) 
	GROUP BY 
		v.MilestoneName, v.MilestoneId,v.SortOrder, v.MilestoneImageUrl
	ORDER BY 
		v.SortOrder ASC
END





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueCategoryCountByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueCategoryCountByProject]
 @ProjectId int,
 @CategoryId int
AS
	SELECT 
		COUNT(IssueId) 
	FROM
		BugNet_Issues 
	WHERE 
		ProjectId = @ProjectId 
		AND IssueCategoryId = @CategoryId 
		AND Disabled = 0
		AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotifications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_IssueNotifications](
	[IssueNotificationId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueNotifications] PRIMARY KEY CLUSTERED 
(
	[IssueNotificationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_DeleteRolePermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Permission_DeleteRolePermission]
	@PermissionId Int,
	@RoleId Int 
AS
DELETE 
	BugNet_RolePermissions
WHERE
	PermissionId = @PermissionId
	AND RoleId = @RoleId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Permission_AddRolePermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Permission_AddRolePermission]
	@PermissionId int,
	@RoleId int
AS
IF NOT EXISTS (SELECT PermissionId FROM BugNet_RolePermissions WHERE PermissionId = @PermissionId AND RoleId = @RoleId)
BEGIN
	INSERT  BugNet_RolePermissions
	(
		PermissionId,
		RoleId
	)
	VALUES
	(
		@PermissionId,
		@RoleId
	)
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReports]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_IssueWorkReports](
	[IssueWorkReportId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[WorkDate] [datetime] NOT NULL,
	[Duration] [decimal](4, 2) NOT NULL,
	[IssueCommentId] [int] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueWorkReports] PRIMARY KEY CLUSTERED 
(
	[IssueWorkReportId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_UpdateIssue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_UpdateIssue]
  @IssueId Int,
  @IssueTitle nvarchar(500),
  @IssueDescription nvarchar(max),
  @ProjectId Int,
  @IssueCategoryId Int,
  @IssueStatusId Int,
  @IssuePriorityId Int,
  @IssueMilestoneId Int,
  @IssueAffectedMilestoneId Int,
  @IssueTypeId Int,
  @IssueResolutionId Int,
  @IssueAssignedUserName NVarChar(255),
  @IssueCreatorUserName NVarChar(255),
  @IssueOwnerUserName NVarChar(255),
  @LastUpdateUserName NVarChar(255),
  @IssueDueDate datetime,
  @IssueVisibility int,
  @IssueEstimation decimal(5,2),
  @IssueProgress int
AS

DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueCreatorUserId		UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER
DECLARE @LastUpdateUserId  UNIQUEIDENTIFIER

SELECT @IssueAssignedUserId = UserId FROM aspnet_users WHERE UserName = @IssueAssignedUserName
SELECT @IssueCreatorUserId = UserId FROM aspnet_users WHERE UserName = @IssueCreatorUserName
SELECT @IssueOwnerUserId = UserId FROM aspnet_users WHERE UserName = @IssueOwnerUserName
SELECT @LastUpdateUserId = UserId FROM aspnet_users WHERE UserName = @LastUpdateUserName

BEGIN TRAN
	UPDATE BugNet_Issues SET
		IssueTitle = @IssueTitle,
		IssueCategoryId = @IssueCategoryId,
		ProjectId = @ProjectId,
		IssueStatusId = @IssueStatusId,
		IssuePriorityId = @IssuePriorityId,
		IssueMilestoneId = @IssueMilestoneId,
		IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
		IssueAssignedUserId = @IssueAssignedUserId,
		IssueOwnerUserId = @IssueOwnerUserId,
		IssueTypeId = @IssueTypeId,
		IssueResolutionId = @IssueResolutionId,
		IssueDueDate = @IssueDueDate,
		IssueVisibility = @IssueVisibility,
		IssueEstimation = @IssueEstimation,
		IssueProgress = @IssueProgress,
		IssueDescription = @IssueDescription,
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GetDate()
	WHERE 
		IssueId = @IssueId
	
	/*EXEC BugNet_IssueHistory_CreateNewHistory @IssueId, @IssueCreatorId*/
COMMIT TRAN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueUserCountByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUserCountByProject]
 @ProjectId int
AS
	SELECT 
		ISNULL(AssignedUsersProfile.DisplayName,u.Username ) AS ''Name'',COUNT(I.IssueId) AS ''Number'', u.UserId, ''''
	FROM 
		BugNet_UserProjects pm 
		LEFT OUTER JOIN aspnet_Users u ON pm.UserId = u.UserId 
		LEFT OUTER JOIN BugNet_Issues I ON I.IssueAssignedUserId = u.UserId
		LEFT OUTER JOIN BugNet_UserProfiles AS AssignedUsersProfile ON u.UserName = AssignedUsersProfile.UserName
	WHERE 
		(pm.ProjectId = @ProjectId) 
		AND (I.ProjectId = @ProjectId ) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)
	GROUP BY 
		u.Username, u.UserID,AssignedUsersProfile.DisplayName
	ORDER BY AssignedUsersProfile.DisplayName ASC






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject]
 @ProjectId int
AS
	SELECT
		COUNT(IssueId) AS ''Number'' 
	FROM 
		BugNet_Issues 
	WHERE 
		(IssueMilestoneId IS NULL) 
		AND (ProjectId = @ProjectId) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueUnassignedCountByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUnassignedCountByProject]
 @ProjectId int
AS
	SELECT
		COUNT(IssueId) AS ''Number'' 
	FROM 
		BugNet_Issues 
	WHERE 
		(IssueAssignedUserId IS NULL) 
		AND (ProjectId = @ProjectId) 
		AND Disabled = 0
		AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueTypeCountByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueTypeCountByProject]
	@ProjectId int
AS
	SELECT 
		t.IssueTypeName, COUNT(nt.IssueTypeId) AS ''Number'', t.IssueTypeId, t.IssueTypeImageUrl
	FROM  
		BugNet_ProjectIssueTypes t 
	LEFT OUTER JOIN 
	(SELECT  
			IssueTypeId, ProjectId 
		FROM   
			BugNet_Issues
		WHERE  
			Disabled = 0
			AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId)) nt  
		ON 
			t.IssueTypeId = nt.IssueTypeId AND nt.ProjectId = @ProjectId
		WHERE 
			t.ProjectId = @ProjectId
		GROUP BY 
			t.IssueTypeName, t.IssueTypeId, t.IssueTypeImageUrl





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueStatusCountByProject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueStatusCountByProject]
 @ProjectId int
AS
	SELECT 
		s.StatusName,COUNT(nt.IssueStatusId) as ''Number'', s.StatusId, s.StatusImageUrl
	FROM 
		BugNet_ProjectStatus s 
	LEFT OUTER JOIN 
	(SELECT  
			IssueStatusId, ProjectId 
		FROM   
			BugNet_Issues 
		WHERE  
			Disabled = 0
			AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectId)) nt  
		ON 
			s.StatusId = nt.IssueStatusId AND nt.ProjectId = @ProjectId
		WHERE 
			s.ProjectId = @ProjectId
		GROUP BY 
			s.StatusName, s.StatusId, s.StatusImageUrl






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_IssueAttachments](
	[IssueAttachmentId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[FileName] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](80) NOT NULL,
	[FileSize] [int] NOT NULL,
	[ContentType] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Attachment] [varbinary](max) NULL,
 CONSTRAINT [PK_BugNet_IssueAttachments] PRIMARY KEY CLUSTERED 
(
	[IssueAttachmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_IssueHistory](
	[IssueHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[FieldChanged] [nvarchar](50) NOT NULL,
	[OldValue] [nvarchar](50) NOT NULL,
	[NewValue] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueHistory] PRIMARY KEY CLUSTERED 
(
	[IssueHistoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_IssueComments](
	[IssueCommentId] [int] IDENTITY(1,1) NOT NULL,
	[IssueId] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueComments] PRIMARY KEY CLUSTERED 
(
	[IssueCommentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevisions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_IssueRevisions](
	[IssueRevisionId] [int] IDENTITY(1,1) NOT NULL,
	[Revision] [int] NOT NULL,
	[IssueId] [int] NOT NULL,
	[Repository] [nvarchar](400) NOT NULL,
	[RevisionAuthor] [nvarchar](100) NOT NULL,
	[RevisionDate] [nvarchar](100) NOT NULL,
	[RevisionMessage] [nvarchar](max) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_BugNet_IssueRevisions] PRIMARY KEY CLUSTERED 
(
	[IssueRevisionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetProjectRolesByUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[BugNet_Role_GetProjectRolesByUser] 
	@UserName       nvarchar(256),
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	R.RoleName,
		R.ProjectId,
		R.RoleDescription,
		R.RoleId,
		R.AutoAssign
FROM	BugNet_UserRoles
INNER JOIN aspnet_users ON BugNet_UserRoles.UserId = aspnet_users.UserId
INNER JOIN BugNet_Roles R ON BugNet_UserRoles.RoleId = R.RoleId
WHERE  aspnet_users.UserId = @UserId
AND    (R.ProjectId IS NULL OR R.ProjectId = @ProjectId)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_RoleHasPermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_RoleHasPermission] 
	@ProjectID 		int,
	@Role 			nvarchar(256),
	@PermissionKey	nvarchar(50)
AS

SELECT COUNT(*) FROM BugNet_RolePermissions INNER JOIN BugNet_Roles ON BugNet_Roles.RoleId = BugNet_RolePermissions.RoleId INNER JOIN
BugNet_Permissions ON BugNet_RolePermissions.PermissionId = BugNet_Permissions.PermissionId

WHERE ProjectId = @ProjectID 
AND 
PermissionKey = @PermissionKey
AND 
BugNet_Roles.RoleName = @Role
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_RemoveUserFromRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_RemoveUserFromRole]
	@UserName	nvarchar(256),
	@RoleId		Int 
AS

DECLARE @ProjectId int
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName
SELECT	@ProjectId = ProjectId FROM BugNet_Roles WHERE RoleId = @RoleId

IF EXISTS (SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId) AND @RoleId <> 1
BEGIN
 EXEC BugNet_Project_RemoveUserFromProject @UserName, @ProjectId
END

DELETE 
	BugNet_UserRoles
WHERE
	UserId = @UserId
	AND RoleId = @RoleId




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_IsUserInRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[BugNet_Role_IsUserInRole] 
	@UserName		nvarchar(256),
	@RoleId			int,
	@ProjectId      int
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	UR.UserId,
		UR.RoleId
FROM	BugNet_UserRoles UR
INNER JOIN BugNet_Roles R ON UR.RoleId = R.RoleId
WHERE	UR.UserId = @UserId
AND		UR.RoleId = @RoleId
AND		R.ProjectId = @ProjectId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_GetRolesByUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[BugNet_Role_GetRolesByUser] 
	@UserName       nvarchar(256)
AS

DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName

SELECT	BugNet_Roles.RoleName,
		BugNet_Roles.ProjectId,
		BugNet_Roles.RoleDescription,
		BugNet_Roles.RoleId,
		BugNet_Roles.AutoAssign
FROM	BugNet_UserRoles
INNER JOIN aspnet_users ON BugNet_UserRoles.UserId = aspnet_users.UserId
INNER JOIN BugNet_Roles ON BugNet_UserRoles.RoleId = BugNet_Roles.RoleId
WHERE  aspnet_users.UserId = @UserId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Role_AddUserToRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Role_AddUserToRole]
	@UserName nvarchar(256),
	@RoleId int
AS

DECLARE @ProjectId int
DECLARE @UserId UNIQUEIDENTIFIER
SELECT	@UserId = UserId FROM aspnet_users WHERE Username = @UserName
SELECT	@ProjectId = ProjectId FROM BugNet_Roles WHERE RoleId = @RoleId

IF NOT EXISTS (SELECT UserId FROM BugNet_UserProjects WHERE UserId = @UserId AND ProjectId = @ProjectId) AND @RoleId <> 1
BEGIN
 EXEC BugNet_Project_AddUserToProject @UserName, @ProjectId
END

IF NOT EXISTS (SELECT UserId FROM BugNet_UserRoles WHERE UserId = @UserId AND RoleId = @RoleId)
BEGIN
	INSERT  BugNet_UserRoles
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


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_SaveQueryClause]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Query_SaveQueryClause] 
  @QueryId Int,
  @BooleanOperator NVarChar(50),
  @FieldName NVarChar(50),
  @ComparisonOperator NVarChar(50),
  @FieldValue NVarChar(50),
  @DataType Int,
  @IsCustomField bit
AS
INSERT BugNet_QueryClauses
(
  QueryId,
  BooleanOperator,
  FieldName,
  ComparisonOperator,
  FieldValue,
  DataType, 
  IsCustomField
) 
VALUES (
  @QueryId,
  @BooleanOperator,
  @FieldName,
  @ComparisonOperator,
  @FieldValue,
  @DataType,
  @IsCustomField
)


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_GetSavedQuery]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Query_GetSavedQuery] 
  @QueryId INT
AS

SELECT 
	BooleanOperator,
	FieldName,
	ComparisonOperator,
	FieldValue,
	DataType,
	IsCustomField
FROM 
	BugNet_QueryClauses
WHERE 
	QueryId = @QueryId;

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Query_DeleteQuery]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Query_DeleteQuery] 
  @QueryId Int
AS
DELETE BugNet_Queries WHERE QueryId = @QueryId
DELETE BugNet_QueryClauses WHERE QueryId = @QueryId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_Update]
	@CustomFieldSelectionId Int,
	@CustomFieldId Int,
	@CustomFieldSelectionName NVarChar(50),
	@CustomFieldSelectionValue NVarChar(50),
	@CustomFieldSelectionSortOrder int
AS
DECLARE @OldSortOrder int
DECLARE @OldCustomFieldSelectionId int

SELECT @OldSortOrder = CustomFieldSelectionSortOrder  FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldSelectionId = @CustomFieldSelectionId
SELECT @OldCustomFieldSelectionId = CustomFieldSelectionId FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder  AND CustomFieldId = @CustomFieldId

UPDATE 
	BugNet_ProjectCustomFieldSelections
SET
	CustomFieldId = @CustomFieldId,
	CustomFieldSelectionName = @CustomFieldSelectionName,
	CustomFieldSelectionValue = @CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
WHERE 
	CustomFieldSelectionId = @CustomFieldSelectionId
	
UPDATE BugNet_ProjectCustomFieldSelections SET
	CustomFieldSelectionSortOrder = @OldSortOrder
WHERE CustomFieldSelectionId = @OldCustomFieldSelectionId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId] 
	@CustomFieldId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	BugNet_ProjectCustomFieldSelections
WHERE
	CustomFieldId = @CustomFieldId
ORDER BY CustomFieldSelectionSortOrder

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById] 
	@CustomFieldSelectionId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	BugNet_ProjectCustomFieldSelections
WHERE
	CustomFieldSelectionId = @CustomFieldSelectionId
ORDER BY CustomFieldSelectionSortOrder

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]
 @CustomFieldSelectionIdToDelete INT
AS
DELETE FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
	@CustomFieldId Int,
	@CustomFieldSelectionValue NVarChar(255),
	@CustomFieldSelectionName NVarChar(255)
AS

DECLARE @CustomFieldSelectionSortOrder int
SELECT @CustomFieldSelectionSortOrder = ISNULL(MAX(CustomFieldSelectionSortOrder),0) + 1 FROM BugNet_ProjectCustomFieldSelections

IF NOT EXISTS(SELECT CustomFieldSelectionId FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldId = @CustomFieldId AND LOWER(CustomFieldSelectionName) = LOWER(@CustomFieldSelectionName) )
BEGIN
	INSERT BugNet_ProjectCustomFieldSelections
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

	RETURN scope_identity()
END
RETURN 0

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BugNet_RelatedIssues](
	[PrimaryIssueId] [int] NOT NULL,
	[SecondaryIssueId] [int] NOT NULL,
	[RelationType] [int] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_GetRelatedIssues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetRelatedIssues]
	@IssueId Int,
	@RelationType Int
AS
	
SELECT
	IssueId,
	IssueTitle,
	StatusName as IssueStatus,
	ResolutionName as IssueResolution,
	DateCreated
FROM
	BugNet_Issues
	JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId 
WHERE
	IssueId IN (SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE SecondaryIssueId = @IssueId AND RelationType = @RelationType)
	OR IssueId IN (SELECT SecondaryIssueId FROM BugNet_RelatedIssues WHERE PrimaryIssueId = @IssueId AND RelationType = @RelationType)
ORDER BY
	IssueId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_GetParentIssues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetParentIssues]
	@IssueId Int,
	@RelationType Int
AS
	
SELECT
	IssueId,
	IssueTitle,
	StatusName as IssueStatus,
	ResolutionName as IssueResolution,
	DateCreated
FROM
	BugNet_RelatedIssues
	INNER JOIN BugNet_Issues ON PrimaryIssueId = IssueId
	JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId
WHERE
	SecondaryIssueId = @IssueId
	AND RelationType = @RelationType
ORDER BY
	PrimaryIssueId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_GetChildIssues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetChildIssues]
	@IssueId Int,
	@RelationType Int
AS
	
SELECT
	IssueId,
	IssueTitle,
	StatusName as IssueStatus,
	ResolutionName as IssueResolution,
	DateCreated
FROM
	BugNet_RelatedIssues
	INNER JOIN BugNet_Issues ON SecondaryIssueId = IssueId
	JOIN BugNet_ProjectStatus ON BugNet_Issues.IssueStatusId = BugNet_ProjectStatus.StatusId
	JOIN BugNet_ProjectResolutions ON BugNet_Issues.IssueResolutionId = BugNet_ProjectResolutions.ResolutionId
WHERE
	PrimaryIssueId = @IssueId
	AND RelationType = @RelationType
ORDER BY
	SecondaryIssueId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_DeleteRelatedIssue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteRelatedIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	( (PrimaryIssueId = @PrimaryIssueId AND SecondaryIssueId = @SecondaryIssueId) OR (PrimaryIssueId = @SecondaryIssueId AND SecondaryIssueId = @PrimaryIssueId) )
	AND RelationType = @RelationType' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_DeleteParentIssue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE  [dbo].[BugNet_RelatedIssue_DeleteParentIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	PrimaryIssueId = @SecondaryIssueId
	AND SecondaryIssueId = @PrimaryIssueId
	AND RelationType = @RelationType
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_DeleteChildIssue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteChildIssue]
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
DELETE
	BugNet_RelatedIssues
WHERE
	PrimaryIssueId = @PrimaryIssueId
	AND SecondaryIssueId = @SecondaryIssueId
	AND RelationType = @RelationType
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_CreateNewRelatedIssue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewRelatedIssue] 
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
IF NOT EXISTS(SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE (PrimaryIssueId = @PrimaryIssueId OR PrimaryIssueId = @SecondaryIssueId) AND (SecondaryIssueId = @SecondaryIssueId OR SecondaryIssueId = @PrimaryIssueId) AND RelationType = @RelationType)
BEGIN
	INSERT BugNet_RelatedIssues
	(
		PrimaryIssueId,
		SecondaryIssueId,
		RelationType
	)
	VALUES
	(
		@SecondaryIssueId,
		@PrimaryIssueId,
		@RelationType
	)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_CreateNewParentIssue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewParentIssue] 
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
IF NOT EXISTS(SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE PrimaryIssueId = @SecondaryIssueId AND SecondaryIssueId = @PrimaryIssueId AND RelationType = @RelationType)
BEGIN
	INSERT BugNet_RelatedIssues
	(
		PrimaryIssueId,
		SecondaryIssueId,
		RelationType
	)
	VALUES
	(
		@SecondaryIssueId,
		@PrimaryIssueId,
		@RelationType
	)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssue_CreateNewChildIssue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewChildIssue] 
	@PrimaryIssueId Int,
	@SecondaryIssueId Int,
	@RelationType Int
AS
IF NOT EXISTS(SELECT PrimaryIssueId FROM BugNet_RelatedIssues WHERE PrimaryIssueId = @PrimaryIssueId AND SecondaryIssueId = @SecondaryIssueId AND RelationType = @RelationType)
BEGIN
	INSERT BugNet_RelatedIssues
	(
		PrimaryIssueId,
		SecondaryIssueId,
		RelationType
	)
	VALUES
	(
		@PrimaryIssueId,
		@SecondaryIssueId,
		@RelationType
	)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId] 
  @IssueId Int
AS
SELECT 
	*
FROM 
	BugNet_IssueRevisions
WHERE
	IssueId = @IssueId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevision_DeleteIssueRevisions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueRevision_DeleteIssueRevisions] 
  @IssueRevisionId Int
AS
DELETE FROM
	BugNet_IssueRevisions
WHERE
	IssueRevisionId = @IssueRevisionId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevision_CreateNewIssueRevision]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]
	@IssueId int,
	@Revision int,
	@Repository nvarchar(400),
	@RevisionDate nvarchar(100),
	@RevisionAuthor nvarchar(100),
	@RevisionMessage ntext
AS

INSERT BugNet_IssueRevisions
(
	Revision,
	IssueId,
	Repository,
	RevisionAuthor,
	RevisionDate,
	RevisionMessage,
	DateCreated
) 
VALUES 
(
	@Revision,
	@IssueId,
	@Repository,
	@RevisionAuthor,
	@RevisionDate,
	@RevisionMessage,
	GetDate()
)

RETURN scope_identity()


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_UpdateIssueComment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueComment_UpdateIssueComment]
	@IssueCommentId int,
	@IssueId int,
	@CreatorUserName nvarchar(255),
	@Comment ntext
AS

DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName

UPDATE BugNet_IssueComments SET
	IssueId = @IssueId,
	UserId = @UserId,
	Comment = @Comment
WHERE IssueCommentId= @IssueCommentId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]
	@IssueId Int 
AS

SELECT 
	IssueCommentId,
	IssueId,
	Comment,
	U.UserId CreatorUserId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'''') CreatorDisplayName,
	DateCreated
FROM
	BugNet_IssueComments
	INNER JOIN aspnet_Users U ON BugNet_IssueComments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY 
	DateCreated DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_GetIssueCommentById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentById]
 @IssueCommentId INT
AS
SELECT
	IssueCommentId,
	IssueId,
	Comment,
	U.UserId CreatorUserId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'''') CreatorDisplayName,
	DateCreated
FROM
	BugNet_IssueComments
	INNER JOIN aspnet_Users U ON BugNet_IssueComments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueCommentId = @IssueCommentId
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_DeleteIssueComment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueComment_DeleteIssueComment]
	@IssueCommentId Int
AS
DELETE 
	BugNet_IssueComments
WHERE
	IssueCommentId = @IssueCommentId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComment_CreateNewIssueComment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueComment_CreateNewIssueComment]
	@IssueId int,
	@CreatorUserName NVarChar(255),
	@Comment ntext
AS
-- Get Last Update UserID
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
INSERT BugNet_IssueComments
(
	IssueId,
	UserId,
	DateCreated,
	Comment
) 
VALUES 
(
	@IssueId,
	@UserId,
	GetDate(),
	@Comment
)

/* Update the LastUpdate fields of this bug*/
UPDATE BugNet_Issues SET LastUpdate = GetDate(),LastUpdateUserId = @UserId WHERE IssueId = @IssueId

RETURN scope_identity()
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]
	@IssueId Int 
AS

SELECT 
	IssueAttachmentId,
	IssueId,
	FileSize,
	Description,
	Attachment,
	ContentType,
	U.UserName CreatorUsername,
	IsNull(DisplayName,'''') CreatorDisplayName,
	FileName,
	DateCreated
FROM
	BugNet_IssueAttachments
	INNER JOIN aspnet_Users U ON BugNet_IssueAttachments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY 
	DateCreated DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]
 @IssueAttachmentId INT
AS
SELECT
	IssueAttachmentId,
	IssueId,
	FileSize,
	Description,
	Attachment,
	ContentType,
	U.UserName CreatorUsername,
	IsNull(DisplayName,'''') CreatorDisplayName,
	FileName,
	DateCreated
FROM
	BugNet_IssueAttachments
	INNER JOIN aspnet_Users U ON BugNet_IssueAttachments.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueAttachmentId = @IssueAttachmentId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachment_DeleteIssueAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_DeleteIssueAttachment]
 @IssueAttachmentId INT
AS
DELETE
FROM
	BugNet_IssueAttachments
WHERE
	IssueAttachmentId = @IssueAttachmentId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_CreateNewIssueAttachment]
  @IssueId int,
  @FileName nvarchar(100),
  @FileSize Int,
  @ContentType nvarchar(50),
  @CreatorUserName nvarchar(255),
  @Attachment Image
AS
-- Get Uploaded UserID
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
	INSERT BugNet_IssueAttachments
	(
		IssueId,
		FileName,
		Description,
		FileSize,
		ContentType,
		DateCreated,
		UserId,
		Attachment
	)
	VALUES
	(
		@IssueId,
		@FileName,
		'''',
		@FileSize,
		@ContentType,
		GetDate(),
		@UserId,
		@Attachment
	)
	RETURN scope_identity()
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]
AS
SELECT     dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueTitle, '' '' AS IssueDescription, dbo.BugNet_Issues.IssueStatusId, 
                      dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, 
                      dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, 
                      dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueOwnerUserId, dbo.BugNet_Issues.IssueDueDate, 
                      dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueVisibility, dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, 
                      dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, dbo.BugNet_Projects.ProjectName, dbo.BugNet_Projects.ProjectCode, 
                      dbo.BugNet_ProjectPriorities.PriorityName, dbo.BugNet_ProjectIssueTypes.IssueTypeName, ISNULL(dbo.BugNet_ProjectCategories.CategoryName, 
                      N''none'') AS CategoryName, dbo.BugNet_ProjectStatus.StatusName, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N''none'') 
                      AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N''none'') AS AffectedMilestoneName, 
                      ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, ''none'') AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, 
                      ISNULL(AssignedUsers.UserName, N''none'') AS AssignedUsername, ISNULL(AssignedUsersProfile.DisplayName, N''none'') AS AssignedDisplayName, 
                      CreatorUsers.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, N''none'') AS CreatorDisplayName, 
                      ISNULL(OwnerUsers.UserName, ''none'') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N''none'') AS OwnerDisplayName, 
                      ISNULL(LastUpdateUsersProfile.DisplayName, ''none'') AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '''') 
                      AS PriorityImageUrl, ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '''') AS IssueTypeImageUrl, 
                      ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '''') AS StatusImageUrl, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '''') 
                      AS MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '''') AS ResolutionImageUrl, 
                      ISNULL(AffectedMilestone.MilestoneImageUrl, '''') AS AffectedMilestoneImageUrl, ISNULL
                          ((SELECT     SUM(Duration) AS Expr1
                              FROM         dbo.BugNet_IssueWorkReports AS WR
                              WHERE     (dbo.BugNet_Issues.IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                          ((SELECT     COUNT(IssueId) AS Expr1
                              FROM         dbo.BugNet_IssueVotes AS V
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_ProjectCustomFields.CustomFieldName, 
                      dbo.BugNet_ProjectCustomFieldValues.CustomFieldValue
FROM         dbo.BugNet_ProjectCustomFields INNER JOIN
                      dbo.BugNet_ProjectCustomFieldValues ON 
                      dbo.BugNet_ProjectCustomFields.CustomFieldId = dbo.BugNet_ProjectCustomFieldValues.CustomFieldId RIGHT OUTER JOIN
                      dbo.BugNet_Issues ON dbo.BugNet_ProjectCustomFieldValues.IssueId = dbo.BugNet_Issues.IssueId LEFT OUTER JOIN
                      dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId LEFT OUTER JOIN
                      dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId LEFT OUTER JOIN
                      dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId LEFT OUTER JOIN
                      dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones AS AffectedMilestone ON 
                      dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId LEFT OUTER JOIN
                      dbo.aspnet_Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId
'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]
	@IssueId INT
AS
SELECT      
	IssueWorkReportId,
	BugNet_IssueWorkReports.IssueId,
	WorkDate,
	Duration,
	BugNet_IssueWorkReports.IssueCommentId,
	BugNet_IssueWorkReports.UserId CreatorUserId, 
	U.UserName CreatorUsername,
	IsNull(DisplayName,'''') CreatorDisplayName,
    ISNULL(BugNet_IssueComments.Comment, '''') Comment
FROM         
	BugNet_IssueWorkReports
	INNER JOIN aspnet_Users U ON BugNet_IssueWorkReports.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
	LEFT OUTER JOIN BugNet_IssueComments ON BugNet_IssueComments.IssueCommentId =  BugNet_IssueWorkReports.IssueCommentId
WHERE
	 BugNet_IssueWorkReports.IssueId = @IssueId
ORDER BY WorkDate DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReport_DeleteIssueWorkReport]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_DeleteIssueWorkReport]
	@IssueWorkReportId int
AS
DELETE 
	BugNet_IssueWorkReports
WHERE
	IssueWorkReportId = @IssueWorkReportId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]
	@IssueId int,
	@CreatorUserName nvarchar(255),
	@WorkDate datetime ,
	@Duration decimal(4,2),
	@IssueCommentId int
AS
-- Get Last Update UserID
DECLARE @CreatorUserId uniqueidentifier
SELECT @CreatorUserId = UserId FROM aspnet_users WHERE Username = @CreatorUserName
INSERT BugNet_IssueWorkReports
(
	IssueId,
	UserId,
	WorkDate,
	Duration,
	IssueCommentId
) 
VALUES 
(
	@IssueId,
	@CreatorUserId,
	@WorkDate,
	@Duration,
	@IssueCommentID
)
RETURN scope_identity()
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId] 
	@IssueId Int
AS

/* This will return multiple results if the user is 
subscribed at the project level and issue level*/
declare @tmpTable table (IssueNotificationId int, IssueId int,NotificationUserId uniqueidentifier, NotificationUsername nvarchar(50), NotificationDisplayName nvarchar(50), NotificationEmail nvarchar(50))
INSERT @tmpTable

SELECT 
	IssueNotificationId,
	IssueId,
	U.UserId NotificationUserId,
	U.UserName NotificationUsername,
	IsNull(DisplayName,'''') NotificationDisplayName,
	M.Email NotificationEmail
FROM
	BugNet_IssueNotifications
	INNER JOIN aspnet_Users U ON BugNet_IssueNotifications.UserId = U.UserId
	INNER JOIN aspnet_Membership M ON BugNet_IssueNotifications.UserId = M.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE
	IssueId = @IssueId
ORDER BY
	DisplayName

-- get all people on the project who want to be notified

INSERT @tmpTable
SELECT
	ProjectNotificationId,
	IssueId = @IssueId,
	u.UserId NotificationUserId,
	u.UserName NotificationUsername,
	IsNull(DisplayName,'''') NotificationDisplayName,
	m.Email NotificationEmail
FROM
	BugNet_ProjectNotifications p,
	BugNet_Issues i,
	aspnet_Users u,
	aspnet_Membership m ,
	BugNet_UserProfiles up
WHERE
	IssueId = @IssueId
	AND p.ProjectId = i.ProjectId
	AND u.UserId = p.UserId
	AND u.UserId = m.UserId
	AND u.UserName = up.UserName

SELECT * FROM @tmpTable
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotification_DeleteIssueNotification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueNotification_DeleteIssueNotification]
	@IssueId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId uniqueidentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE UserName = @Username
DELETE 
	BugNet_IssueNotifications
WHERE
	IssueId = @IssueId
	AND UserId = @UserId 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotification_CreateNewIssueNotification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueNotification_CreateNewIssueNotification]
	@IssueId Int,
	@NotificationUserName NVarChar(255) 
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @NotificationUserName

IF NOT EXISTS( SELECT IssueNotificationId FROM BugNet_IssueNotifications WHERE UserId = @UserId AND IssueId = @IssueId)
BEGIN
	INSERT BugNet_IssueNotifications
	(
		IssueId,
		UserId
	)
	VALUES
	(
		@IssueId,
		@UserId
	)
	RETURN scope_identity()
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]
	@IssueId int
AS
 SELECT
	IssueHistoryId,
	IssueId,
	U.UserName CreatorUsername,
	IsNull(DisplayName,'''') CreatorDisplayName,
	FieldChanged,
	OldValue,
	NewValue,
	DateCreated
FROM 
	BugNet_IssueHistory
	INNER JOIN aspnet_Users U ON BugNet_IssueHistory.UserId = U.UserId
	LEFT OUTER JOIN BugNet_UserProfiles ON U.UserName = BugNet_UserProfiles.UserName
WHERE 
	IssueId = @IssueId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory_CreateNewIssueHistory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_IssueHistory_CreateNewIssueHistory]
  @IssueId int,
  @CreatedUserName nvarchar(255),
  @FieldChanged nvarchar(50),
  @OldValue nvarchar(50),
  @NewValue nvarchar(50)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_users WHERE UserName = @CreatedUserName

	INSERT BugNet_IssueHistory
	(
		IssueId,
		UserId,
		FieldChanged,
		OldValue,
		NewValue,
		DateCreated
	)
	VALUES
	(
		@IssueId,
		@UserId,
		@FieldChanged,
		@OldValue,
		@NewValue,
		GetDate()
	)
RETURN scope_identity()
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssuesView]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[BugNet_IssuesView]
AS
SELECT     dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.IssueTitle, dbo.BugNet_Issues.IssueDescription, dbo.BugNet_Issues.IssueStatusId, 
                      dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, 
                      dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, 
                      dbo.BugNet_Issues.IssueOwnerUserId, dbo.BugNet_Issues.IssueDueDate, dbo.BugNet_Issues.IssueMilestoneId, 
                      dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueVisibility, dbo.BugNet_Issues.IssueEstimation, 
                      dbo.BugNet_Issues.DateCreated, dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, dbo.BugNet_Projects.ProjectName, 
                      dbo.BugNet_Projects.ProjectCode, dbo.BugNet_ProjectPriorities.PriorityName, dbo.BugNet_ProjectIssueTypes.IssueTypeName, 
                      ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N''none'') AS CategoryName, dbo.BugNet_ProjectStatus.StatusName, 
                      ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N''none'') AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N''none'') 
                      AS AffectedMilestoneName, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, ''none'') AS ResolutionName, 
                      LastUpdateUsers.UserName AS LastUpdateUserName, ISNULL(AssignedUsers.UserName, N''none'') AS AssignedUsername, 
                      ISNULL(AssignedUsersProfile.DisplayName, N''none'') AS AssignedDisplayName, CreatorUsers.UserName AS CreatorUserName, 
                      ISNULL(CreatorUsersProfile.DisplayName, N''none'') AS CreatorDisplayName, ISNULL(OwnerUsers.UserName, ''none'') AS OwnerUserName, 
                      ISNULL(OwnerUsersProfile.DisplayName, N''none'') AS OwnerDisplayName, ISNULL(LastUpdateUsersProfile.DisplayName, ''none'') 
                      AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '''') AS PriorityImageUrl, 
                      ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '''') AS IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '''') 
                      AS StatusImageUrl, ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '''') AS MilestoneImageUrl, 
                      ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '''') AS ResolutionImageUrl, ISNULL(AffectedMilestone.MilestoneImageUrl, '''') 
                      AS AffectedMilestoneImageUrl, ISNULL
                          ((SELECT     SUM(Duration) AS Expr1
                              FROM         dbo.BugNet_IssueWorkReports AS WR
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                          ((SELECT     COUNT(IssueId) AS Expr1
                              FROM         dbo.BugNet_IssueVotes AS V
                              WHERE     (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueProgress, 
                      dbo.BugNet_ProjectMilestones.MilestoneDueDate
FROM         dbo.BugNet_Issues INNER JOIN
                      dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId LEFT OUTER JOIN
                      dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId LEFT OUTER JOIN
                      dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId LEFT OUTER JOIN
                      dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones AS AffectedMilestone ON 
                      dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId LEFT OUTER JOIN
                      dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId LEFT OUTER JOIN
                      dbo.aspnet_Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId LEFT OUTER JOIN
                      dbo.aspnet_Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId
'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_SaveCustomFieldValue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_SaveCustomFieldValue]
	@IssueId Int,
	@CustomFieldId Int, 
	@CustomFieldValue NVarChar(MAX)
AS
UPDATE 
	BugNet_ProjectCustomFieldValues 
SET
	CustomFieldValue = @CustomFieldValue
WHERE
	IssueId = @IssueId
	AND CustomFieldId = @CustomFieldId

IF @@ROWCOUNT = 0
	INSERT BugNet_ProjectCustomFieldValues
	(
		IssueId,
		CustomFieldId,
		CustomFieldValue
	)
	VALUES
	(
		@IssueId,
		@CustomFieldId,
		@CustomFieldValue
	)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_GetCustomFieldsByIssueId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByIssueId] 
	@IssueId Int
AS
DECLARE @ProjectId Int
SELECT @ProjectId = ProjectId FROM BugNet_Issues WHERE IssueId = @IssueId

SELECT
	Fields.ProjectId,
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	ISNULL(CustomFieldValue,'''') CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_ProjectCustomFields Fields
	LEFT OUTER JOIN BugNet_ProjectCustomFieldValues FieldValues ON (Fields.CustomFieldId = FieldValues.CustomFieldId AND FieldValues.IssueId = @IssueId)
WHERE
	Fields.ProjectId = @ProjectId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomField_DeleteCustomField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
 @CustomFieldIdToDelete INT
AS
DELETE FROM BugNet_ProjectCustomFields WHERE CustomFieldId = @CustomFieldIdToDelete

DELETE FROM BugNet_ProjectCustomFieldValues WHERE CustomFieldId = @CustomFieldIdToDelete


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetChangeLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_Project_GetChangeLog] 
	@ProjectId int
AS

SELECT * FROM 
	BugNet_IssuesView JOIN BugNet_ProjectMilestones PM on IssueMilestoneId = MilestoneId  
WHERE 
	BugNet_IssuesView.ProjectId = @ProjectId  
	AND Disabled = 0 
	AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 1 AND ProjectId = @ProjectId)
ORDER BY 
	(CASE WHEN PM.SortOrder IS NULL THEN 1 ELSE 0 END),PM.SortOrder, CategoryName ASC, IssueTypeName ASC, AssignedUserName ASC



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetRoadMapProgress]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_GetRoadMapProgress]
	@ProjectId int,
	@MilestoneId int
AS
SELECT (SELECT COUNT(*) FROM BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId 
	AND BugNet_IssuesView.Disabled = 0 
	AND IssueMilestoneId = @MilestoneId 
	AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 1 AND ProjectId = @ProjectId)) As ClosedCount , 
(SELECT COUNT(*) FROM BugNet_IssuesView WHERE BugNet_IssuesView.Disabled = 0 AND ProjectId = @ProjectId AND IssueMilestoneId = @MilestoneId) As TotalCount
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetRoadMap]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Project_GetRoadMap]
	@ProjectId int
AS
SELECT 
	PM.SortOrder AS MilestoneSortOrder,IssueId, IssueTitle, IssueDescription, IssueStatusId, IssuePriorityId, IssueTypeId, IssueCategoryId, BugNet_IssuesView.ProjectId, IssueResolutionId, 
	IssueCreatorUserId, IssueAssignedUserId, IssueOwnerUserId, IssueDueDate, BugNet_IssuesView.IssueMilestoneId, IssueVisibility, BugNet_IssuesView.DateCreated, IssueEstimation, LastUpdate, 
	LastUpdateUserId, ProjectName, ProjectCode, PriorityName, IssueTypeName, CategoryName, StatusName, ResolutionName, BugNet_IssuesView.MilestoneName, BugNet_IssuesView.MilestoneDueDate,IssueAffectedMilestoneId, AffectedMilestoneName,
	AffectedMilestoneImageUrl,LastUpdateUserName, 
	AssignedUserName, AssignedDisplayName, CreatorUserName, CreatorDisplayName, OwnerUserName, OwnerDisplayName, LastUpdateDisplayName, 
	PriorityImageUrl, IssueTypeImageUrl, StatusImageUrl, BugNet_IssuesView.MilestoneImageUrl, ResolutionImageUrl, TimeLogged, IssueProgress, Disabled, IssueVotes
FROM 
	BugNet_IssuesView JOIN BugNet_ProjectMilestones PM on IssueMilestoneId = MilestoneId 
WHERE 
	BugNet_IssuesView.ProjectId = @ProjectId AND BugNet_IssuesView.Disabled = 0
AND 
	IssueMilestoneId IN (SELECT DISTINCT IssueMilestoneId FROM BugNet_IssuesView WHERE BugNet_IssuesView.Disabled = 0 AND IssueStatusId IN(SELECT StatusId FROM BugNet_ProjectStatus WHERE IsClosedState = 0 AND ProjectId = @ProjectId))
ORDER BY 
	(CASE WHEN PM.SortOrder IS NULL THEN 1 ELSE 0 END),PM.SortOrder , IssueStatusId ASC, IssueTypeId ASC,IssueCategoryId ASC, AssignedUserName ASC' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssueById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueById] 
  @IssueId Int
AS
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	IssueId = @IssueId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByRelevancy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByRelevancy] 
	@ProjectId int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @Username
	
SELECT 
	*
FROM
	BugNet_IssuesView 
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND (IssueCreatorUserId = @UserId OR IssueAssignedUserId = @UserId OR IssueOwnerUserId = @UserId)
ORDER BY
	IssueId Desc
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByProjectId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByProjectId]
	@ProjectId int
As
SELECT * FROM BugNet_IssuesView 
WHERE 
	ProjectId = @ProjectId
	AND Disabled = 0
Order By IssuePriorityId, IssueStatusId ASC

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByOwnerUserName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByOwnerUserName] 
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @Username
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueOwnerUserId = @UserId
ORDER BY
	IssueId Desc
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByCreatorUserName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByCreatorUserName] 
  @ProjectId Int,
  @UserName NVarChar(255)
AS
DECLARE @CreatorId UniqueIdentifier
SELECT @CreatorId = UserId FROM aspnet_Users WHERE Username = @Username
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueCreatorUserId = @CreatorId
ORDER BY
	IssueId Desc
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issue_GetIssuesByAssignedUserName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssuesByAssignedUserName]
	@ProjectId Int,
	@UserName NVarChar(255)
AS
DECLARE @UserId UniqueIdentifier
SELECT @UserId = UserId FROM aspnet_Users WHERE Username = @Username
	
SELECT 
	*
FROM 
	BugNet_IssuesView
WHERE
	ProjectId = @ProjectId
	AND Disabled = 0
	AND IssueAssignedUserId = @UserId
ORDER BY
	IssueId Desc

' 
END
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_IssueAttachments_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_IssueAttachments_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_IssueAttachments] ADD  CONSTRAINT [DF_BugNet_IssueAttachments_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_IssueComments_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_IssueComments_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_IssueComments] ADD  CONSTRAINT [DF_BugNet_IssueComments_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_IssueHistory_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_IssueHistory_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_IssueHistory] ADD  CONSTRAINT [DF_BugNet_IssueHistory_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_DueDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_DueDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_DueDate]  DEFAULT ('1/1/1900 12:00:00 AM') FOR [IssueDueDate]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_Estimation]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_Estimation]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_Estimation]  DEFAULT ((0)) FOR [IssueEstimation]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_IssueProgress]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_IssueProgress]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_IssueProgress]  DEFAULT ((0)) FOR [IssueProgress]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Issues_Disabled]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Issues_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Issues] ADD  CONSTRAINT [DF_BugNet_Issues_Disabled]  DEFAULT ((0)) FOR [Disabled]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_ProjectCategories_ParentCategoryId]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_ProjectCategories_ParentCategoryId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_ProjectCategories] ADD  CONSTRAINT [DF_BugNet_ProjectCategories_ParentCategoryId]  DEFAULT ((0)) FOR [ParentCategoryId]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelections]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldSelections] ADD  CONSTRAINT [DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder]  DEFAULT ((0)) FOR [CustomFieldSelectionSortOrder]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_ProjectMilestones_CreateDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_ProjectMilestones_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_ProjectMilestones] ADD  CONSTRAINT [DF_BugNet_ProjectMilestones_CreateDate]  DEFAULT (getdate()) FOR [DateCreated]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Projects_DateCreated]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Projects_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Projects] ADD  CONSTRAINT [DF_BugNet_Projects_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Projects_Active]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Projects_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Projects] ADD  CONSTRAINT [DF_BugNet_Projects_Active]  DEFAULT ((0)) FOR [ProjectDisabled]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Projects_AllowAttachments]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Projects_AllowAttachments]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Projects] ADD  CONSTRAINT [DF_BugNet_Projects_AllowAttachments]  DEFAULT ((1)) FOR [AllowAttachments]
END


End
GO
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_BugNet_Queries_IsPublic]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_BugNet_Queries_IsPublic]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BugNet_Queries] ADD  CONSTRAINT [DF_BugNet_Queries_IsPublic]  DEFAULT ((0)) FOR [IsPublic]
END


End
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueAttachments_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]'))
ALTER TABLE [dbo].[BugNet_IssueAttachments]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueAttachments_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueAttachments_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]'))
ALTER TABLE [dbo].[BugNet_IssueAttachments] CHECK CONSTRAINT [FK_BugNet_IssueAttachments_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueAttachments_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]'))
ALTER TABLE [dbo].[BugNet_IssueAttachments]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueAttachments_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueAttachments_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]'))
ALTER TABLE [dbo].[BugNet_IssueAttachments] CHECK CONSTRAINT [FK_BugNet_IssueAttachments_BugNet_Issues]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueComments_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]'))
ALTER TABLE [dbo].[BugNet_IssueComments]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueComments_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueComments_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]'))
ALTER TABLE [dbo].[BugNet_IssueComments] CHECK CONSTRAINT [FK_BugNet_IssueComments_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueComments_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]'))
ALTER TABLE [dbo].[BugNet_IssueComments]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueComments_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueComments_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]'))
ALTER TABLE [dbo].[BugNet_IssueComments] CHECK CONSTRAINT [FK_BugNet_IssueComments_BugNet_Issues]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueHistory_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]'))
ALTER TABLE [dbo].[BugNet_IssueHistory]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueHistory_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueHistory_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]'))
ALTER TABLE [dbo].[BugNet_IssueHistory] CHECK CONSTRAINT [FK_BugNet_IssueHistory_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueHistory_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]'))
ALTER TABLE [dbo].[BugNet_IssueHistory]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueHistory_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueHistory_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]'))
ALTER TABLE [dbo].[BugNet_IssueHistory] CHECK CONSTRAINT [FK_BugNet_IssueHistory_BugNet_Issues]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueNotifications_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotifications]'))
ALTER TABLE [dbo].[BugNet_IssueNotifications]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueNotifications_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueNotifications_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotifications]'))
ALTER TABLE [dbo].[BugNet_IssueNotifications] CHECK CONSTRAINT [FK_BugNet_IssueNotifications_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueNotifications_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotifications]'))
ALTER TABLE [dbo].[BugNet_IssueNotifications]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueNotifications_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueNotifications_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueNotifications]'))
ALTER TABLE [dbo].[BugNet_IssueNotifications] CHECK CONSTRAINT [FK_BugNet_IssueNotifications_BugNet_Issues]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueRevisions_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevisions]'))
ALTER TABLE [dbo].[BugNet_IssueRevisions]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueRevisions_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueRevisions_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueRevisions]'))
ALTER TABLE [dbo].[BugNet_IssueRevisions] CHECK CONSTRAINT [FK_BugNet_IssueRevisions_BugNet_Issues]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_aspnet_Users] FOREIGN KEY([IssueAssignedUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_aspnet_Users1] FOREIGN KEY([IssueOwnerUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_aspnet_Users1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users2]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_aspnet_Users2] FOREIGN KEY([LastUpdateUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users2]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_aspnet_Users2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users3]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_aspnet_Users3] FOREIGN KEY([IssueCreatorUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_aspnet_Users3]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_aspnet_Users3]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectCategories]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectCategories] FOREIGN KEY([IssueCategoryId])
REFERENCES [dbo].[BugNet_ProjectCategories] ([CategoryId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectCategories]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectCategories]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectIssueTypes]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectIssueTypes] FOREIGN KEY([IssueTypeId])
REFERENCES [dbo].[BugNet_ProjectIssueTypes] ([IssueTypeId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectIssueTypes]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectIssueTypes]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectMilestones]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones] FOREIGN KEY([IssueMilestoneId])
REFERENCES [dbo].[BugNet_ProjectMilestones] ([MilestoneId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectMilestones]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectMilestones1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones1] FOREIGN KEY([IssueAffectedMilestoneId])
REFERENCES [dbo].[BugNet_ProjectMilestones] ([MilestoneId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectMilestones1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectPriorities]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectPriorities] FOREIGN KEY([IssuePriorityId])
REFERENCES [dbo].[BugNet_ProjectPriorities] ([PriorityId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectPriorities]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectPriorities]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectResolutions]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectResolutions] FOREIGN KEY([IssueResolutionId])
REFERENCES [dbo].[BugNet_ProjectResolutions] ([ResolutionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectResolutions]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectResolutions]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH NOCHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectStatus] FOREIGN KEY([IssueStatusId])
REFERENCES [dbo].[BugNet_ProjectStatus] ([StatusId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Issues_BugNet_ProjectStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]'))
ALTER TABLE [dbo].[BugNet_Issues] CHECK CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectStatus]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueWorkReports_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReports]'))
ALTER TABLE [dbo].[BugNet_IssueWorkReports]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueWorkReports_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueWorkReports_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReports]'))
ALTER TABLE [dbo].[BugNet_IssueWorkReports] CHECK CONSTRAINT [FK_BugNet_IssueWorkReports_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueWorkReports_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReports]'))
ALTER TABLE [dbo].[BugNet_IssueWorkReports]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueWorkReports_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_IssueWorkReports_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_IssueWorkReports]'))
ALTER TABLE [dbo].[BugNet_IssueWorkReports] CHECK CONSTRAINT [FK_BugNet_IssueWorkReports_BugNet_Issues]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCategories_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories]'))
ALTER TABLE [dbo].[BugNet_ProjectCategories]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCategories_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCategories_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCategories]'))
ALTER TABLE [dbo].[BugNet_ProjectCategories] CHECK CONSTRAINT [FK_BugNet_ProjectCategories_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFields]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFields]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType] FOREIGN KEY([CustomFieldTypeId])
REFERENCES [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFields]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFields] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFields_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFields]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFields]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFields_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFields]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFields] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelections]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldSelections]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields] FOREIGN KEY([CustomFieldId])
REFERENCES [dbo].[BugNet_ProjectCustomFields] ([CustomFieldId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldSelections]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldSelections] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldValues_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldValues]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldValues_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldValues]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_Issues]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldValues]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields] FOREIGN KEY([CustomFieldId])
REFERENCES [dbo].[BugNet_ProjectCustomFields] ([CustomFieldId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectCustomFieldValues]'))
ALTER TABLE [dbo].[BugNet_ProjectCustomFieldValues] CHECK CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectIssueTypes_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes]'))
ALTER TABLE [dbo].[BugNet_ProjectIssueTypes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectIssueTypes_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectIssueTypes_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectIssueTypes]'))
ALTER TABLE [dbo].[BugNet_ProjectIssueTypes] CHECK CONSTRAINT [FK_BugNet_ProjectIssueTypes_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectMailBoxes_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMailBoxes]'))
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes]  WITH NOCHECK ADD  CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectMailBoxes_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMailBoxes]'))
ALTER TABLE [dbo].[BugNet_ProjectMailBoxes] CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectMilestones_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones]'))
ALTER TABLE [dbo].[BugNet_ProjectMilestones]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectMilestones_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectMilestones_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectMilestones]'))
ALTER TABLE [dbo].[BugNet_ProjectMilestones] CHECK CONSTRAINT [FK_BugNet_ProjectMilestones_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectNotifications_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotifications]'))
ALTER TABLE [dbo].[BugNet_ProjectNotifications]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectNotifications_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectNotifications_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotifications]'))
ALTER TABLE [dbo].[BugNet_ProjectNotifications] CHECK CONSTRAINT [FK_BugNet_ProjectNotifications_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectNotifications_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotifications]'))
ALTER TABLE [dbo].[BugNet_ProjectNotifications]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectNotifications_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectNotifications_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectNotifications]'))
ALTER TABLE [dbo].[BugNet_ProjectNotifications] CHECK CONSTRAINT [FK_BugNet_ProjectNotifications_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectPriorities_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities]'))
ALTER TABLE [dbo].[BugNet_ProjectPriorities]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectPriorities_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectPriorities_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectPriorities]'))
ALTER TABLE [dbo].[BugNet_ProjectPriorities] CHECK CONSTRAINT [FK_BugNet_ProjectPriorities_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectResolutions_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions]'))
ALTER TABLE [dbo].[BugNet_ProjectResolutions]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectResolutions_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectResolutions_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectResolutions]'))
ALTER TABLE [dbo].[BugNet_ProjectResolutions] CHECK CONSTRAINT [FK_BugNet_ProjectResolutions_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Projects_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
ALTER TABLE [dbo].[BugNet_Projects]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Projects_aspnet_Users] FOREIGN KEY([ProjectCreatorUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Projects_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
ALTER TABLE [dbo].[BugNet_Projects] CHECK CONSTRAINT [FK_BugNet_Projects_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Projects_aspnet_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
ALTER TABLE [dbo].[BugNet_Projects]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Projects_aspnet_Users1] FOREIGN KEY([ProjectManagerUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Projects_aspnet_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Projects]'))
ALTER TABLE [dbo].[BugNet_Projects] CHECK CONSTRAINT [FK_BugNet_Projects_aspnet_Users1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectStatus_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus]'))
ALTER TABLE [dbo].[BugNet_ProjectStatus]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectStatus_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_ProjectStatus_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_ProjectStatus]'))
ALTER TABLE [dbo].[BugNet_ProjectStatus] CHECK CONSTRAINT [FK_BugNet_ProjectStatus_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Queries_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]'))
ALTER TABLE [dbo].[BugNet_Queries]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Queries_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Queries_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]'))
ALTER TABLE [dbo].[BugNet_Queries] CHECK CONSTRAINT [FK_BugNet_Queries_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Queries_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]'))
ALTER TABLE [dbo].[BugNet_Queries]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Queries_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Queries_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Queries]'))
ALTER TABLE [dbo].[BugNet_Queries] CHECK CONSTRAINT [FK_BugNet_Queries_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_QueryClauses_BugNet_Queries]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_QueryClauses]'))
ALTER TABLE [dbo].[BugNet_QueryClauses]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_QueryClauses_BugNet_Queries] FOREIGN KEY([QueryId])
REFERENCES [dbo].[BugNet_Queries] ([QueryId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_QueryClauses_BugNet_Queries]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_QueryClauses]'))
ALTER TABLE [dbo].[BugNet_QueryClauses] CHECK CONSTRAINT [FK_BugNet_QueryClauses_BugNet_Queries]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RelatedIssues_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]'))
ALTER TABLE [dbo].[BugNet_RelatedIssues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues] FOREIGN KEY([PrimaryIssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RelatedIssues_BugNet_Issues]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]'))
ALTER TABLE [dbo].[BugNet_RelatedIssues] CHECK CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RelatedIssues_BugNet_Issues1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]'))
ALTER TABLE [dbo].[BugNet_RelatedIssues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues1] FOREIGN KEY([SecondaryIssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RelatedIssues_BugNet_Issues1]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]'))
ALTER TABLE [dbo].[BugNet_RelatedIssues] CHECK CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RolePermissions_BugNet_Permissions]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RolePermissions]'))
ALTER TABLE [dbo].[BugNet_RolePermissions]  WITH NOCHECK ADD  CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Permissions] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[BugNet_Permissions] ([PermissionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RolePermissions_BugNet_Permissions]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RolePermissions]'))
ALTER TABLE [dbo].[BugNet_RolePermissions] CHECK CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Permissions]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RolePermissions_BugNet_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RolePermissions]'))
ALTER TABLE [dbo].[BugNet_RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[BugNet_Roles] ([RoleId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_RolePermissions_BugNet_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_RolePermissions]'))
ALTER TABLE [dbo].[BugNet_RolePermissions] CHECK CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Roles]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Roles_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Roles]'))
ALTER TABLE [dbo].[BugNet_Roles]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_Roles_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_Roles_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_Roles]'))
ALTER TABLE [dbo].[BugNet_Roles] CHECK CONSTRAINT [FK_BugNet_Roles_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserProjects_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserProjects]'))
ALTER TABLE [dbo].[BugNet_UserProjects]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserProjects_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserProjects_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserProjects]'))
ALTER TABLE [dbo].[BugNet_UserProjects] CHECK CONSTRAINT [FK_BugNet_UserProjects_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserProjects_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserProjects]'))
ALTER TABLE [dbo].[BugNet_UserProjects]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserProjects_BugNet_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[BugNet_Projects] ([ProjectId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserProjects_BugNet_Projects]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserProjects]'))
ALTER TABLE [dbo].[BugNet_UserProjects] CHECK CONSTRAINT [FK_BugNet_UserProjects_BugNet_Projects]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserRoles_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserRoles]'))
ALTER TABLE [dbo].[BugNet_UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserRoles_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserRoles_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserRoles]'))
ALTER TABLE [dbo].[BugNet_UserRoles] CHECK CONSTRAINT [FK_BugNet_UserRoles_aspnet_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserRoles_BugNet_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserRoles]'))
ALTER TABLE [dbo].[BugNet_UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserRoles_BugNet_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[BugNet_Roles] ([RoleId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNet_UserRoles_BugNet_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNet_UserRoles]'))
ALTER TABLE [dbo].[BugNet_UserRoles] CHECK CONSTRAINT [FK_BugNet_UserRoles_BugNet_Roles]
GO

/*end 0.7 -> 0.8 upgade */

INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(1, N'CLOSE_ISSUE', N'Close Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(2, N'ADD_ISSUE', N'Add Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(3, N'ASSIGN_ISSUE', N'Assign Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(4, N'EDIT_ISSUE', N'Edit Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(5, N'SUBSCRIBE_ISSUE', N'Subscribe Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(6, N'DELETE_ISSUE', N'Delete Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(7, N'ADD_COMMENT', N'Add Comment')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(8, N'EDIT_COMMENT', N'Edit Comment')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(9, N'DELETE_COMMENT', N'Delete Comment')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(10, N'ADD_ATTACHMENT', N'Add Attachment')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(11, N'DELETE_ATTACHMENT', N'Delete Attachment')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(12, N'ADD_RELATED', N'Add Related Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(13, N'DELETE_RELATED', N'Delete Related Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(14, N'REOPEN_ISSUE', N'Re-Open Issue')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(15, N'OWNER_EDIT_COMMENT', N'Edit Own Comments')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(16, N'EDIT_ISSUE_DESCRIPTION', N'Edit Issue Description')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(17, N'EDIT_ISSUE_TITLE', N'Edit Issue Title')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(18, N'ADMIN_EDIT_PROJECT', N'Admin Edit Project')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(19, N'ADD_TIME_ENTRY', N'Add Time Entry')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(20, N'DELETE_TIME_ENTRY', N'Delete Time Entry')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(21, N'ADMIN_CREATE_PROJECT', N'Admin Create Project')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(22, N'ADD_QUERY', N'Add Query')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(23, N'DELETE_QUERY', N'Delete Query')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(24, N'ADMIN_CLONE_PROJECT', N'Clone Project')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(25, N'ADD_SUB_ISSUE', N'Add Sub Issues')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(26, N'DELETE_SUB_ISSUE', N'Delete Sub Issues')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(27, N'ADD_PARENT_ISSUE', N'Add Parent Issues')
INSERT INTO [dbo].[BugNet_Permissions] ([PermissionId], [PermissionKey], [PermissionName]) VALUES(28, N'DELETE_PARENT_ISSUE', N'Delete Parent Issues')

-- Custom Field Types 
INSERT INTO [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeName]) VALUES (N'Text')
INSERT INTO [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeName]) VALUES (N'Drop Down List')
INSERT INTO [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeName]) VALUES (N'Date')
INSERT INTO [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeName]) VALUES (N'Rich Text')
INSERT INTO [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeName]) VALUES (N'Yes / No')
INSERT INTO [dbo].[BugNet_ProjectCustomFieldTypes] ([CustomFieldTypeName]) VALUES (N'User List')

-- Required Field List
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(1, N'-- Select Field --', N'0')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(2, N'Issue Id', N'IssueId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(3, N'Title', N'IssueTitle')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(4, N'Type', N'IssueTypeId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(5, N'Category', N'IssueCategoryId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(6, N'Priority', N'IssuePriorityId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(7, N'Milestone', N'IssueMilestoneId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(8, N'Status', N'IssueStatusId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(9, N'Assigned', N'IssueAssignedUserId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(10, N'Owner', N'IssueOwnerUserId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(11, N'Creator', N'IssueCreatorUserId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(12, N'Date Created', N'DateCreated')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(13, N'Last Update', N'LastUpdate')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(14, N'Resolution', N'IssueResolutionId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(15, N'Affected Milestone', N'IssueAffectedMilestoneId')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(16, N'Due Date', N'IssueDueDate')
INSERT INTO [dbo].[BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES(17, N'Custom Fields', N'CustomFieldName')

-- String Resources
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Admin.aspx', N'en', N'Administration', N'Administration')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Admin.aspx', N'en', N'ApplicationConfiguration', N'Application Configuration')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Admin.aspx', N'en', N'LogViewer', N'Log Viewer')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Admin.aspx', N'en', N'Projects', N'Projects')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Admin.aspx', N'en', N'UserAccounts', N'User Accounts')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'Debug', N'Debug')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'Error', N'Error')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'FilterBy', N'Filter by:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'Info', N'Info')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'Level', N'Level')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'Logger', N'Logger')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'LogViewer', N'Log Viewer')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'Message', N'Message')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'NoEntries', N'There are no log entries.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'SelectLevel', N'-- Select One -- ')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'User', N'User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/LogViewer.aspx', N'en', N'Warning', N'Warning')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'ApplicationConfiguration', N'Application Configuration')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'Attachments', N'Attachments')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'Authentication', N'Authentication')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'Basic', N'Basic')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'Logging', N'Logging')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'Mail', N'Mail / SMTP')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'Notifications', N'Notifications')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'Subversion', N'Subversion')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/Settings.aspx', N'en', N'UpdateSettings', N'Update Settings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AttachmentSettings.ascx', N'en', N'AllowedFileExtentions', N'Allowed File Extensions')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AttachmentSettings.ascx', N'en', N'AttachmentSettings', N'AttachmentSettings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AttachmentSettings.ascx', N'en', N'FileSizeLimit', N'File Size Limit')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AuthenticationSettings.ascx', N'en', N'AuthenticationSettings', N'AuthenticationSettings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AuthenticationSettings.ascx', N'en', N'ConfirmPassword', N'Confirm Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AuthenticationSettings.ascx', N'en', N'DisableAnonymousAccess', N'Disable Anonymous Access')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AuthenticationSettings.ascx', N'en', N'DisableUserRegistration', N'Disable User Registration')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AuthenticationSettings.ascx', N'en', N'DomainPath', N'Domain / Path')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AuthenticationSettings.ascx', N'en', N'OpenIdAuthentication', N'Open Id Authentication')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AuthenticationSettings.ascx', N'en', N'PasswordsMustMatch', N'Passwords must match')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/AuthenticationSettings.ascx', N'en', N'UserAccountSource', N'User Account Source')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/BasicSettings.ascx', N'en', N'BasicSettings', N'Basic Settings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/BasicSettings.ascx', N'en ', N'DefaultUrl', N'Default Url')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/BasicSettings.ascx', N'en', N'Title', N'Title')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/BasicSettings.ascx', N'en', N'WelcomeMessage', N'Welcome Message')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/BasicSettings.ascx', N'en', N'WelcomeMessageLength', N'Please enter a welcome message that is less than 500 characters.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/LoggingSettings.ascx', N'en', N'EmailErrorMessages', N'Email Error Messages')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/LoggingSettings.ascx', N'en', N'FromAddress', N'From Address')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/LoggingSettings.ascx', N'en', N'LoggingSettings', N'Logging Settings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/MailSettings.ascx', N'en', N'EnableAuthentication', N'Enable Authentication')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/MailSettings.ascx', N'en', N'HostEmail', N'Host Email')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/MailSettings.ascx', N'en', N'MailSettings', N'Mail / SMTP Server Settings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/MailSettings.ascx', N'en', N'Port', N'Port')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/MailSettings.ascx', N'en', N'Server', N'Server')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/NotificationSettings.ascx', N'en', N'AdminNotificationUser', N'Admin Notification User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/NotificationSettings.ascx', N'en', N'EnableNotificationTypes', N'Enable Notification Types')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/NotificationSettings.ascx', N'en', N'NotificationSettings', N'Notification Settings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/SubversionSettings.ascx', N'en', N'AdministratorEmail', N'Administrator Email')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/SubversionSettings.ascx', N'en', N'BackupFolder', N'Backup Folder')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/SubversionSettings.ascx', N'en', N'EnableAdministration', N'Enable Administration')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/SubversionSettings.ascx', N'en', N'HooksExecutableFile', N'Hooks Executable File')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/SubversionSettings.ascx', N'en', N'RootFolder', N'Root Folder')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/SubversionSettings.ascx', N'en', N'ServerRootUrl', N'Server Root Url')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Host/UserControls/SubversionSettings.ascx', N'en', N'SubversionSettings', N'Subversion Settings')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/AddProject.aspx', N'en', N'Back', N'Back')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/AddProject.aspx', N'en', N'NewProjectTitle.Text', N'New Project Wizard')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/AddProject.aspx', N'en', N'Next', N'Next')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/AddProject.aspx', N'en', N'Of', N'of')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/AddProject.aspx', N'en', N'Page.Title', N'New Project')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/AddProject.aspx', N'en', N'Step', N'Step')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/CloneProject.aspx', N'en', N'DescriptionLabel.Text', N'When you clone a project, you make a copy of the project. For example, you make a copy of all of the project''s categories, milestones, and custom fields. However, when you clone a project, issues are not copied to the new project.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/CloneProject.aspx', N'en', N'ExistingProjectNameLabel.Text', N'Existing Project Name')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/CloneProject.aspx', N'en', N'NewProjectNameLabel.Text', N'New Project Name')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Categories', N'Categories')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'ConfirmDelete', N'Are you sure you want to delete the \"{0}\" project?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'CustomFields', N'Custom Fields')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'DeleteProject', N'Delete Project')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Details', N'Details')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'EditProjectTitle.Text', N'Project Administration')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'IssueTypes', N'Issue Types')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Mailboxes', N'Mailboxes')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Members', N'Members')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Milestones', N'Milestones')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Notifications', N'Notifications')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Page.Title', N'Project Administration')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Priorities', N'Priorities')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'ProjectUpdated', N'Project has been updated successfully.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Resolutions', N'Resolutions')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'SecurityRoles', N'Security Roles')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Status', N'Status')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/EditProject.aspx', N'en', N'Subversion', N'Subversion')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/ProjectList.aspx', N'en', N'CreatedBy', N'Created By')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/ProjectList.aspx', N'en', N'Disabled', N'Disabled')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/ProjectList.aspx', N'en', N'Page.Title', N'Project List')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/ProjectList.aspx', N'en', N'Project', N'Project')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/ProjectList.aspx', N'en', N'ProjectListTitle.Text', N'Projects')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/ProjectList.aspx', N'en', N'ProjectManager', N'Project Manager')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/NewProjectIntro.ascx', N'en', N'DescriptionLabel.Text', N'The New Project Wizard enables you to create a new project for managing issues. This Wizard will guide you through the steps for creating the new project.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/NewProjectIntro.ascx', N'en', N'IntroTitle.Text', N'Introduction')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/NewProjectIntro.ascx', N'en', N'SkipIntro', N'Skip Next Time')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/NewProjectSummary.ascx', N'en', N'DescriptionLabel.Text', N'Your new project has been created! Click <strong>Finish</strong> to return to the Project Management page.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/NewProjectSummary.ascx', N'en', N'Summary', N'Summary')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCategories.ascx', N'en', N'CannotDeleteRootCategory', N'You cannot delete the root category')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCategories.ascx', N'en', N'CategoriesTitle.Text', N'Categories')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCategories.ascx', N'en', N'CategoryValidator.ErrorMessage', N'You must add at least one category')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCategories.ascx', N'en', N'DescriptionLabel.Text', N'When you create an issue, you assign the issue a category. Add categories by clicking the add category button and entering the name of the category. You can add sub-categories by selecting a parent category from the tree view below then entering the child category in the textbox and clicking the add button. To delete a category select the category then click the delete button.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCategories.ascx', N'en', N'NewCategoryNotEntered', N'You must enter a new category to assign the issues to')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCategories.ascx', N'en', N'NoCategorySelected', N'You must select a category to reassign the issues to.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCategories.ascx', N'en', N'SameCategorySelected', N'You can not reassign the issues to the same category')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'AddNew', N'Add New Custom Field')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'ConfirmCustomFieldSelectionDelete', N'Are you sure you want to delete the \"{0}\" selection?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'ConfirmDelete', N'Are you sure you want to delete the \"{0}\" field?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'CustomFieldsTitle.Text', N'Custom Fields')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'DataType', N'Data Type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'DescriptionLabel.Text', N'You can add one or more custom fields to a project. You can assign a data type to each custom field. In addtion, each custom field can be marked as either required or optional.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'Field', N'Field')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'FieldName', N'Field Name')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'FieldType', N'Field Type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'Required', N'Required')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'SelectionValuesLabel.Text', N'Selection Values')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectCustomFields.ascx', N'en', N'Value', N'Value')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'AccessTypeLabel.Text', N'Access Type:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'AttachmentStorageTypeLabel.Text', N'Storage Type:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'Description.Text', N'Description:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'EnableAttachmentsLabel.Text', N'Allow Attachments:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'ProjectCodeLabel.Text', N'Project Code:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'ProjectCodeValidator.ErrorMessage', N'Project Code is required')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'ProjectDescription.Text', N'Enter the details for the project.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'ProjectDescriptionValidator.ErrorMessage', N'Description is required')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'ProjectManagerLabel.Text', N'Manager:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'ProjectManagerValidator.ErrorMessage', N'Project Manager is required')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'ProjectName.Text', N'Project Name:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'ProjectNameRequiredFieldValidator.ErrorMessage', N'Project Name is required')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'SelectUser', N'-- Select User --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectDescription.ascx', N'en', N'UploadPath.Text', N'Upload Path:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectIssueTypes.ascx', N'en', N'AddIssueTypeButton.Text', N'Add Issue Type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectIssueTypes.ascx', N'en', N'AddNewIssueTypeLabel.Text', N'Add New Issue Type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectIssueTypes.ascx', N'en', N'ConfirmDelete', N'Are you sure you want to delete the \"{0}\" issue type?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectIssueTypes.ascx', N'en', N'DescriptionLabel.Text', N'When you create an issue, you assign the issue a type such as Bug or Task. Enter the list of status values below. Each type can be associated with an image.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectIssueTypes.ascx', N'en', N'IssueTypesTitle.Text', N'Issue Types')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectIssueTypes.ascx', N'en', N'IssueTypeValidator.Text', N'You must add at least one issue type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'AllRolesLabel.Text', N'All Roles')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'AllUsersLabel.Text', N'All Users')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'AssignedRolesLabel.Text', N'Assigned Roles')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'AssignUsersDescription.Text', N'Assign users to a role by selecting the user in the list and clicking the right arrow to add a role. This role assignment is applicable for this project only.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'AssignUserTitle.Text', N'Assign User to Roles')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'DescriptionLabel.Text', N'Add users to the project by selecting the user then clicking the right arrow button.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'ProjectMembersTitle.Text', N'Project Members')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'SelectedUsersLabel.Text', N'Selected Users')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMembers.ascx', N'en', N'SelectUser', N'-- Select User --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMilestones.ascx', N'en', N'AddMilestoneButton.Text', N'Add Milestone')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMilestones.ascx', N'en', N'AddNewMilestoneLabel.Text', N'Add New Milestone')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMilestones.ascx', N'en', N'ConfirmDelete', N'Are you sure you want to delete the \"{0}\" Milestone?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMilestones.ascx', N'en', N'DescriptionLabel.Text', N'When creating an issue, you assign the issue a version or milestone such as First, Second, or Third. Enter the list of Milestones below.  ')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMilestones.ascx', N'en', N'MilestonesTitle.Text', N'Milestones')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectMilestones.ascx', N'en', N'MilestoneValidator.Text', N'You must add at least one milestone')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectNotifications.ascx', N'en', N'AllUsers', N'All Users')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectNotifications.ascx', N'en', N'DescriptionLabel.Text', N'You can add project members that should receive notifications for the entire project.  This includes new comments and updated issues.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectNotifications.ascx', N'en', N'NotificationsTitle.Text', N'Notifications')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectNotifications.ascx', N'en', N'SelectedUsers', N'Selected Users')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectPriorities.ascx', N'en', N'AddNewPriorityLabel.Text', N'Add New Priority')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectPriorities.ascx', N'en', N'AddPriorityButton.Text', N'Add Priority')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectPriorities.ascx', N'en', N'ConfirmDelete', N'Are you sure you want to delete the \"{0}\" priority?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectPriorities.ascx', N'en', N'DescriptionLabel.Text', N'When you create an issue, you assign the issue a priority such as High, Normal, or Low. Enter the list of priorities below. Each priority can be associated with an image.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectPriorities.ascx', N'en', N'PrioritiesTitle.Text', N'Priorites')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectPriorities.ascx', N'en', N'PriorityValidator.Text', N'You must add at least one priority')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectResolutions.ascx', N'en', N'AddNewResolutionLabel.Text', N'Add New Resolution')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectResolutions.ascx', N'en', N'AddResolutionButton.Text', N'Add Resolution')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectResolutions.ascx', N'en', N'ConfirmDelete', N'Are you sure you want to delete the \"{0}\" Resolution?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectResolutions.ascx', N'en', N'DescriptionLabel.Text', N'When you complete an issue or task you can set how the issue was resolved such as fixed, duplicate or not valid.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectResolutions.ascx', N'en', N'ResolutionsTitle.Text', N'Resolutions')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'AddLabel.Text', N'Add')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'AddNewRole.AlternateText', N'Add New Role')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'AddNewRole.Text', N'Add New Role')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'AddRoleButton.Text', N'Add Role')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'AssignIssue', N'Assign Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'Attachments', N'Attachments')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'AutoAssignment.Text', N'Auto Assignment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'AutoAssignmentColumnHeader.HeaderText', N'Auto Assignment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'CloseIssue', N'Close Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'Comments', N'Comments')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'ConfirmDelete', N'Are you sure you want to delete the \"{0}\" role?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'DeleteLabel.Text', N'Delete')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'DeleteRoleButton.Text', N'Delete Role')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'DescriptionLabel.Text', N'Each project can have its own roles to group like users and permissions.  By default when a new project is created several roles are predefined for you.  If you need to create a custom role click the add new role button then assign permissions to the role.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'EditLabel.Text', N'Edit')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'Issue', N'Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'IssueDescription', N'Issue Description')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'IssueTitle', N'Issue Title')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'NewRoleDescription.Text', N'To create a new role enter the name, description and check the required permssions then click save.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'OtherLabel.Text', N'Other')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'OwnComments', N'Own Comments')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'ParentIssue', N'Parent Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'PermissionsTitle.Text', N'Permissions')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'Query', N'Query')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'RelatedIssue', N'Related Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'RoleName.Text', N'Role Name')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'RoleNameTitle.Text', N'Manage Security Role -')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'RolesTitle.Text', N'Manager Security Roles')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'SubIssue', N'Sub Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'SubscribeIssue', N'Subscribe Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'TimeEntry', N'Time Entry')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectRoles.ascx', N'en', N'UpdateRole', N'Update Role')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectStatus.ascx', N'en', N'AddNewStatusLabel.Text', N'Add New Status')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectStatus.ascx', N'en', N'AddStatusButton.Text', N'Add Status')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectStatus.ascx', N'en', N'ConfirmDelete', N'Are you sure you want to delete the \"{0}\" status?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectStatus.ascx', N'en', N'DescriptionLabel.Text', N'When you create an issue, you assign the issue a status such as In Progress or Completed. Enter the list of status values below. Each status can be associated with an image. ')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectStatus.ascx', N'en', N'IsClosedState.Text', N'Is Closed State')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectStatus.ascx', N'en', N'StatusValidator.Text', N'You must add at least one status')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'CommentLabel.Text', N'Comment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'CreateRepositoryButton.Text', N'Create Repository')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'CreateTagButton.Text', N'Create Tag')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'DescriptionLabel.Text', N'Enter the information about the subversion repository')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'NewRepositoryDescription.Text', N'After the creation is finished the projects subversion url will be updated to the url of the new repository.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'NewRepositoryTitle.Text', N'Create a New Subversion Repository')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'RepositoryCreationDisabled', N'Creation of repositories is disabled.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'SubversionTitle.Text', N'Subversion')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'SVNCommandsTitle.Text', N'Subversion Commands Output')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Projects/UserControls/ProjectSubversion.ascx', N'en', N'SVNInfoLabel.Text', N'Create a tag of the trunk. This assumes that the root contains both a trunk and a tags directory. Your username and password are used for the single command only and never stored.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'ActiveUser', N'ActiveUser')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'AddNewUser', N'Add New User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'AddUser', N'Add User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'BackToUserList', N'Back to user list')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'ConfirmPassword', N'Confirm Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'ConfirmPasswordError', N'The password specified is invalid. Please specify a valid password. Passwords must be at least 7 characters in length and contain at least 0 non-alphanumeric characters.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'DescriptionLabel.Text', N'Please enter the details for the new user.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'Page.Title', N'Add User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'PasswordDescription', N'Optionally enter a password for this user, or allow the system to generate a random password.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'RandomPassword', N'Random Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'SecretAnswer', N'Secret Answer')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'SecurityQuestion', N'Security Question')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'UserCreated', N'User has been successfully created.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/AddUser.aspx', N'en', N'UserCreatedError', N'Failed to create new user. Error message: ')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/ManageUser.aspx', N'en', N'AddNewUser', N'Add New User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/ManageUser.aspx', N'en', N'DeleteUser', N'Delete User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/ManageUser.aspx', N'en', N'ManagePassword', N'Manage Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/ManageUser.aspx', N'en', N'ManageProfile', N'Manage Profile')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/ManageUser.aspx', N'en', N'ManageRoles', N'Manage Roles For This User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/ManageUser.aspx', N'en', N'ManageUserDetails', N'Manage User Details')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'AuthorizeUser', N'Authorize User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'CreatedDate', N'Created Date')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'LastActivityDate', N'Last Activity Date')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'LastLoginDate', N'Last Login Date')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'LockedOut', N'Locked Out')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'UnAuthorizeUser', N'Unauthorize User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'UnlockUser', N'Unlock User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'UpdateUserMessage', N'The user has been updated successfully.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'UserAuthorizedMessage', N'The user has been authorized successfully.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'UserDetails', N'Manage User Details')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'UserIsOnline', N'User Is Online')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Membership.ascx', N'en', N'UserUnAuthorizedMessage', N'The user has been unauthorized successfully.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'ChangePassword', N'Change Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'ConfirmPassword', N'Confirm Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'ManagePassword', N'Manage Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'NewPassword', N'New Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'PasswordChangeSuccess', N'Password changed succesfully')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'PasswordLastChanged', N'Password Last Changed')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'PasswordsMustMatch', N'Passwords must match')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'ResetPassword', N'Reset Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Password.ascx', N'en', N'ResetPasswordDesc', N'You can reset the password for this user. The password will be randomly generated.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Profile.ascx', N'en', N'ManageProfile', N'Manage Profile')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Roles.ascx', N'en', N'ManageRoles', N'Manage Roles For This User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Roles.ascx', N'en', N'SuperUsers', N'Super Users')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserControls/Roles.ascx', N'en', N'UserRolesUpdateSuccess', N'The users roles have been updated successfully.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserList.aspx', N'en', N'Authorized', N'Authorized')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserList.aspx', N'en', N'CreateNewUser', N'Create new user')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserList.aspx', N'en', N'ManageRoles', N'Manage Roles')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserList.aspx', N'en', N'ManageUserAccounts', N'Manage User Accounts')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Administration/Users/UserList.aspx', N'en', N'NoUsersFound', N'No users found for the selected search criteria.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Add', N'Add')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'AffectedMilestone', N'Affected Milestone')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'AssgnedTo', N'Assigned To')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Assigned', N'Assigned')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Authorized', N'Authorized')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Cancel', N'Cancel')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Category', N'Category')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'ChangePassword', N'Change Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'CloneProject', N'Clone Project')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'ConfirmPassword', N'Confirm Password:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'ConfirmPasswordErrorMessage', N'The passsword and confirmation password must match.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Created', N'Created')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Creator', N'Creator')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Date', N'Date')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Delete', N'Delete')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Description', N'Description')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Disable', N'Disable')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'DisplayName', N'Display Name:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'DueDate', N'Due Date')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Edit', N'Edit')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Email', N'Email:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Enable', N'Enable')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Estimation', N'Estimation')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms ', N'en ', N'EstimationHours', N'Estimation (hrs)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'FirstName', N'First Name:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Id', N'Id')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Image', N'Image')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'IssueHeader', N'Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'IssueId', N'Issue Id:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'IssueType', N'Issue Type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'LastName', N'Last Name:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'LastUpdate', N'Last Update')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'LastUpdateUser', N'Last Update User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Milestone', N'Milestone')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Name', N'Name:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'No', N'No')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'NoIssueResults', N'There are no issues that match your criteria.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Of', N'of')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Order', N'Order')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Owner', N'Owner')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Page', N'Page')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Password', N'Password:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Priority', N'Priority')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Private', N'Private')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Progress', N'Progress')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Project', N'Project')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Required', N'(required)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Resolution', N'Resolution')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Return', N'Return')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Save', N'Save')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Search', N'Search')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Status', N'Status')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Submit', N'Submit')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'TimeLogged', N'Time Logged')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'TimeLoggedHours', N'Time Logged (hrs)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Title', N'Title')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Type', N'Type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Update', N'Update')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Username', N'Username:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'UsernameRequired.ErrorMessage', N'Username is required.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Votes', N'Votes')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'CommonTerms', N'en', N'Yes', N'Yes')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'AnonymousAccessDisabled', N'The administrator has disabled anonymous access, please register to view any projects.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'LoginControl.CreateUserText', N'Register')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'LoginControl.FailureText', N'Your login attempt was not successful. Please try again.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'LoginControl.LoginButtonText', N'Log in')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'LoginControl.PasswordRecoveryText', N'Forgot your password?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'LoginControl.RememberMeText', N'Remember me next time.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'LoginControl.Text', N'Log In')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'LoginControl.TitleText', N'Login')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'NoProjectsToViewMessage', N'There are no projects for you to view.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'Page.Title', N'Home')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'en', N'RegisterAndLoginMessage', N'You must register and login to view projects on this site.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Default.aspx', N'fr-FR', N'Page.Title', N'This is testing the localization features ')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'AddRoleError', N'Could not add role')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'CloneProjectError', N'Could not clone project')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'DeleteCustomFieldError', N'Could not delete custom field')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'DeleteIssueTypeError', N'Could not delete issue type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'DeleteMilestoneError', N'Could not delete milestone')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'DeletePriorityError', N'Could not delete priority')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'DeleteResolutionError', N'Could not delete resolution')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'DeleteRoleError', N'Could not delete role')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'DeleteStatusError', N'Could not delete status')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'InvalidFileName', N'The name of the file you have selected is invalid.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'InvalidFileType', N'{0} does not meet the allowed file types.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'InvalidRepositoryName', N'The repository name was not formated correctlly. Only alpha-numeric charaters, \"-\", and \"_\" are allowed.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'InvalidRepositoryTagName', N'The tag name was not formated correctlly. Only alpha-numeric charaters, \"-\", and \"_\" are allowed.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'RepositoryCommentRequired', N'A comment is required to create a tag')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'RepositoryProjectSaveError', N'Could not save project, please verify that the data is correct.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'SaveCustomFieldError', N'Could not save custom field')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'SaveIssueTypeError', N'Could not save issue type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'SaveMilestoneError', N'Could not save milestone')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'SavePriorityError', N'Could not save priority')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'SaveProjectError', N'Could not save project, please verify that the project name and code are unique values.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'SaveResolutionError', N'Could not save resolution')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'SaveStatusError', N'Could not save status')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en', N'UploadPathNotDefined', N'Project upload path has not been defined for project {0}.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ErrorMessages', N'en ', N'UploadPathNotFound', N'Upload directory {0} can not be found. Please check with the administrator that the directory exists on the web server.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors', N'en', N'PasswordChangeError', N'The password could not be changed, please verify that the password meets the password requirements.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors', N'en', N'ProfileUpdateError', N'There was an error updating the profile')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors', N'en', N'QueryStringError', N'The user querystring parameter is not properly formed')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors', N'en', N'UpdateUserError', N'There was an error updating this user.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors', N'en', N'UserAuthorizedError', N'There was an error authorizing this user.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors', N'en', N'UserUnAuthorizedError', N'There was an error unauthorizing this user.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors/AccessDenied.aspx', N'en', N'AccessDenied', N'Access Denied')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors/AccessDenied.aspx', N'en', N'Message', N'The resource you have requested is unavailable or you do not have the proper access rights.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors/AccessDenied.aspx', N'en', N'Message1', N'Please <a href="../Default.aspx">login</a> to obtain access this resource.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors/Error.aspx', N'en', N'ApplicationError', N'Application Error')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors/Error.aspx', N'en', N'Message', N'An error has occured in processing your request.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors/Error.aspx', N'en', N'Message1', N'Please <a href="{0}">try again.</a>')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors/SessionExpired.aspx', N'en', N'Message', N'Your session has expired.  Please <a href="../Default.aspx">return to the home page</a> and log in again to continue accessing your account.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Errors/SessionExpired.aspx', N'en', N'SessionExpired', N'Session Expired')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ForgotPassword.aspx', N'en', N'CapchaTest.ControlMessage', N'Enter the code you see:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ForgotPassword.aspx', N'en', N'CodeIncorrectError', N'The code you entered was incorrect.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ForgotPassword.aspx', N'en', N'EmailPasswordReminderError', N'An error occured sending the password reminder.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ForgotPassword.aspx', N'en', N'lblInstructions.Text', N'Enter your username to receive your password.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ForgotPassword.aspx', N'en', N'lblTitle.Text', N'Forgot Your Password?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ForgotPassword.aspx', N'en', N'Page.Title', N'Forgot Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ForgotPassword.aspx', N'en', N'PasswordReminderSuccess', N'Your password has been emailed to you successfully.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'ForgotPassword.aspx', N'en', N'UserNotFoundError', N'The user you entered was not found.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'btnAdd.Text', N'Create New Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'InLabel.Text', N'in')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'ListItem1.Text', N'Relevant to You')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'ListItem2.Text', N'Assigned to You')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'ListItem3.Text', N'Owned by You')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'ListItem4.Text', N'Created by You')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'ListItem5.Text', N'All Issues')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'Page.Title', N'Issue List')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'IssueList.aspx', N'en', N'ViewIssuesLabel.Text', N'View Issues')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'AffectedMilestoneLabel.Text', N'Affected Milestone:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'AssignedToLabel.Text', N'Assigned To:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'ByLabel.Text', N'by')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'CategoryLabel.Text', N'Category:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'DateCreatedLabel.Text', N'Created')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'DeleteIssue', N'Are you sure you want to delete this issue?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'DetailsLabel.Text', N'Details')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'DueDateLabel.Text', N'Due Date:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'EstimationLabel.Text', N'Estimation:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'HoursLabel.Text', N'hrs')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'IssueLabel.Text', N'Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'IssueTypeLabel.Text', N'Type:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'LastUpdateLabel.Text', N'Last Updated')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'LoggedLabel.Text', N'Logged:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'MilestoneLabel.Text', N'Milestone:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'OwnedByLabel.Text', N'Owned By:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'PageTitleNewIssue', N'New Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'PriorityLabel.Text', N'Priority:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'PrivateLabel.Text', N'Private:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'ResolutionLabel.Text', N'Resolution:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'SaveReturn.Text', N'Save &amp; Return')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'StatusLabel.Text', N'Status:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'TimeLabel.Text', N'Time')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/IssueDetail.aspx', N'en', N'TitleLabel.Text', N'Title:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Attachments.ascx', N'en', N'AttachmentsGrid.Description.Text', N'Description')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Attachments.ascx', N'en', N'AttachmentsGrid.FileNameHeader.Text', N'File Name')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Attachments.ascx', N'en', N'AttachmentsGrid.SizeHeader.Text', N'Size')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Attachments.ascx', N'en', N'CancelUploads', N'Cancel Uploads')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Attachments.ascx', N'en', N'DeleteAttachment', N'Are you sure you want to delete this attachment?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Attachments.ascx', N'en', N'lblAddAttachment.Text', N'Add Attachment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Attachments.ascx', N'en', N'NoAttachments', N'There are no attachments for this issue.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Attachments.ascx', N'en', N'SelectFiles', N'Select files')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Comments.ascx', N'en', N'cmdAddComment.Text', N'Add Comment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Comments.ascx', N'en', N'cmdEditComment.Text', N'Edit Comment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Comments.ascx', N'en', N'DeleteComment', N'Are you sure you want to delete this comment?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Comments.ascx', N'en', N'hlPermalink.Text', N'Permalink')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Comments.ascx', N'en', N'Image1.AlternateText', N'User comment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Comments.ascx', N'en', N'LeaveComment.Text', N'Leave a comment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Comments.ascx', N'en', N'NoComments', N'There are no comments for this issue.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/History.ascx', N'en', N'HistoryDataGrid.CreatorHeader.Text', N'User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/History.ascx', N'en', N'HistoryDataGrid.DateModifiedHeader.Text', N'Date Modified')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/History.ascx', N'en', N'HistoryDataGrid.FieldChangedHeader.Text', N'Item Changed')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/History.ascx', N'en', N'HistoryDataGrid.NewValueHeader.Text', N'New Value')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/History.ascx', N'en', N'HistoryDataGrid.OldValueHeader.Text', N'Previous Value')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/History.ascx', N'en', N'NoHistory', N'This issue has not been modified.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Notifications.ascx', N'en', N'btnAddNot.Text', N'Add >>')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Notifications.ascx', N'en', N'btnDelNot', N'<< Remove')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Notifications.ascx', N'en', N'btnDontRecieveNotfictaions.Text', N'Don''t Receive Notifications')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Notifications.ascx', N'en', N'btnReceiveNotifications.Text', N'Receive Notifications')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Notifications.ascx', N'en', N'lblDescription.Text', N'The following person(s) receive email notifications when this issue is updated:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Notifications.ascx', N'en', N'pnlNotificationAdmin.GroupingText', N'Add Remove Notifications(Managers Only)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/ParentIssues.ascx', N'en', N'btnAdd.Text', N'Add Parent Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/ParentIssues.ascx', N'en', N'CompareValidator1.Text', N'(integer)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/ParentIssues.ascx', N'en', N'lblDescription.Text', N'List all issues on which this issue depends. Enter the ID of the issue in the text box below and click the Add Parent Issue button.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/RelatedIssues.ascx', N'en', N'CompareValidator1.Text', N'(integer)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/RelatedIssues.ascx', N'en', N'lblAddRelatedIssue.Text', N'Add Related Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/RelatedIssues.ascx', N'en', N'lblDescription.Text', N'List all issues on which this issue is related. Enter the ID of the issue in the text box below and click the Add Related Issue button.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/RelatedIssues.ascx', N'en', N'NoRelatedIssues', N'There are no related issues.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Revisions.ascx', N'en', N'IssueRevisionsDataGrid.AuthorHeader.Text', N'Author')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Revisions.ascx', N'en', N'IssueRevisionsDataGrid.MessageHeader.Text', N'Message')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Revisions.ascx', N'en', N'IssueRevisionsDataGrid.RepositoryHeader.Text', N'Repository')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Revisions.ascx', N'en', N'IssueRevisionsDataGrid.RevisionDateHeader.Text', N'Revision Date')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Revisions.ascx', N'en', N'IssueRevisionsDataGrid.RevisionHeader.Text', N'Revision')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/Revisions.ascx', N'en', N'NoRevisions', N'There are no revisions linked to this issue.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/SubIssues.ascx', N'en', N'btnAdd.Text', N'Add Sub Issue')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/SubIssues.ascx', N'en', N'CompareValidator1.Text', N'(integer)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/SubIssues.ascx', N'en', N'lblDescription.Text', N'List all Issues that are dependent on the current issue. Enter the ID of the issue in the text box below and click the Add Sub Issue button.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'AddTimeEntry.Text', N'Add Time Entry')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'cmdAddTimeEntry.Text', N'Add Time Entry')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'CommentOptional', N'(optional - will be added as an issue comment)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'Comments.Text', N'Comments:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'compDateDataTypeValidator.ErrorMessage', N'You must enter a valid date.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'cpTimeEntry.ErrorMessage', N'Date cannot be in the future.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'DateLabel.Text', N'Date:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'DeleteTimeEntry', N'Are you sure you wish to delete this entry?')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'lblDuration.Text', N'Duration:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'NoTimeEntries', N'There are no time tracking reports for this issue.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'RangeValidator1.ErrorMessage', N'Duration is out of range.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'TimeEntriesDataGrid.CommentHeader.Text', N'Comment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'TimeEntriesDataGrid.CreatorHeader.Text', N'User')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'TimeEntriesDataGrid.DurationHeader.Text', N'Hours')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Issues/UserControls/TimeTracking.ascx', N'en', N'TimeEntriesDataGrid.WorkDateHeader.Text', N'Date')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'IssueAdded', N'The following issue has been added to a project that you are monitoring.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'IssueAddedSubject', N'Issue {0} has been added to a project you are monitoring.\n\n[DefaultUrl]Issues/IssueDetail.aspx?id=[Issue_Id]\n{0}')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'IssueUpdated', N'The following issue has been updated: \n\n[DefaultUrl]Issues/IssueDetail.aspx?id=[Issue_Id]\n\nTitle: [Issue_Title]\nProject: [Issue_Project]')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'IssueUpdatedSubject', N'Issue {0} has been updated by {1}')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'IssueUpdatedWithChanges', N'The following issue has been updated: \n\n[DefaultUrl]Issues/IssueDetail.aspx?id=[Issue_Id]\n{0}')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'NewAssignee', N'The following issue has been assigned to you: \n\n[DefaultUrl]Issues/IssueDetail.aspx?id=[Issue_Id]')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'NewAssigneeSubject', N'Issue {0} has been assigned to you')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'NewIssueComment', N'A new comment has been added to the following issue.\n\nTitle: [Issue_Title]\nBy: [Comment_CreatorDisplayName]\nDate: [Comment_DateCreated]\n[Comment]\n\nFollow this link to obtain more information on this issue.\n[DefaultUrl]Issues/IssueDetail.aspx?id=[Issue_Id]')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'NewIssueCommentSubject', N'Issue {0} has a new comment')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'PasswordReminder', N'You have requested a password reminder from {0}. Your password is: {1}')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'PasswordReminderSubject', N'Password Reminder')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'UserRegistered', N'Date: [User_DateCreated]\nName: [User_DisplayName]\n Username: [User_Username]\nEmail: [User_Email]')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Notification', N'en', N'UserRegisteredSubject', N'New User Registration')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ChangeLog.aspx', N'en', N'Page.Title', N'Change Log')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ChangeLog.aspx', N'en', N'TitleLabel.Text', N'Change Log')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'btnNext.Text', N'Next >')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'btnNext.ToolTip', N'Next')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'btnPrevious.Text', N'< Previous')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'btnPrevious.ToolTip', N'Previous')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'CalendarViewLabel.Text', N'View:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'ListItem1.Text', N'Month')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'ListItem2.Text', N'Week')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'ListItem3.Text', N'Issue Due Dates')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectCalendar.aspx', N'en', N'Page.Title', N'Project Calendar')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'ByAssignee.Text', N'Assignee')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'Categories.Text', N'Categories')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'IssuesByAssignee.Text', N'Issues by assignee')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'IssuesByCategory.Text', N'Issues by category')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'IssuesByMilestone.Text', N'Issues by milestone')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'IssuesByPriority.Text', N'Issues by priority')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'IssuesByStatus.Text', N'Issues by status')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'IssuesByType.Text', N'Issues by type')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'MilestonesLabel.Text', N'Milestones')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'OpenIssues.Text', N'(open issues)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'Page.Title', N'Project Summary')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'ProjectMembersRoles.Text', N'Project Members and Roles')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'Unassigned.Text', N'Unassigned')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/ProjectSummary.aspx', N'en', N'Unscheduled.Text', N'Unscheduled')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Days', N'days')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Due', N'due')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'DueIn', N'due in')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Finished', N'finished')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Late', N'late')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Months', N'months')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Page.Title', N'Roadmap')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'ProgressMessage', N'{2}% complete<br/>{0} of {1} issues have been resolved')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'TitleLabel.Text', N'Roadmap')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Today', N'today')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Tomorrow', N'tomorrow')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Weeks', N'weeks')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Years', N'years')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Projects/RoadMap.aspx', N'en', N'Yesterday', N'yesterday')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'btnAddClause.Text', N'Add Clause')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'btnPerformQuery.Text', N'Perform Query')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'btnRemoveClause.Text', N'Remove Clause')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'btnSaveQuery.Text', N'Save Query')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'chkGlobalQuery.Text', N'All all users to run this query')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'lblProject.Text', N'Project:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'Page.Title', N'Query Detail')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'RunQueryError', N'Error in query. Please check query values.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryDetail.aspx', N'en', N'SaveQueryError', N'Could not save query.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryList.aspx', N'en', N'btnAddQuery.Text', N'Add Query')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryList.aspx', N'en', N'btnDeleteQuery.Text', N'Delete Query')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryList.aspx', N'en', N'btnPerformQuery.Text', N'Perform Query')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryList.aspx', N'en', N'lblProject.Text', N'Project:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryList.aspx', N'en', N'Page.Title', N'Query List')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryList.aspx', N'en', N'QueryError', N'Error in query. Please check query values.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Queries/QueryList.aspx', N'en', N'Results.Text', N'Results:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'ConfirmPasswordLabel.Text', N'Please enter your details and confirm your password to register an account.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'EmailLabel.Text', N'Email:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'EmailRequired.ErrorMessage', N'Email is required.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'FirstNameRequired.ErrorMessage', N'First name is required.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'FullNameLabel.Text', N'Display Name:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'FullNameRequired.ErrorMessage', N'Display name is required.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'InstructionsLabel.Text', N'Please enter your details and confirm your password to register an account.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'LastNameRequired.ErrorMessage', N'Last name is required.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'Page.Title', N'Register')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'PasswordCompare.ErrorMessage', N'The Password and Confirmation Password must match.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'PasswordRequired.ErrorMessage', N'Password is required.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'Register.aspx', N'en', N'TitleLabel.Text', N'Sign up for your new account')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/DisplayIssues.ascx', N'en', N'EditPropertiesLabel.Text', N'Edit Properties')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/DisplayIssues.ascx', N'en', N'imgPrivate.AlternativeText', N'This issue is marked as private')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/DisplayIssues.ascx', N'en', N'lblIssues.Text', N'(Sort the results by clicking the column headings)')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/DisplayIssues.ascx', N'en', N'SelectColumnsLinkButton.Text', N'Add / remove columns')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/DisplayIssues.ascx', N'en', N'SelectColumnsLiteral.Text', N'Select columns:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/DisplayIssues.ascx', N'en', N'SetPropertiesLabel.Text', N'Set properties for selected issues:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickCategory.ascx', N'en', N'SelectCategory', N'-- Select Category --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickMilestone.ascx', N'en', N'SelectMilestone', N'-- Select Milestone --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickPriority.ascx', N'en', N'SelectPriority', N'-- Select Priority --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickProject.ascx', N'en', N'SelectProject', N'-- Select Project --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickQuery.ascx', N'en', N'SelectQuery', N'-- Select Query --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickResolution.ascx', N'en', N'SelectResolution', N'-- Select Resolution --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickSingleUser.ascx', N'en', N'SelectUser', N'-- Select User --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickStatus.ascx', N'en', N'SelectStatus', N'-- Select Status --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/PickType.ascx', N'en', N'SelectType', N'-- Select Type --')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'Admin', N'Admin')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'Calendar', N'Calendar')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'ChangeLog', N'Change Log')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'Home', N'Home')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'Issues', N'Issues')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'ProjectSummary', N'Project Summary')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'Queries', N'Queries')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'Reports', N'Reports')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'Roadmap', N'Roadmap')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserControls/TabMenu.ascx', N'en', N'Source', N'Repository')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'cbAssigned.Text', N'Assigned to me')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'cbClosed.Text', N'Closed by me')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'cbInProgress.Text', N'In progress by me')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'cbMonitored.Text', N'Monitored by me')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'cbReported.Text', N'Reported by me')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'cbResolved.Text', N'Resolved by me')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'Label111.Text', N'New Password:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'lblItemPageSize.Text', N'Issue Page Size:')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'PasswordChanged', N'Your password has been changed successfully.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'PasswordChangeError', N'There was an error changing your password.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'ProfileSaved', N'Your profile has been updated.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'ProfileUpdateError', N'An error occrred updating your profile.')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'TreeNode1.Text', N'User Details')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'TreeNode2.Text', N'Manage Password')
INSERT INTO [dbo].[BugNet_StringResources] ([resourceType], [cultureCode], [resourceKey], [resourceValue]) VALUES(N'UserProfile.aspx', N'en', N'TreeNode3.Text', N'Customize')

--Insert New Host Settings
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'AdminNotificationUsername', N'admin')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'AllowedFileExtensions', N'*.*')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'EnabledNotificationTypes', N'Email;MSN')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'EnableRepositoryCreation', N'True')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'FileSizeLimit', N'2024')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'OpenIdAuthentication', N'True')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'RepositoryBackupPath', N'')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'RepositoryRootPath', N'C:\SVN\')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'RepositoryRootUrl', N'svn://localhost/')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'SvnAdminEmailAddress', N'')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES(N'SvnHookPath', N'')
GO

DELETE FROM UserRoles WHERE UserId NOT IN (SELECT U.UserId FROM aspnet_Users U) 
DELETE FROM UserProjects WHERE UserId NOT IN (SELECT U.UserId FROM aspnet_Users U) 
DELETE FROM RelatedBug WHERE LinkedBugID NOT IN (SELECT B.BugID FROM Bug B) 
DELETE FROM BugNotification WHERE BugID NOT IN (SELECT BugID FROM Bug) 
GO

-- Migrate projects
SET IDENTITY_INSERT BugNet_Projects ON
INSERT BugNet_Projects
(
  ProjectId,
  ProjectName,
  ProjectCode,
  ProjectDescription,
  AttachmentUploadPath,
  DateCreated,
  ProjectDisabled,
  ProjectAccessType,
  ProjectManagerUserId,
  ProjectCreatorUserId,
  AllowAttachments,
  AttachmentStorageType,
  SvnRepositoryUrl 
)
SELECT
  ProjectID,
  Name,
  Code,
  Description,
  UploadPath,
  CreateDate,
  CASE Active WHEN 1 THEN 0 ELSE 1 END AS ProjectDisabled, --flip the logic from 7 to 8
  AccessType,
  ManagerUserId,
  CreatorUserId,
  AllowAttachments,
  1, --FileSystem
  ''
FROM 
  Project	  	
SET IDENTITY_INSERT BugNet_Projects OFF
GO

-- Copy Project Members
SET IDENTITY_INSERT BugNet_UserProjects ON
INSERT BugNet_UserProjects
(
  UserId,
  ProjectId,
  UserProjectId,
  DateCreated
)
SELECT
  UserId,
  ProjectId,
  UserProjectId,
  GETDATE()
FROM
  UserProjects where ProjectId in(select ProjectId from BugNet_Projects)and UserId in (select userid from aspnet_Users)
SET IDENTITY_INSERT BugNet_UserProjects OFF
GO

-- Copy Project Roles
SET IDENTITY_INSERT BugNet_Roles ON
INSERT BugNet_Roles
( 
	RoleId,
	ProjectId,
	RoleName,
	RoleDescription,
	AutoAssign
)
SELECT 
	RoleId,
	ProjectId,
	RoleName,
	Description,
	AutoAssign
FROM
	Roles
SET IDENTITY_INSERT BugNet_Roles OFF
GO

-- Copy Userroles
INSERT BugNet_UserRoles
(
	UserId,
	RoleId
)
SELECT 
	UserId,
	RoleId
FROM 
	UserRoles where UserId in (select userid from aspnet_Users)
GO

-- Copy Role Permissions
INSERT BugNet_RolePermissions
(
   PermissionId,
   RoleId
)
SELECT
	PermissionId,
	RoleId
FROM
	RolePermission
GO

-- Copy Application Log Table
SET IDENTITY_INSERT BugNet_ApplicationLog ON
INSERT BugNet_ApplicationLog
(
	Id,
	[Date],
	Thread,
	[Level],
	Logger,
	[User],
	[Message],
	[Exception]	

)
SELECT
	Id,
	[Date],
	Thread,
	[Level],
	Logger,
	[User],
	[Message],
	[Exception]	
FROM
	[Log]

SET IDENTITY_INSERT BugNet_ApplicationLog OFF
GO
	
-- Copy Host Settings
INSERT BugNet_HostSettings
(
	SettingName,
	SettingValue
)
SELECT
	SettingName,
	SettingValue
FROM
	HostSettings
GO

-- Copy Custom Fields
SET IDENTITY_INSERT BugNet_ProjectCustomFields ON
INSERT BugNet_ProjectCustomFields
(
  CustomFieldId,
  ProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
)
SELECT
  CustomFieldId,
  ProjectId,
  CustomFieldName,
  CustomFieldRequired,
  CustomFieldDataType,
  CustomFieldTypeId
FROM
  ProjectCustomFields
SET IDENTITY_INSERT BugNet_ProjectCustomFields OFF
GO

-- Copy Custom Field Selections
SET IDENTITY_INSERT BugNet_ProjectCustomFieldSelections ON
INSERT BugNet_ProjectCustomFieldSelections
(
    CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
)
SELECT 
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionValue,
	CustomFieldSelectionName,
	CustomFieldSelectionSortOrder
FROM 
	ProjectCustomFieldSelection
SET IDENTITY_INSERT BugNet_ProjectCustomFieldSelections OFF
GO
	
-- Copy Categories
SET IDENTITY_INSERT BugNet_ProjectCategories ON
INSERT BugNet_ProjectCategories
(
    CategoryId,
	CategoryName,
	ProjectId,
	ParentCategoryId
)
SELECT 
	ComponentID,
	Name,
	ProjectID,
	ParentComponentID
FROM 
	Component where ProjectId in(select ProjectId from BugNet_Projects)
SET IDENTITY_INSERT BugNet_ProjectCategories OFF
GO
	
	
-- Copy Milestones
SET IDENTITY_INSERT BugNet_ProjectMilestones ON
INSERT BugNet_ProjectMilestones
(
    MilestoneId,
	MilestoneName,
	ProjectId,
	MilestoneImageUrl,
	SortOrder,
	DateCreated,
	MilestoneDueDate
)
SELECT 
	VersionID,
	Name,
	ProjectID,
	'',
	0,
	GETDATE(),
	NULL
FROM 
	[Version]
SET IDENTITY_INSERT BugNet_ProjectMilestones OFF
GO


DECLARE @ProjectId INT
DECLARE @RowNum INT
DECLARE @ProjectCount INT
DECLARE @counter INT
SET @RowNum = 0 

SELECT @ProjectCount = COUNT(ProjectId) FROM Project
SELECT TOP 1 @ProjectId = ProjectId FROM Project

WHILE @RowNum < @ProjectCount

BEGIN
	SET @RowNum = @RowNum + 1
	
	-- Update Milestones Sort Order
	SET @counter = 0
	UPDATE BugNet_ProjectMilestones SET @counter = SortOrder = @counter + 1 WHERE ProjectId = @ProjectId
	
	-- Increment Loop With Next ProjectID
	SELECT TOP 1 @ProjectId=ProjectID FROM Project WHERE ProjectId > @ProjectID 
END
GO

-- Resolutions
SET IDENTITY_INSERT BugNet_ProjectResolutions ON
INSERT BugNet_ProjectResolutions
(
  ResolutionId,
  ProjectId,
  ResolutionName,
  ResolutionImageUrl,
  SortOrder
)
SELECT ROW_NUMBER() OVER (ORDER BY BugNet_Projects.ProjectId,Resolution.ResolutionID) AS ResolutionId, 
	BugNet_Projects.ProjectId, 
	Resolution.Name as ResolutionName, 
	CASE Resolution.ResolutionID
		WHEN 6 THEN 'accept.gif' 
		ELSE '' END
	 AS ResolutionImageUrl, 
	Resolution.ResolutionID as SortOrder
FROM Resolution CROSS JOIN BugNet_Projects
SET IDENTITY_INSERT BugNet_ProjectResolutions OFF
GO
	
-- Issue Types
SET IDENTITY_INSERT BugNet_ProjectIssueTypes ON
INSERT BugNet_ProjectIssueTypes
(
  IssueTypeId,
  ProjectId,
  IssueTypeName,
  IssueTypeImageUrl,
  SortOrder
)
SELECT ROW_NUMBER() OVER (ORDER BY BugNet_Projects.ProjectId,[TYPE].TypeID) AS IssueTypeId, 
	BugNet_Projects.ProjectId, 
	[Type].Name as IssueTypeName, 
	CASE [Type].TypeID
		WHEN 1 THEN 'Any.gif' 
		WHEN 2 THEN 'Bug.gif' 
		WHEN 3 THEN 'NewFeature.gif'
		WHEN 4 THEN 'Task.gif'
		WHEN 5 THEN 'Improvement.gif' 
		ELSE '' END
	 AS IssueTypeImageUrl, 
	[Type].TypeID as SortOrder
FROM [Type] CROSS JOIN BugNet_Projects

SET IDENTITY_INSERT BugNet_ProjectIssueTypes OFF
GO

-- Status	
SET IDENTITY_INSERT BugNet_ProjectStatus ON
INSERT BugNet_ProjectStatus
(
	StatusId,
	ProjectId,
	StatusName,
	StatusImageUrl,
	SortOrder,
	IsClosedState
)
SELECT ROW_NUMBER() OVER (ORDER BY BugNet_Projects.ProjectId,[Status].StatusId) AS StatusId, 
	BugNet_Projects.ProjectId, 
	[Status].Name as StatusName, 
	CASE [Status].StatusId
		WHEN 1 THEN '02.png' --Open, green 
		WHEN 2 THEN '03.png' --In Progress, blue
		WHEN 3 THEN '04.png' --On-Hold, yellow
		WHEN 4 THEN '09.png' --Resolved, light grey
		WHEN 5 THEN '08.png' --Closed, dark grey
		ELSE '' END
	 AS StatusImageUrl, 
	[Status].StatusId as SortOrder,
	0 as IsClosedState
FROM [Status] CROSS JOIN BugNet_Projects
SET IDENTITY_INSERT BugNet_ProjectStatus OFF
GO
	
-- Priorities
SET IDENTITY_INSERT BugNet_ProjectPriorities ON
INSERT BugNet_ProjectPriorities
(
	PriorityID,
	ProjectId,
	PriorityName,
	PriorityImageUrl,
	SortOrder
)
SELECT ROW_NUMBER() OVER (ORDER BY BugNet_Projects.ProjectId,[Priority].PriorityID) AS PriorityID, 
	BugNet_Projects.ProjectId, 
	[Priority].Name as PriorityName, 
	CASE [Priority].PriorityID
		WHEN 1 THEN 'Blocker.gif'
		WHEN 2 THEN 'Critical.gif'
		WHEN 3 THEN 'Major.gif'
		WHEN 4 THEN 'Minor.gif'
		WHEN 5 THEN 'Trivial.gif'
		ELSE '' END
	 AS PriorityImageUrl, 
	[Priority].PriorityID as SortOrder
FROM [Priority] CROSS JOIN BugNet_Projects
SET IDENTITY_INSERT BugNet_ProjectPriorities OFF
GO

CREATE TABLE #NewIssues
	(
		[IssueId] INT,
		[IssueTitle] NVARCHAR(500),
		[IssueDescription] NVARCHAR(MAX) ,
		[IssueStatusId] INT,
		[IssuePriorityId] INT,
		[IssueTypeId] INT,
		[IssueCategoryId] INT,
		[ProjectId] INT,
		[IssueAffectedMilestoneId] INT,
		[IssueResolutionId] INT,
		[IssueCreatorUserId] UNIQUEIDENTIFIER,
		[IssueAssignedUserId] UNIQUEIDENTIFIER,
		[IssueOwnerUserId] UNIQUEIDENTIFIER,
		[IssueDueDate] DATETIME,
		[IssueMilestoneId] INT,
		[IssueVisibility] INT,
		[IssueEstimation] DECIMAL(5, 2),
		[IssueProgress] INT,
		[DateCreated] DATETIME,
		[LastUpdate] DATETIME,
		[LastUpdateUserId] UNIQUEIDENTIFIER,
		[Disabled] BIT
	)

	INSERT #NewIssues
	(
		IssueId,
		IssueTitle,
		IssueDescription,
		IssueStatusId,
		IssuePriorityId,
		IssueTypeId,
		IssueCategoryId,
		ProjectId,
		--IssueAffectedMilestoneId,
		IssueMilestoneId,
		IssueResolutionId,
		IssueCreatorUserId,
		IssueAssignedUserId,
		IssueOwnerUserId,
		IssueDueDate,
		--IssueMilestoneId,
		IssueAffectedMilestoneId,
		IssueVisibility,
		IssueEstimation,
		IssueProgress,
		DateCreated,
		LastUpdate,
		LastUpdateUserId,
		[Disabled]
	)
	SELECT 
		BugId,
		Summary,
		CAST([Description] AS NVARCHAR(MAX)) AS [Description],
		(select StatusId from BugNet_ProjectStatus as s where s.ProjectId = Bug.ProjectId and s.SortOrder = Bug.StatusId) as StatusId,
		(SELECT PriorityId FROM BugNet_ProjectPriorities as p where p.ProjectId = Bug.ProjectId and p.SortOrder = Bug.PriorityId) as PriorityId,
		(SELECT IssueTypeId FROM BugNet_ProjectIssueTypes as t where t.ProjectId = Bug.ProjectId and t.SortOrder = Bug.TypeID) as TypeId,
		ComponentID,
		ProjectID,
			CASE FixedInVersionId 
			when -1 then null --when no version was set the value will be -1 and break the fk so null it out
			--when 5 then null -- missing on my system
			--when 7 then null  -- missing on my system
			ELSE FixedInVersionId
			END 
		AS FixedInVersionId,
		(SELECT ResolutionId FROM BugNet_ProjectResolutions as r where r.ProjectId = Bug.ProjectId and r.SortOrder = Bug.ResolutionID) as ResolutionID,
		ReporterUserId,
		AssignedToUserId,
		ReporterUserId,
		DueDate,
		VersionID,
		Visibility,
		Estimation,
		0,
		ReportedDate,
		LastUpdate,
		LastUpdateUserId,
		0
	FROM
		Bug

GO		
	SET IDENTITY_INSERT BugNet_Issues ON
	INSERT BugNet_Issues
	(
		IssueId,
		IssueTitle,
		IssueDescription,
		IssueStatusId,
		IssuePriorityId,
		IssueTypeId,
		IssueCategoryId,
		ProjectId,
		IssueAffectedMilestoneId,
		IssueResolutionId,
		IssueCreatorUserId,
		IssueAssignedUserId,
		IssueOwnerUserId,
		IssueDueDate,
		IssueMilestoneId,
		IssueVisibility,
		IssueEstimation,
		IssueProgress,
		DateCreated,
		LastUpdate,
		LastUpdateUserId,
		[Disabled]
	)
	SELECT
		IssueId,
		IssueTitle,
		IssueDescription,
		IssueStatusId,
		IssuePriorityId,
		IssueTypeId,
		IssueCategoryId,
		ProjectId,
		IssueAffectedMilestoneId,
		IssueResolutionId,
		IssueCreatorUserId,
		IssueAssignedUserId,
		IssueOwnerUserId,
		IssueDueDate,
		IssueMilestoneId,
		IssueVisibility,
		IssueEstimation,
		IssueProgress,
		DateCreated,
		LastUpdate,
		LastUpdateUserId,
		[Disabled]
	FROM
		#NewIssues
	SET IDENTITY_INSERT BugNet_Issues OFF
	
DROP TABLE #NewIssues
GO
	
-- Copy Custom Field Values
SET IDENTITY_INSERT BugNet_ProjectCustomFieldValues ON
INSERT BugNet_ProjectCustomFieldValues
(
	CustomFieldValueId,
	IssueId,
	CustomFieldId,
	CustomFieldValue
)
SELECT
	CustomFieldValueId,
	BugId,
	CustomFieldId,
	CustomFieldValue
FROM 
	ProjectCustomFieldValues
SET IDENTITY_INSERT BugNet_ProjectCustomFieldValues OFF
GO
	
-- Copy Issue Notifications
SET IDENTITY_INSERT BugNet_IssueNotifications ON
INSERT BugNet_IssueNotifications
(
	IssueNotificationId,
	IssueId,
	UserId
)
SELECT 
	BugNotificationID,
	BugID,
	CreatedUserId
FROM
	BugNotification
SET IDENTITY_INSERT BugNet_IssueNotifications OFF
GO
	
-- Copy Issue History
SET IDENTITY_INSERT BugNet_IssueHistory ON
INSERT BugNet_IssueHistory
(
	IssueHistoryId,
	IssueId,
	FieldChanged,
	OldValue,
	NewValue,
	DateCreated,
	UserId
)
SELECT 
	BugHistoryID,
	BugID,
	FieldChanged,
	OldValue,
	NewValue,
	CreatedDate,
	CreatedUserId
FROM
	BugHistory
SET IDENTITY_INSERT BugNet_IssueHistory OFF
GO

-- Copy Issue Comments
SET IDENTITY_INSERT BugNet_IssueComments ON
INSERT BugNet_IssueComments
(
	IssueCommentId,
	IssueId,
	DateCreated,
	Comment,
	UserId
)
SELECT 
	BugCommentID,
	BugID,
	CreatedDate,
	Comment,
	CreatedUserId
FROM
	BugComment
SET IDENTITY_INSERT BugNet_IssueComments OFF
GO
	
-- Copy Issue Attachments
SET IDENTITY_INSERT BugNet_IssueAttachments ON
INSERT BugNet_IssueAttachments
(
	IssueAttachmentId,
	IssueId,
	[FileName],
	[Description],
	FileSize,
	ContentType,
	DateCreated,
	UserId,
	Attachment
)
SELECT 
	BugAttachmentID,
	BugID,
	[FileName],
	[Description],
	FileSize,
	[TYPE],
	UploadedDate,
	UploadedUserId,
	NULL
FROM
	BugAttachment
SET IDENTITY_INSERT BugNet_IssueAttachments OFF
GO


-- Copy Related Issues
INSERT BugNet_RelatedIssues
(
	PrimaryIssueId,
	SecondaryIssueId,
	RelationType
)
SELECT 
	BugID,
	LinkedBugID,
	1
FROM
	RelatedBug
GO

--work reports
SET IDENTITY_INSERT BugNet_IssueWorkReports ON
INSERT BugNet_IssueWorkReports
(
	IssueWorkReportId,
	IssueId,
	WorkDate,
	Duration,
	IssueCommentId,
	UserId
)
SELECT 
	BugTimeEntryId,
	BugID,
	WorkDate,
	Duration,
	BugCommentId,
	CreatedUserId
FROM
	BugTimeEntry
SET IDENTITY_INSERT BugNet_IssueWorkReports OFF
GO
			
-- Copy Project Mailboxes
SET IDENTITY_INSERT BugNet_ProjectMailBoxes ON
INSERT BugNet_ProjectMailBoxes
(
	ProjectMailboxId,
	Mailbox,
	ProjectId,
	AssignToUserId,
	IssueTypeId
)
SELECT 
	ProjectMailboxId,
	MailBox,
	ProjectId,
	AssignToUserId,
	IssueTypeId
FROM
	ProjectMailBox
SET IDENTITY_INSERT BugNet_ProjectMailBoxes OFF
GO

-- generate user profiles 
TRUNCATE TABLE [BugNet_UserProfiles]
  
INSERT INTO BugNet_UserProfiles
SELECT DISTINCT 
      UserName, 
      UserName AS FirstName, 
      UserName AS LastName, 
      UserName AS DisplayName, 
      50 AS IssuesPageSize, 
      'Email' AS NotificationTypes, 
      'en-US' AS PreferredLocale, 
      GETDATE() AS LastUpdate
FROM aspnet_Users

--Drop all old objects

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProjectMailBox_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProjectMailBox]'))
ALTER TABLE [dbo].[ProjectMailBox] DROP CONSTRAINT [FK_ProjectMailBox_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProjectMailBox_Project]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProjectMailBox]'))
ALTER TABLE [dbo].[ProjectMailBox] DROP CONSTRAINT [FK_ProjectMailBox_Project]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProjectMailBox_Type]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProjectMailBox]'))
ALTER TABLE [dbo].[ProjectMailBox] DROP CONSTRAINT [FK_ProjectMailBox_Type]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RelatedBug_Bug]') AND parent_object_id = OBJECT_ID(N'[dbo].[RelatedBug]'))
ALTER TABLE [dbo].[RelatedBug] DROP CONSTRAINT [FK_RelatedBug_Bug]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProjectCustomFieldSelection_ProjectCustomFields]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProjectCustomFieldSelection]'))
ALTER TABLE [dbo].[ProjectCustomFieldSelection] DROP CONSTRAINT [FK_ProjectCustomFieldSelection_ProjectCustomFields]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProjectCustomFieldValues_Bug]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProjectCustomFieldValues]'))
ALTER TABLE [dbo].[ProjectCustomFieldValues] DROP CONSTRAINT [FK_ProjectCustomFieldValues_Bug]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProjectCustomFieldValues_ProjectCustomFields]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProjectCustomFieldValues]'))
ALTER TABLE [dbo].[ProjectCustomFieldValues] DROP CONSTRAINT [FK_ProjectCustomFieldValues_ProjectCustomFields]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserProjects_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserProjects]'))
ALTER TABLE [dbo].[UserProjects] DROP CONSTRAINT [FK_UserProjects_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserProjects_Project]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserProjects]'))
ALTER TABLE [dbo].[UserProjects] DROP CONSTRAINT [FK_UserProjects_Project]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRoles_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRoles]'))
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRoles_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRoles]'))
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_Roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Permission]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Permission]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Roles_Project]') AND parent_object_id = OBJECT_ID(N'[dbo].[Roles]'))
ALTER TABLE [dbo].[Roles] DROP CONSTRAINT [FK_Roles_Project]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugHistory_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugHistory]'))
ALTER TABLE [dbo].[BugHistory] DROP CONSTRAINT [FK_BugHistory_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugHistory_Bug]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugHistory]'))
ALTER TABLE [dbo].[BugHistory] DROP CONSTRAINT [FK_BugHistory_Bug]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugComment_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugComment]'))
ALTER TABLE [dbo].[BugComment] DROP CONSTRAINT [FK_BugComment_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugComment_Bug]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugComment]'))
ALTER TABLE [dbo].[BugComment] DROP CONSTRAINT [FK_BugComment_Bug]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugTimeEntry_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugTimeEntry]'))
ALTER TABLE [dbo].[BugTimeEntry] DROP CONSTRAINT [FK_BugTimeEntry_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugTimeEntry_Bug]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugTimeEntry]'))
ALTER TABLE [dbo].[BugTimeEntry] DROP CONSTRAINT [FK_BugTimeEntry_Bug]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNotification_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNotification]'))
ALTER TABLE [dbo].[BugNotification] DROP CONSTRAINT [FK_BugNotification_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugNotification_Bug]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugNotification]'))
ALTER TABLE [dbo].[BugNotification] DROP CONSTRAINT [FK_BugNotification_Bug]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Project_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[Project]'))
ALTER TABLE [dbo].[Project] DROP CONSTRAINT [FK_Project_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Project_aspnet_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Project]'))
ALTER TABLE [dbo].[Project] DROP CONSTRAINT [FK_Project_aspnet_Users1]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProjectCustomFields_Project]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProjectCustomFields]'))
ALTER TABLE [dbo].[ProjectCustomFields] DROP CONSTRAINT [FK_ProjectCustomFields_Project]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProjectCustomFields_ProjectCustomFieldType]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProjectCustomFields]'))
ALTER TABLE [dbo].[ProjectCustomFields] DROP CONSTRAINT [FK_ProjectCustomFields_ProjectCustomFieldType]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugAttachment_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugAttachment]'))
ALTER TABLE [dbo].[BugAttachment] DROP CONSTRAINT [FK_BugAttachment_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BugAttachment_Bug]') AND parent_object_id = OBJECT_ID(N'[dbo].[BugAttachment]'))
ALTER TABLE [dbo].[BugAttachment] DROP CONSTRAINT [FK_BugAttachment_Bug]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_aspnet_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_aspnet_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_aspnet_Users1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_aspnet_Users1]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_aspnet_Users2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_aspnet_Users2]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_Component]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Component]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_FixedInVersionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_FixedInVersionId]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_Priority]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Priority]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_Project]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Project]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_ProjectID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_ProjectID]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_Resolution]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Resolution]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_Status]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Status]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_Type]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Type]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bug_Version]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bug]'))
ALTER TABLE [dbo].[Bug] DROP CONSTRAINT [FK_Bug_Version]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Component_Project]') AND parent_object_id = OBJECT_ID(N'[dbo].[Component]'))
ALTER TABLE [dbo].[Component] DROP CONSTRAINT [FK_Component_Project]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Version_Project]') AND parent_object_id = OBJECT_ID(N'[dbo].[Version]'))
ALTER TABLE [dbo].[Version] DROP CONSTRAINT [FK_Version_Project]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetChangeLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetChangeLog]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetRoadMapProgress]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetRoadMapProgress]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_ApplicationLog_GetLogCount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_ApplicationLog_GetLogCount]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Attachment_CreateNewAttachment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Attachment_CreateNewAttachment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Attachment_DeleteAttachment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Attachment_DeleteAttachment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Attachment_GetAttachmentById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Attachment_GetAttachmentById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Attachment_GetAttachmentsByBugId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Attachment_GetAttachmentsByBugId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_CreateNewBug]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_CreateNewBug]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_Delete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugComponentCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugComponentCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugPriorityCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugPriorityCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugsByCriteria]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugsByCriteria]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugStatusCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugStatusCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugTypeCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugTypeCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugUnassignedCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugUnassignedCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugUserCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugUserCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugVersionCountByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugVersionCountByProject]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetMonitoredBugsByUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetMonitoredBugsByUser]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetRoadMap]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetRoadMap]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_UpdateBug]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_UpdateBug]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_BugNotification_CreateNewBugNotification]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_BugNotification_CreateNewBugNotification]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_BugNotification_DeleteBugNotification]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_BugNotification_DeleteBugNotification]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_BugNotification_GetBugNotificationsByBugId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_BugNotification_GetBugNotificationsByBugId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Comment_CreateNewComment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Comment_CreateNewComment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Comment_DeleteComment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Comment_DeleteComment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Comment_GetCommentById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Comment_GetCommentById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Comment_GetCommentsByBugId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Comment_GetCommentsByBugId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Comment_UpdateComment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Comment_UpdateComment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Component_CreateNewComponent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Component_CreateNewComponent]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Component_DeleteComponent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Component_DeleteComponent]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Component_GetChildComponentsByComponentId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Component_GetChildComponentsByComponentId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Component_GetComponentById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Component_GetComponentById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Component_GetComponentsByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Component_GetComponentsByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Component_GetRootComponentsByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Component_GetRootComponentsByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Component_UpdateComponent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Component_UpdateComponent]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomField_CreateNewCustomField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomField_CreateNewCustomField]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomField_DeleteCustomField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomField_DeleteCustomField]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomField_GetCustomFieldsByBugId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomField_GetCustomFieldsByBugId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomField_GetCustomFieldsByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomField_GetCustomFieldsByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomField_SaveCustomFieldValue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomField_SaveCustomFieldValue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomFieldSelection_CreateNewCustomFieldSelection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomFieldSelection_CreateNewCustomFieldSelection]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomFieldSelection_DeleteCustomFieldSelection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomFieldSelection_DeleteCustomFieldSelection]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomFieldSelection_GetCustomFieldSelection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomFieldSelection_GetCustomFieldSelection]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_CustomFieldSelection_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_CustomFieldSelection_Update]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_History_CreateNewHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_History_CreateNewHistory]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_History_GetHistoryByBugId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_History_GetHistoryByBugId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_HostSettings_GetHostSettings]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_HostSettings_GetHostSettings]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_HostSettings_UpdateHostSetting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_HostSettings_UpdateHostSetting]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Priority_GetAllPriorities]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Priority_GetAllPriorities]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Priority_GetPriorityById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Priority_GetPriorityById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Project_GetProjectsByUserName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Project_GetProjectsByUserName]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedBug_CreateNewRelatedBug]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedBug_CreateNewRelatedBug]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedBug_DeleteRelatedBug]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedBug_DeleteRelatedBug]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedBug_GetRelatedBugsByBugId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_RelatedBug_GetRelatedBugsByBugId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Resolution_GetAllResolutions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Resolution_GetAllResolutions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Resolution_GetResolutionById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Resolution_GetResolutionById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Status_GetAllStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Status_GetAllStatus]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Status_GetStatusById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Status_GetStatusById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_TimeEntry_CreateNewTimeEntry]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_TimeEntry_CreateNewTimeEntry]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_TimeEntry_DeleteTimeEntry]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_TimeEntry_DeleteTimeEntry]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_TimeEntry_GetProjectWorkerWorkReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_TimeEntry_GetProjectWorkerWorkReport]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_TimeEntry_GetWorkerOverallWorkReportByWorkerId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_TimeEntry_GetWorkReportByBugId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_TimeEntry_GetWorkReportByBugId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_TimeEntry_GetWorkReportByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_TimeEntry_GetWorkReportByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Type_GetAllTypes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Type_GetAllTypes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Type_GetTypeById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Type_GetTypeById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Version_CreateNewVersion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Version_CreateNewVersion]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Version_DeleteVersion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Version_DeleteVersion]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Version_GetVersionById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Version_GetVersionById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Version_GetVersionByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Version_GetVersionByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Version_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Version_Update]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetBugsByProjectId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetBugsByProjectId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Bug_GetRecentlyAddedBugsByProject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BugNet_Bug_GetRecentlyAddedBugsByProject]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[BugsView]'))
DROP VIEW [dbo].[BugsView]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugAttachment]') AND type in (N'U'))
DROP TABLE [dbo].[BugAttachment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugComment]') AND type in (N'U'))
DROP TABLE [dbo].[BugComment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugHistory]') AND type in (N'U'))
DROP TABLE [dbo].[BugHistory]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugNotification]') AND type in (N'U'))
DROP TABLE [dbo].[BugNotification]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BugTimeEntry]') AND type in (N'U'))
DROP TABLE [dbo].[BugTimeEntry]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Component]') AND type in (N'U'))
DROP TABLE [dbo].[Component]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Status]') AND type in (N'U'))
DROP TABLE [dbo].[Status]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Type]') AND type in (N'U'))
DROP TABLE [dbo].[Type]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserProjects]') AND type in (N'U'))
DROP TABLE [dbo].[UserProjects]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Resolution]') AND type in (N'U'))
DROP TABLE [dbo].[Resolution]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HostSettings]') AND type in (N'U'))
DROP TABLE [dbo].[HostSettings]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Log]') AND type in (N'U'))
DROP TABLE [dbo].[Log]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Priority]') AND type in (N'U'))
DROP TABLE [dbo].[Priority]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RelatedBug]') AND type in (N'U'))
DROP TABLE [dbo].[RelatedBug]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProjectCustomFieldValues]') AND type in (N'U'))
DROP TABLE [dbo].[ProjectCustomFieldValues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProjectCustomFieldSelection]') AND type in (N'U'))
DROP TABLE [dbo].[ProjectCustomFieldSelection]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProjectMailBox]') AND type in (N'U'))
DROP TABLE [dbo].[ProjectMailBox]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Version]') AND type in (N'U'))
DROP TABLE [dbo].[Version]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRoles]') AND type in (N'U'))
DROP TABLE [dbo].[UserRoles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RolePermission]') AND type in (N'U'))
DROP TABLE [dbo].[RolePermission]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Permission]') AND type in (N'U'))
DROP TABLE [dbo].[Permission]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
DROP TABLE [dbo].[Roles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProjectCustomFields]') AND type in (N'U'))
DROP TABLE [dbo].[ProjectCustomFields]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProjectCustomFieldType]') AND type in (N'U'))
DROP TABLE [dbo].[ProjectCustomFieldType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Project]') AND type in (N'U'))
DROP TABLE [dbo].[Project]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Bug]') AND type in (N'U'))
DROP TABLE [dbo].[Bug]
GO

COMMIT

SET NOEXEC OFF
GO


