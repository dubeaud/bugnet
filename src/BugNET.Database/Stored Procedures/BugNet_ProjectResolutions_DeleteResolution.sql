CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_DeleteResolution]
 	@ResolutionIdToDelete INT
AS
DELETE
	BugNet_ProjectResolutions
WHERE
	ResolutionId = @ResolutionIdToDelete

IF @@ROWCOUNT > 0 
	RETURN 0
ELSE
	RETURN 1
