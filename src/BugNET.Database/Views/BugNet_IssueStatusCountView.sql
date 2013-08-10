CREATE VIEW [dbo].[BugNet_IssueStatusCountView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueStatusId, 0) AS StatusId, dbo.BugNet_IssuesView.StatusName, 
                      dbo.BugNet_IssuesView.StatusImageUrl, ISNULL(dbo.BugNet_ProjectStatus.SortOrder, 99) AS SortOrder, COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) 
                      AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_ProjectStatus ON dbo.BugNet_IssuesView.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId
GROUP BY dbo.BugNet_IssuesView.StatusName, dbo.BugNet_IssuesView.StatusImageUrl, ISNULL(dbo.BugNet_ProjectStatus.SortOrder, 99), dbo.BugNet_IssuesView.ProjectId, 
                      dbo.BugNet_IssuesView.Disabled, ISNULL(dbo.BugNet_IssuesView.IssueStatusId, 0)
HAVING      (dbo.BugNet_IssuesView.Disabled = 0)
ORDER BY dbo.BugNet_IssuesView.ProjectId
