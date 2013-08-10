CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_DeletePriority]
 @PriorityIdToDelete	INT
AS
DELETE 
	BugNet_ProjectPriorities
WHERE
	PriorityId = @PriorityIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
