CREATE VIEW [dbo].[BugNet_IssueMilestoneCountView]
AS
SELECT     dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueMilestoneId, 0) AS MilestoneId, dbo.BugNet_IssuesView.MilestoneName, 
                      dbo.BugNet_IssuesView.MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectMilestones.SortOrder, 99999) AS SortOrder, 
                      COUNT(DISTINCT dbo.BugNet_IssuesView.IssueId) AS Number
FROM         dbo.BugNet_IssuesView LEFT OUTER JOIN
                      dbo.BugNet_ProjectMilestones ON dbo.BugNet_IssuesView.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId
WHERE     (dbo.BugNet_IssuesView.Disabled = 0) AND (dbo.BugNet_IssuesView.IsClosed = 0)
GROUP BY dbo.BugNet_IssuesView.ProjectId, ISNULL(dbo.BugNet_IssuesView.IssueMilestoneId, 0), ISNULL(dbo.BugNet_ProjectMilestones.SortOrder, 99999), 
                      dbo.BugNet_IssuesView.MilestoneName, dbo.BugNet_IssuesView.MilestoneImageUrl
