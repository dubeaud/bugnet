CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]
	@ProjectId INT,
	@MilestoneCompleted bit
AS
SELECT * FROM BugNet_ProjectMilestones WHERE ProjectId = @ProjectId AND 
MilestoneCompleted = (CASE WHEN  @MilestoneCompleted = 1 THEN MilestoneCompleted ELSE @MilestoneCompleted END) ORDER BY SortOrder ASC
