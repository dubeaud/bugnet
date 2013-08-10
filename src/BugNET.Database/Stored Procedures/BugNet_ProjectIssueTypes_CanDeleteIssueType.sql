CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CanDeleteIssueType]
	@IssueTypeId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectIssueTypes WHERE IssueTypeId = @IssueTypeId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueTypeId = @IssueTypeId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
