CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]
    @mailbox nvarchar(100) 
AS

SET NOCOUNT ON

SELECT 
	BugNet_ProjectMailboxes.*,
	u.UserName AssignToUserName,
	p.DisplayName AssignToDisplayName,
	pit.IssueTypeName
FROM 
	BugNet_ProjectMailBoxes
	INNER JOIN Users u ON u.UserId = AssignToUserId
	INNER JOIN BugNet_UserProfiles p ON u.UserName = p.UserName
	INNER JOIN BugNet_ProjectIssueTypes pit ON pit.IssueTypeId = BugNet_ProjectMailboxes.IssueTypeId	
WHERE
	BugNet_ProjectMailBoxes.MailBox = @mailbox
