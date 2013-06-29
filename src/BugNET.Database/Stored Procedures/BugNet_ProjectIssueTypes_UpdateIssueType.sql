CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_UpdateIssueType]
	@ProjectId int,
	@IssueTypeId int,
	@IssueTypeName NVARCHAR(50),
	@IssueTypeImageUrl NVARCHAR(255),
	@SortOrder int
AS

DECLARE @OldSortOrder int
DECLARE @OldIssueTypeId int

SELECT @OldSortOrder = SortOrder  FROM BugNet_ProjectIssueTypes WHERE IssueTypeId = @IssueTypeId
SELECT @OldIssueTypeId = IssueTypeId FROM BugNet_ProjectIssueTypes WHERE SortOrder = @SortOrder  AND ProjectId = @ProjectId


UPDATE BugNet_ProjectIssueTypes SET
	ProjectId = @ProjectId,
	IssueTypeName = @IssueTypeName,
	IssueTypeImageUrl = @IssueTypeImageUrl,
	SortOrder = @SortOrder
WHERE IssueTypeId = @IssueTypeId

UPDATE BugNet_ProjectIssueTypes SET
	SortOrder = @OldSortOrder
WHERE IssueTypeId = @OldIssueTypeId
