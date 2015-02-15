CREATE VIEW [dbo].[BugNet_IssueAssignedToCountView]
AS
SELECT     dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueAssignedUserId, '00000000-0000-0000-0000-000000000000') AS AssignedUserId, 
                      dbo.BugNet_IssuesView.AssignedDisplayName AS AssignedName, '' AS AssignedImageUrl, CASE WHEN dbo.BugNet_IssuesView.IssueAssignedUserId IS NULL 
                      THEN 999 ELSE 0 END AS SortOrder, COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_UserView ON dbo.BugNet_IssuesView.IssueAssignedUserId = dbo.BugNet_UserView.UserId
WHERE     (dbo.BugNet_IssuesView.IsClosed = 0) AND (dbo.BugNet_IssuesView.Disabled = 0)
GROUP BY dbo.BugNet_IssuesView.ProjectId, dbo.BugNet_IssuesView.AssignedDisplayName, CASE WHEN dbo.BugNet_IssuesView.IssueAssignedUserId IS NULL 
                      THEN 999 ELSE 0 END, ISNULL(dbo.BugNet_IssuesView.IssueAssignedUserId, '00000000-0000-0000-0000-000000000000')
