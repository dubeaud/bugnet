CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]
	@MilestoneId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectMilestones WHERE MilestoneId = @MilestoneId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE ((IssueMilestoneId = @MilestoneId) OR (IssueAffectedMilestoneId = @MilestoneId))
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
