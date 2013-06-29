CREATE VIEW [dbo].[BugNet_IssuePriorityCountView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssuePriorityId, '0') AS PriorityId, dbo.BugNet_IssuesView.PriorityName, 
                      dbo.BugNet_IssuesView.PriorityImageUrl, ISNULL(dbo.BugNet_ProjectPriorities.SortOrder, 99) AS SortOrder, COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) 
                      AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_ProjectPriorities ON dbo.BugNet_IssuesView.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId
WHERE     (dbo.BugNet_IssuesView.Disabled = 0) AND (dbo.BugNet_IssuesView.IsClosed = 0)
GROUP BY dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssuePriorityId, '0'), dbo.BugNet_IssuesView.PriorityName, 
                      dbo.BugNet_IssuesView.PriorityImageUrl, ISNULL(dbo.BugNet_ProjectPriorities.SortOrder, 99)
ORDER BY dbo.BugNet_IssuesView.ProjectId
