CREATE  PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]
	@ProjectId int
AS

SET NOCOUNT ON

SELECT 
	BugNet_ProjectMailboxes.*,
	u.UserName AssignToUserName,
	u.DisplayName AssignToDisplayName,
	pit.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN AspNetUsers u ON u.Id = AssignToUserId
	INNER JOIN BugNet_ProjectIssueTypes pit ON pit.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId		
WHERE
	BugNet_ProjectMailBoxes.ProjectId = @ProjectId
