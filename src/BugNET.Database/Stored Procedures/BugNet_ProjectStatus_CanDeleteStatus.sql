CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_CanDeleteStatus]
	@StatusId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectStatus WHERE StatusId = @StatusId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueStatusId = @StatusId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
