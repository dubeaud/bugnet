CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_CanDeleteResolution]
	@ResolutionId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectResolutions WHERE ResolutionId = @ResolutionId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueResolutionId = @ResolutionId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
