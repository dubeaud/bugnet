CREATE VIEW [dbo].[BugNet_UserView]
AS
SELECT     dbo.Users.UserId, dbo.BugNet_UserProfiles.FirstName, dbo.BugNet_UserProfiles.LastName, dbo.BugNet_UserProfiles.DisplayName, 
                      dbo.Users.UserName, dbo.Memberships.Email, 
                      dbo.Memberships.IsApproved, dbo.Memberships.IsLockedOut, dbo.Users.IsAnonymous,
                      dbo.Users.LastActivityDate, dbo.BugNet_UserProfiles.IssuesPageSize, dbo.BugNet_UserProfiles.PreferredLocale
FROM         dbo.Users INNER JOIN
                      dbo.Memberships ON dbo.Users.UserId = dbo.Memberships.UserId INNER JOIN
                      dbo.BugNet_UserProfiles ON dbo.Users.UserName = dbo.BugNet_UserProfiles.UserName
GROUP BY dbo.Users.UserId, dbo.Users.UserName, dbo.Memberships.Email, dbo.Memberships.IsApproved, dbo.Memberships.IsLockedOut, dbo.Users.IsAnonymous, 
                      dbo.Users.LastActivityDate, dbo.BugNet_UserProfiles.FirstName, dbo.BugNet_UserProfiles.LastName, dbo.BugNet_UserProfiles.DisplayName, 
                      dbo.BugNet_UserProfiles.IssuesPageSize, dbo.BugNet_UserProfiles.PreferredLocale
