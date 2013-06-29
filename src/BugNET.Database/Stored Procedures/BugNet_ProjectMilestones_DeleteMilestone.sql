CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_DeleteMilestone]
	@MilestoneIdToDelete INT
AS
DELETE 
	BugNet_ProjectMilestones
WHERE
	MilestoneId = @MilestoneIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
