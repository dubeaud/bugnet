CREATE VIEW [dbo].[BugNet_UserView]
AS
SELECT  
	dbo.AspNetUsers.Id AS UserId, dbo.BugNet_UserProfiles.FirstName, dbo.BugNet_UserProfiles.LastName, dbo.BugNet_UserProfiles.DisplayName, 
    dbo.AspNetUsers.UserName, dbo.AspNetUsers.Email, dbo.AspNetUsers.IsApproved, dbo.BugNet_UserProfiles.IssuesPageSize, dbo.BugNet_UserProfiles.PreferredLocale
FROM    
	dbo.AspNetUsers INNER JOIN dbo.BugNet_UserProfiles ON dbo.AspNetUsers.UserName = dbo.BugNet_UserProfiles.UserName
GROUP BY 
	dbo.AspNetUsers.Id, dbo.AspNetUsers.UserName, dbo.AspNetUsers.Email, dbo.AspNetUsers.IsApproved, dbo.BugNet_UserProfiles.FirstName, 
	dbo.BugNet_UserProfiles.LastName, dbo.BugNet_UserProfiles.DisplayName, 
    dbo.BugNet_UserProfiles.IssuesPageSize, dbo.BugNet_UserProfiles.PreferredLocale
