IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[BugNet_IssueCommentsView]'))
DROP VIEW [BugNet_IssueCommentsView]
GO

CREATE VIEW [BugNet_IssueCommentsView]
AS
SELECT     dbo.BugNet_IssueComments.IssueCommentId, dbo.BugNet_IssueComments.IssueId, dbo.BugNet_IssuesView.ProjectId, dbo.BugNet_IssueComments.Comment, 
                      dbo.BugNet_IssueComments.DateCreated, dbo.BugNet_UserView.UserId AS CreatorUserId, dbo.BugNet_UserView.DisplayName AS CreatorDisplayName, 
                      dbo.BugNet_UserView.UserName AS CreatorUserName, dbo.BugNet_IssuesView.Disabled AS IssueDisabled, dbo.BugNet_IssuesView.IsClosed AS IssueIsClosed, 
                      dbo.BugNet_IssuesView.IssueVisibility, dbo.BugNet_IssuesView.ProjectCode, dbo.BugNet_IssuesView.ProjectName, dbo.BugNet_IssuesView.ProjectDisabled
FROM         dbo.BugNet_IssuesView INNER JOIN
                      dbo.BugNet_IssueComments ON dbo.BugNet_IssuesView.IssueId = dbo.BugNet_IssueComments.IssueId INNER JOIN
                      dbo.BugNet_UserView ON dbo.BugNet_IssueComments.UserId = dbo.BugNet_UserView.UserId

GO