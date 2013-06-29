CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestoneById]
 @MilestoneId INT
AS
SELECT
	MilestoneId,
	ProjectId,
	MilestoneName,
	MilestoneImageUrl,
	SortOrder,
	MilestoneDueDate,
	MilestoneReleaseDate,
	MilestoneNotes,
	MilestoneCompleted
FROM 
	BugNet_ProjectMilestones
WHERE
	MilestoneId = @MilestoneId
