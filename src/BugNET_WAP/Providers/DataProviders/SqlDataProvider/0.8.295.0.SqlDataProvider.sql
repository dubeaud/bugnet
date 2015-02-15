/**************************************************************************
-- -SqlDataProvider                    
-- -Date/Time: Aug 26, 2010 		
**************************************************************************/
SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

BEGIN TRAN
GO

INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ExcludeClosedIssuesFilter.Text','Exclude Closed Issues')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','MyIssuesPage_Title.Text','Issue Summary For <span>{0}</span>')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ProjectListBoxFilter_SelectAll.Text','Select All')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ProjectListFilterLabel.Text','Project:')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','Statistics_Title.Text','Statistics <span style="font-size:11px;">(Total Issues)</span>')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ViewIssuesDropDownFilter_Assigned.Text','Assigned to You')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ViewIssuesDropDownFilter_Closed.Text','Closed by You')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ViewIssuesDropDownFilter_Created.Text','Created by You')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ViewIssuesDropDownFilter_Monitored.Text','Monitored by You')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ViewIssuesDropDownFilter_Owned.Text','Owned by You')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ViewIssuesDropDownFilter_Relevant.Text','Relevant to You')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ViewIssuesDropDownFilter_Select.Text','-- Select a View --')
INSERT INTO [BugNet_StringResources] ([resourceType],[cultureCode],[resourceKey],[resourceValue])VALUES('Issues/MyIssues.aspx','en','ViewIssuesFilterLabel.Text','View Issues:')
GO

 
/****** Object:  Index [IX_BugNet_RelatedIssues] ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_RelatedIssues]') AND name = N'IX_BugNet_RelatedIssues')
DROP INDEX [IX_BugNet_RelatedIssues] ON [dbo].[BugNet_RelatedIssues] WITH ( ONLINE = OFF )
GO
 
CREATE NONCLUSTERED INDEX [IX_BugNet_RelatedIssues] ON [dbo].[BugNet_RelatedIssues] 
(
	[SecondaryIssueId] ASC,
	[RelationType] ASC
)WITH (PAD_INDEX  = OFF, FILLFACTOR = 80, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

COMMIT
GO

SET NOEXEC OFF
GO