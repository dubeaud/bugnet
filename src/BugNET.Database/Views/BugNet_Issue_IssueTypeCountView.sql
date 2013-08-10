CREATE VIEW [dbo].[BugNet_Issue_IssueTypeCountView]
AS
SELECT     TOP (100) PERCENT dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueTypeId, 0) AS IssueTypeId, dbo.BugNet_IssuesView.IssueTypeName, 
                      dbo.BugNet_IssuesView.IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectIssueTypes.SortOrder, 99) AS SortOrder, COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) 
                      AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_IssuesView.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId
WHERE     (dbo.BugNet_IssuesView.IsClosed = 0) AND (dbo.BugNet_IssuesView.Disabled = 0)
GROUP BY dbo.BugNet_IssuesView.IssueTypeName, dbo.BugNet_IssuesView.IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectIssueTypes.SortOrder, 99), 
                      dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueTypeId, 0)
ORDER BY dbo.BugNet_IssuesView.ProjectId
