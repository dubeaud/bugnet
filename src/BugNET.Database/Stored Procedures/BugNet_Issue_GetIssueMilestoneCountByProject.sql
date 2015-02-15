CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject] 
	@ProjectId int
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT v.MilestoneName, COUNT(nt.IssueMilestoneId) AS 'Number', v.MilestoneId, v.MilestoneImageUrl
	FROM BugNet_ProjectMilestones v 
	LEFT OUTER JOIN
	(SELECT IssueMilestoneId
	FROM   
		BugNet_IssuesView
	WHERE  
		BugNet_IssuesView.Disabled = 0 
		AND BugNet_IssuesView.IsClosed = 0) nt 
	ON 
		v.MilestoneId = nt.IssueMilestoneId 
	WHERE 
		(v.ProjectId = @ProjectId) AND v.MilestoneCompleted = 0
	GROUP BY 
		v.MilestoneName, v.MilestoneId,v.SortOrder, v.MilestoneImageUrl
	ORDER BY 
		v.SortOrder ASC
END
