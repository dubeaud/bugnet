/* PROJECT MAILBOXES */
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes] DROP CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes] DROP CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users] FOREIGN KEY([AssignToUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes] CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_aspnet_Users]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes] FOREIGN KEY([IssueTypeId])
REFERENCES [dbo].[BugNet_ProjectIssueTypes] ([IssueTypeId])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]') AND type = 'F')
ALTER TABLE [BugNet_ProjectMailBoxes] CHECK CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes]
GO

/* ISSUE VOTES */
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes] DROP CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_BugNet_Issues]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes] DROP CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues]
GO

DELETE
FROM BugNet_IssueVotes
WHERE IssueId NOT IN (SELECT IssueId FROM BugNet_Issues)
GO

DELETE
FROM BugNet_IssueVotes
WHERE UserId NOT IN (SELECT UserId FROM aspnet_Users)
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_aspnet_Users]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes] CHECK CONSTRAINT [FK_BugNet_IssueVotes_aspnet_Users]
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_BugNet_Issues]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues] FOREIGN KEY([IssueId])
REFERENCES [dbo].[BugNet_Issues] ([IssueId])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FK_BugNet_IssueVotes_BugNet_Issues]') AND type = 'F')
ALTER TABLE [BugNet_IssueVotes] CHECK CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues]
GO


