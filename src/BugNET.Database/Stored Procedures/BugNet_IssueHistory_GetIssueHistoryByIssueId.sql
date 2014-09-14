CREATE PROCEDURE [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]
	@IssueId int
AS
 SELECT
	IssueHistoryId,
	IssueId,
	U.UserName CreatorUserName,
	IsNull(DisplayName,'') CreatorDisplayName,
	FieldChanged,
	OldValue,
	NewValue,
	DateCreated
FROM 
	BugNet_IssueHistory
	INNER JOIN AspNetUsers U ON BugNet_IssueHistory.UserId = U.Id
WHERE 
	IssueId = @IssueId
ORDER BY
	DateCreated DESC
