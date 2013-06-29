CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_GetLog] 
@FilterType nvarchar(50) = NULL
AS


SELECT L.* FROM BugNet_ApplicationLog L 
WHERE  
((@FilterType IS NULL) OR (Level = @FilterType))
ORDER BY L.Date DESC
