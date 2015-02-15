CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_DeleteProjectMailbox]
	@ProjectMailboxId int
AS
DELETE  
	BugNet_ProjectMailBoxes 
WHERE
	ProjectMailboxId = @ProjectMailboxId

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
