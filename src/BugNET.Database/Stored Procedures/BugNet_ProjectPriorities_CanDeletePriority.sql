CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_CanDeletePriority]
	@PriorityId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectPriorities WHERE PriorityId = @PriorityId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssuePriorityId = @PriorityId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
