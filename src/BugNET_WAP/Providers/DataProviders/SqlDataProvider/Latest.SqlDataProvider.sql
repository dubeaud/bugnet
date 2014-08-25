IF OBJECT_ID('AspNetUserRoles', 'U') IS NOT NULL
BEGIN
DROP TABLE AspNetUserRoles;
END

IF OBJECT_ID('AspNetUserClaims', 'U') IS NOT NULL
BEGIN
DROP TABLE AspNetUserClaims;
END

IF OBJECT_ID('AspNetUserLogins', 'U') IS NOT NULL
BEGIN
DROP TABLE AspNetUserLogins;
END

IF OBJECT_ID('AspNetRoles', 'U') IS NOT NULL
BEGIN
DROP TABLE AspNetRoles;
END

IF OBJECT_ID('AspNetUsers', 'U') IS NOT NULL
BEGIN
DROP TABLE AspNetUsers;
END

CREATE TABLE [dbo].[AspNetUsers](
	[Id] [uniqueidentifier] NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC),
 );
GO

INSERT INTO AspNetUsers([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled],[AccessFailedCount],[UserName])
SELECT Users.UserId, Memberships.Email, 1, (Memberships.Password+'|'+CAST(Memberships.PasswordFormat as varchar)+'|'+Memberships.PasswordSalt), NewID(), 0, 0, 0, 0, Users.UserName
FROM Users
LEFT OUTER JOIN Memberships ON Memberships.ApplicationId = Users.ApplicationId 
AND Users.UserId = Memberships.UserId;
GO

CREATE TABLE [dbo].[AspNetRoles](
	[Id] [uniqueidentifier] NOT NULL,
	[ProjectId] [int] NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[AutoAssign] [bit] NOT NULL
	CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

--INSERT INTO AspNetRoles(Id, ProjectId, Name, [Description], AutoAssign)
--SELECT RoleId, ProjectId, RoleName, RoleDescription, AutoAssign
--FROM BugNet_Roles;
--GO

CREATE TABLE [dbo].[AspNetUserRoles] (
   [UserId] [uniqueidentifier] NOT NULL,
   [RoleId] [uniqueidentifier] NOT NULL,
   CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
   CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE,
   CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

--INSERT INTO AspNetUserRoles(UserId,RoleId)
--SELECT UserId,RoleId
--FROM BugNet_UserRoles;
--GO

CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC, [UserId] ASC),
	CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

