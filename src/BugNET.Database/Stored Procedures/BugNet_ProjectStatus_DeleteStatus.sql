CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_DeleteStatus]
 	@StatusIdToDelete INT
AS
DELETE
	BugNet_ProjectStatus
WHERE
	StatusId = @StatusIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
